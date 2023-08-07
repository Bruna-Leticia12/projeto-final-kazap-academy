class Address < Sequel::Model
    one_to_many :clients

    def address_client(client)

        dados_address = {
            street: street,
            number: number,
            neighborhood: neighborhood,
            city: city,
            state: state,
            country: country,
            zip_code: zip_code
        }
        return dados_address
        
    end
end
