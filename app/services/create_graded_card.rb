class CreateGradedCard
  def self.call
    GradedCard.create!(name: SecureRandom.alphanumeric(12), grade: nil, qualifier: nil, card: Card.last)
  rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
    nil
  end
end
