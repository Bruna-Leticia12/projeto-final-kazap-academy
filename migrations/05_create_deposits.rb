Sequel.migration do
    change do
        create_table(:deposits) do
            primary_key :id
            Integer  :account_number
            Integer  :recipient_account_number
            Float    :value
            Datatime :create_date, default: Sequel.lit("datetime('now')")
        end
    end
end