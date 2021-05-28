DB.create_table(:payments) do
  primary_key :id
  String :card_token, null: false
  String :reference, null: false
  String :currency, default: "COP"
  Integer :installments, default: 1
  foreign_key :rider_id, :riders
end unless DB.table_exists?(:payments)