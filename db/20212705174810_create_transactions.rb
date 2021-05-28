DB.create_table(:transactions) do
  primary_key :id
  String :api_id, null: false
  Float :amount, default: 0
  foreign_key :ride_id, :rides
end unless DB.table_exists?(:transactions)