module WompiApi
  PVT_KEY = secrets["keys"]["pvt_key"]
  PUB_KEY = secrets["keys"]["pub_key"]
  WOMPI_ENDPOINT = secrets["wompi"]["sandbox"]

  def self.acceptance_token
    response = Faraday.get("#{WOMPI_ENDPOINT}/merchants/#{PUB_KEY}", {}, {authorization: "Bearer #{PUB_KEY}"})
    MultiJson.load(response.body)["data"]
  end

  def self.payment email:, type: "CARD", card_token: secrets["card"]["token"]
    payload = {
      type: type,
      token: card_token,
      customer_email: email,
      acceptance_token: acceptance_token["presigned_acceptance"]["acceptance_token"]
    }
    response = Faraday.post("#{WOMPI_ENDPOINT}/payment_sources", MultiJson.dump(payload), {authorization: "Bearer #{PVT_KEY}"})
    MultiJson.load(response.body)
  end

  def self.transaction(amount: , payment: , rider: )
    payload = {
      amount_in_cents: amount*100,
      currency: payment.currency,
      customer_email: rider.email, 
      payment_method: {
        installments: payment.installments
      },
      reference: SecureRandom.uuid,
      payment_source_id: payment.reference
    }
    response = Faraday.post("#{WOMPI_ENDPOINT}/transactions", MultiJson.dump(payload), {authorization: "Bearer #{PVT_KEY}"})
    MultiJson.load(response.body)["data"]
  end
end