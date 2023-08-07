Sequel.migration do
  change do
    create_table(:clients) do
      primary_key :id
      String :name
      String :document
      foreign_key :address_id, :addresses
    end
  end
end