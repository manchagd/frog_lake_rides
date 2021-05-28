 module GeoTools
  BOGOTA_CENTER = [4.650700, -74.107583].freeze
  BOGOTA_NORTH = [4.769226, -74.027218].freeze
  BOGOTA_SOUTH = [4.650700, -74.107583].freeze
  BOGOTA_EAST = [4.622923, -74.060596].freeze
  BOGOTA_WEST = [4.695917, -74.172070].freeze

  BASE_FEE = 3500.freeze
  TIME_MULTIPLIER = 200.freeze
  DISTANCE_MULTIPLIER = 1000.freeze

  def self.mock_location
    lat = rand(BOGOTA_EAST.first..BOGOTA_WEST.first).round(6)
    lon = rand(BOGOTA_SOUTH.last..BOGOTA_NORTH.last).round(6)
    [lat, lon]
  end

  def self.mock_trip location1, location2
    avrg_speed = rand(10.0..45.0).round(2)
    distance = ::Geocoder::Calculations.distance_between(location1, location2, units: :km).round(6)
    spent_time = (distance*60/avrg_speed).round(6)
    {
      distance: distance,
      spent_time: spent_time,
      avrg_speed: avrg_speed
    }
  end

  def self.trip_fee(distance:, spent_time:, avrg_speed:)
    (distance*DISTANCE_MULTIPLIER+spent_time*TIME_MULTIPLIER+BASE_FEE).round
  end

 end