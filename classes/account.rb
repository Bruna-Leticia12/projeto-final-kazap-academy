require_relative 'deposit'
require_relative 'withdraw'
require_relative 'transfer'

class Account < Sequel::Model
    many_to_one :clients

    OVERDRAFT_LIMIT = 100.0
    TED_FEE = 1.01
    
    def setup(balance, balance_atualizado, transactions)
        @balance = balance
        @balance_atualizado = balance_atualizado
        @transactions = transactions
    end

    def login(account_number)
        accounts = DB[:accounts]
        
        x = accounts.map do |el|
            el
        end

        client_info = x.select { |account| account[:number] == account_number }

        if client_info.empty? 
            puts "Esta conta é inválida"
        else 
            client_info
        end
    end

    def deposit(client_info, account, value, recipient_account)        
        accounts = DB[:accounts]

        deposit_created = Deposit.new(
            account_number: account,
            recipient_account_number: recipient_account,
            value: value
        )

        if recipient_account == account
            updated_balance = client_info[0][:balance] + value

            accounts.where(id: client_info[0][:id]).update(balance: updated_balance)

            deposit_created.save

        elsif accounts.where(number: recipient_account).all.empty?
            puts "Conta inválida"

        elsif recipient_account == accounts.where(number: recipient_account).all[0][:number]
            recipient_account = accounts.where(number: recipient_account).all[0]
            
            balance = recipient_account[:balance]
            
            recipient_account_id = recipient_account[:id]
            
            updated_balance = balance + value
                       
            accounts.where(id: recipient_account_id).update(balance: updated_balance)

            deposit_created.save
        end
    end


    def withdraw(client_info, account, value)
        
        accounts = DB[:accounts]

        updated_balance = client_info[0][:balance] - value

        withdraw_created = Withdraw.new(
            account_number: account,
            value: updated_balance
        )

        if value <= client_info[0][:balance]
            accounts.where(id: client_info[0][:id]).update(balance: updated_balance)
    
            withdraw_created.save
            puts "Saque realizado com sucesso!"
        elsif value <= client_info[0][:balance] + OVERDRAFT_LIMIT
            accounts.where(id: client_info[0][:id]).update(balance: updated_balance)

            withdraw_created.save

            puts "Saque realizado com sucesso!"
            puts "Você utilizou R$ #{updated_balance} do seu cheque especial."
        else
            puts "Saldo e Limite insuficiente."
        end
    end

    def check_balance(client_info, account)
        puts "Conta:  #{account}"
        puts "Saldo:  #{client_info[0][:balance]}"
    end

    def transfer(client_info, account, value, transaction_type, recipient_account)
       accounts = DB[:accounts]

        transfer_created = Transfer.new(
            account_number: client_info[0][:number], 
            recipient_account_number: recipient_account,
            type: transaction_type,
            value: value
        )

        if transaction_type == 'pix' || (transaction_type == 'ted' && recipient_account == account)
            
            if value <= client_info[0][:balance] || value <= client_info[0][:balance] + OVERDRAFT_LIMIT
                #1. tirar valor da minha conta
                updated_balance = client_info[0][:balance] - value
                accounts.where(id: client_info[0][:id]).update(balance: updated_balance)
                
            
                #2. colocar este valor na conta do recipient
                recipient_account = accounts.where(number: recipient_account).all[0]
                recipient_account_id = recipient_account[:id]
                balance = recipient_account[:balance]
            
                recipient_updated_balance = balance + value
                
                accounts.where(id: recipient_account_id).update(balance: recipient_updated_balance)

                #3. criar uma linha na tabela tranfers
                transfer_created.save
                
                puts "Tranferência realizada com sucesso!"

                if updated_balance < 0
                    puts "Você utilizou #{updated_balance} do seu cheque especial."
                end
            
            else
                puts "Tranferência não realizada. Seu saldo é insuficiente."         
            end    

        elsif transaction_type == 'ted' && recipient_account != account
            value_with_ted_fee = value * TED_FEE

            if value_with_ted_fee <= client_info[0][:balance] || value_with_ted_fee <= client_info[0][:balance] + OVERDRAFT_LIMIT
                #1. tirar valor da minha conta
                updated_balance = client_info[0][:balance] - value_with_ted_fee 
                accounts.where(id: client_info[0][:id]).update(balance: updated_balance)

                #2. colocar este valor na conta do recipient
                recipient_account = accounts.where(number: recipient_account).all[0]
                recipient_account_id = recipient_account[:id]
                balance = recipient_account[:balance]

                recipient_updated_balance = balance + value

                accounts.where(id: recipient_account_id).update(balance: recipient_updated_balance)

                #3. criar uma linha na tabela tranfers
                transfer_created.save

                puts "Tranferência realizada com sucesso!"

                if updated_balance < 0
                    puts "Você utilizou #{updated_balance} do seu cheque especial."
                end

            else
                puts "Tranferência não realizada. Seu saldo é insuficiente."         
            end    
        end
    end

    def show_transactions(client_info)
        withdrawals = DB[:withdraws]
        deposits = DB[:deposits]
        transfers = DB[:transfers]

        deposits = deposits.map do |el|
            {
                type: 'dep',
                origin: el[:account_number],
                recipient: el[:recipient_account_number],
                value: el[:value],
                date: el[:create_date],
            }
        end

        deposits_filtered = deposits.select do |el|
            el[:origin] == client_info[0][:number]
        end


        withdrawals = withdrawals.map do |el|
            {
                type: 'saq',
                origin: el[:account_number],
                recipient: el[:account_number],
                value: el[:value],
                date: el[:create_date],
            }
        end

        withdrawals_filtered = withdrawals.select do |el|
            el[:origin] == client_info[0][:number]
        end


        transfers = transfers.map do |el|
            {
                type: el[:type],
                origin: el[:account_number],
                recipient: el[:account_number],
                value: el[:value],
                date: el[:create_date],
            }
        end

        transfers_filtered = transfers.select do |el|
            el[:origin] == client_info[0][:number]
        end


        statement = deposits_filtered + withdrawals_filtered + transfers_filtered

        
        statement_sorted_by_date = statement.sort_by! { |el| el[:date] }
        
        puts "Extrato"
        puts "-----------------------------------------------------------------------------"
        puts "data                  tipo   conta origem   conta destino  valor"
        puts "-----------------------------------------------------------------------------"
        puts ""
        statement_sorted_by_date.each do |el|
            puts "#{el[:date]}   #{el[:type]}    #{el[:origin]}           #{el[:recipient]}           R$ #{el[:value]}"
            puts ""
        end
        puts "-----------------------------------------------------------------------------"
        
    end
end 