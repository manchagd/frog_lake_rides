class FrogLakeRidesApplication < Sinatra::Application
  post "/payments/create" do
    result = PaymentsService::create
    MultiJson.dump(result)
  end
end