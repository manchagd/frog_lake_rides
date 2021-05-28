class Payment < Sequel::Model
  many_to_one :rider
  one_to_many :transactions
  one_to_many :rides
end