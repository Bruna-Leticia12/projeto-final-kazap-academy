Sequel.migration do
    change do
        create_table(:accounts) do
            primary_key :id
            foreign_key :client_id, :clients
            Integer  :number
            Float    :balance, default: 0.0
            Datatime :create_date, default: Sequel.lit("datetime('now')")
            Boolean  :active, default: true
        end
    end
end