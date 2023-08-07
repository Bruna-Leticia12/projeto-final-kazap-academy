require 'sequel'

DB = Sequel.sqlite('./db/projeto_final.db')
require_relative 'classes/client'
require_relative 'classes/account'
require_relative 'classes/address'
require_relative 'classes/contact'

service = Account.new
service.setup(0.0,0.0,[])

loop do
    puts "-----------------------------------------------------------------------------"
    puts "Bem vindo ao banco..."
    puts "Digite a opção desejada:"
    puts '1. Já sou cliente'
    puts '2. Quero meu tornar cliente'
    puts '3. Sair'
    puts "-----------------------------------------------------------------------------"
    option = gets.chomp.to_i

    case option
    when 1
        puts 'Informe o número da conta'
        account = gets.chomp.to_i
        puts "-----------------------------------------------------------------------------"

        loop do
            #client_info é uma lista com apenas um item.
            client_info = service.login(account)
            puts "Digite a opção desejada:"
            puts '1. Consultar Saldo'
            puts '2. Depósito'
            puts '3. Saque'
            puts '4. Transferência'
            puts '5. Extrato de Transações'
            puts '6. Para voltar ao menu inicial'
            opcao = gets.chomp.to_i
            puts "-----------------------------------------------------------------------------"

                case opcao
                when 1
                    puts "Consulta de saldo: "
                    service.check_balance(client_info, account)
                    puts "-----------------------------------------------------------------------------"
                when 2
                    puts "Informe o valor que será depositado: "
                    value = gets.chomp.to_f
                    puts "Informe o número da conta do destinatário:"
                    recipient_account = gets.chomp.to_i
                    service.deposit(client_info, account, value, recipient_account)
                    puts "-----------------------------------------------------------------------------"
                when 3
                    puts "Informe o valor que será retirado"
                    value = gets.chomp.to_f
                    service.withdraw(client_info, account, value)
                    puts "-----------------------------------------------------------------------------"
                when 4
                    puts "Informe o tipo de transferência que será realizada (PIX ou TED):"
                    transaction_type = gets.chomp.downcase
                    puts "Informe o número da conta do destinatário:"
                    recipient_account = gets.chomp.to_i
                    puts "Informe o valor da transferência: "
                    value = gets.chomp.to_f
                    service.transfer(client_info, account, value, transaction_type, recipient_account)
                    puts "-----------------------------------------------------------------------------"
                when 5
                    service.show_transactions(client_info)
                when 6
                    puts 'Até breve!'
                    puts "-----------------------------------------------------------------------------"
                    break
                else
                    puts 'Opção inválida'
                    puts "-----------------------------------------------------------------------------"
                end
            end
    when 2
        puts"Informe os dados a seguir"
        puts "Nome Completo"
        name = gets.chomp
        puts "CPF/CNPJ:"
        document = gets.chomp
        
        puts "Logradouro:"
        street = gets.chomp
        puts "Numbero:"
        number = gets.chomp
        puts "Bairro:"
        neighborhood = gets.chomp
        puts "Cidade:"
        city = gets.chomp
        puts "Estado:"
        state = gets.chomp
        puts "País:"
        country = gets.chomp
        puts "CEP:"
        zip_code = gets.chomp
        

        puts "DDD:"
        digit_area_code = gets.chomp
        puts "Numbero de contato:"
        contact_number = gets.chomp
    
        dados_client = {
            name: name,
            document: document,
        }

        dados_address = {
            logradouro: street,
            numero: number,
            bairro: neighborhood,
            cidade: city,
            estado: state,
            pais: country,
            cep: zip_code
        }

        new_address = Address.new(
            street: street, 
            number: number, 
            neighborhood: neighborhood, 
            city: city, 
            state: state, 
            country: country, 
            zip_code: zip_code)

        address = new_address.save    
            
        new_client = Client.new(name: name, document: document, address_id: address.id)

        client = new_client.save 

        new_contact = Contact.new(digit_area_code: digit_area_code, number: contact_number, client_id: client.id)

        account_client = new_client.create_account(client)
        
        new_account = Account.new(number: account_client[:number], client_id: client.id)
        
        # address = new_address.address_client(dados_address)
        new_contact.save
        new_account.save
        
        puts "Cadastro realizado com sucesso!"
        puts "Conta bancária criada para o cliente #{account_client[:client][:name]}!"
        puts "Número da conta: #{account_client[:number]}"
        puts "-----------------------------------------------------------------------------"
    when 3
        puts 'Até breve!'
        puts "-----------------------------------------------------------------------------"
        break
    else
        puts 'Opção inválida'
        puts "-----------------------------------------------------------------------------"
    end
end