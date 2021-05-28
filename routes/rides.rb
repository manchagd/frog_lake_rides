# encoding: utf-8
class FrogLakeRidesApplication < Sinatra::Application
  get "/" do
    result = {
      riders: Rider.all.count, 
      drivers: Driver.all.count,
      rides: Ride.all.count,
      payments: Payment.all.count,
      transactions: Transaction.all.count
    }
    MultiJson.dump(result)
  end

  post "/rides/finish" do
    params = MultiJson.load(request.body.read)
    result = RidesService::finish(params)
    MultiJson.dump(result)
  end

  post "/rides/request" do
    params = MultiJson.load(request.body.read)
    result = RidesService::request(params)
    MultiJson.dump(result)
  end

end