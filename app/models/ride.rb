class Ride < Sequel::Model
  many_to_one :rider
  many_to_one :driver
  many_to_one :payment
  one_to_one :transaction

  def start(driver)
    self.update status: 'started', driver_id: driver.id
  end

  def finish
    self.update status: 'finished'
  end
  
end