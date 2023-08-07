Sequel.migration do
    change do
        create_table(:transfers) do
            primary_key :id
            Integer  :account_number
            Integer  :recipient_account_number
            String   :type
            Float    :value
            Datatime :create_date, default: Sequel.lit("datetime('now')")
        end
    end
end
