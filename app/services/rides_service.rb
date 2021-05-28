module RidesService
  def self.root
    Driver.create
    size = Driver.first.rides.count
    return {response: "Frog Lake Rides #{size}"}
  end

  def self.request params
    validator = RideValidator.new
    validation_result = validator.call(params).errors.to_h
    return validation_result if validation_result.any?
    rider = Rider.where(id: params["id"]).first
    ride = Ride.create({
      rider_id: rider.id, 
      payment_id: params["payment_id"],
      email: rider.email,
      initial_lat: params["latitude"],
      initial_lon: params["longitude"]
    })
    driver = Driver.all.sample
    ride.start(driver)
    {ride: ride.to_hash}
  end

  def self.finish params
    validator = RideValidator.new
    validation_result = validator.call(params).errors.to_h
    return validation_result if validation_result.any?
    driver = Driver.where(id: params["id"]).first
    ride = driver.rides_dataset.where(status: "started").first
    if ride
      ride.update({
        final_lat: params["latitude"],
        final_lon: params["longitude"]
      })
      ride.finish
      rider = ride.rider
      payment = ride.payment
      trip = GeoTools::mock_trip([ride.initial_lat, ride.initial_lon], [ride.final_lat, ride.final_lon])
      total_fee = GeoTools::trip_fee(trip)
      result = WompiApi::transaction(amount: total_fee, payment: payment, rider: rider)
      transaction = Transaction.create(
        ride_id: ride.id,
        amount: total_fee,
        api_id: result["id"]
      )
      {transaction: transaction.to_hash, ride: ride.to_hash}
    else
      {response: 'No ride to finish.'}
    end

  end
end