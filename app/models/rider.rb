class Rider < Sequel::Model
  one_to_many :rides
  one_to_many :payments
  
end