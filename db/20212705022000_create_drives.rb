DB.create_table(:drivers) do
  primary_key :id
end unless DB.table_exists?(:drivers)