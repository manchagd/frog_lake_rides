class RideValidator < Dry::Validation::Contract
  params do
    required(:id).filled(:integer)
    required(:latitude).filled(:float)
    required(:longitude).filled(:float)
  end

  rule(:id) do
    if value < 0
      key.failure('must be greater than 0.')
    end
  end

  rule(:latitude) do
    if value > 90 || value < -90
      key.failure('must be between -90 and 90.')
    end
  end

  rule(:longitude) do
    if value > 180 || value < -180
      key.failure('must be between -180 and 180.')
    end
  end
end