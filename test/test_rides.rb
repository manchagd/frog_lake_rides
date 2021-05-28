require_relative '../application.rb'
require "minitest/autorun"
require 'rack/test'

include Rack::Test::Methods

def app
  FrogLakeRidesApplication
end

class TestRides < Minitest::Test
  include Rack::Test::Methods
  def setup
  end

  def test_request_with_incorrect_latitude
    payload = {
      id: 1,
      payment_id: 1,
      latitude: 94.652215,
      longitude: -72.087463
    }
    post '/rides/request',  MultiJson.dump(payload), { 'CONTENT_TYPE' => 'application/json' }
    response_body = MultiJson.load(last_response.body)
    assert last_response.ok?
    assert_equal "must be between -90 and 90.", response_body["latitude"].first
  end

  def test_request_with_incorrect_longitude
    payload = {
      id: 1,
      payment_id: 1,
      latitude: 64.652215,
      longitude: -272.087463
    }
    post '/rides/request',  MultiJson.dump(payload), { 'CONTENT_TYPE' => 'application/json' }
    response_body = MultiJson.load(last_response.body)
    assert last_response.ok?
    assert_equal "must be between -180 and 180.", response_body["longitude"].first
  end

  def test_request
    payload = {
      id: 1,
      payment_id: 1,
      latitude: 64.652215,
      longitude: -72.087463
    }
    post '/rides/request',  MultiJson.dump(payload), { 'CONTENT_TYPE' => 'application/json' }
    response_body = MultiJson.load(last_response.body)
    assert last_response.ok?
    refute_nil response_body["ride"]
  end

  def test_request_creation
    get '/'
    response_body = MultiJson.load(last_response.body)
    assert last_response.ok?
    assert_equal 2, response_body["drivers"]
  end
end