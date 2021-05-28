module PaymentsService
  def self.create
    rider = Rider.where(email: 'manchagd@example.com').first
    payment = rider.payments_dataset.where(card_token: secrets["card"]["token"]).first
    if payment
      {response: "Payment for this card already exists."}
    else
      result = WompiApi::payment(email: rider.email)
      if result["data"]
        reference = result["data"]["id"]
        payment = Payment.create({
          card_token: secrets["card"]["token"],
          reference: reference,
          rider_id: rider.id
        })
        {data: {payment: payment.to_hash}}
      else
        {response: result["error"]["type"]}
      end
    end
  end
end