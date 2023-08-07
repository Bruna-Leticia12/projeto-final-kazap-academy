class Client < Sequel::Model
    one_to_many :accounts

    def create_account(client)
        account_number = rand(1000..9999)
        
        
        bank_account = {
            client: client,
            number: account_number
        }
        return bank_account
        
    end
end
