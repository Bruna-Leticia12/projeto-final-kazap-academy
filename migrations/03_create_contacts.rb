Sequel.migration do
    change do
        create_table(:contacts) do
            primary_key :id
            foreign_key :client_id, :clients
            Integer :digit_area_code
            String :number
        end
    end
end