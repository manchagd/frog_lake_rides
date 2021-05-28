DB.create_table(:riders) do
  primary_key :id
  String :email, null: false
end unless DB.table_exists?(:riders)