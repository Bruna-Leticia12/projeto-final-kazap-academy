Sequel.migration do
    change do
        create_table(:addresses) do
            primary_key :id
            String  :street
            Integer :number
            String  :neighborhood
            String  :city
            String  :state
            String  :country
            String  :zip_code
        end
    end
end