DB.create_table(:rides) do
  primary_key :id
  String :status, null: false, default: "requested"
  String :email, null: false
  Float :initial_lat
  Float :initial_lon
  Float :final_lat
  Float :final_lon
  foreign_key :payment_id, :payments
  foreign_key :rider_id, :riders
  foreign_key :driver_id, :drivers
end unless DB.table_exists?(:rides)