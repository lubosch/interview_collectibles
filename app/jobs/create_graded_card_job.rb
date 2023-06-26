class CreateGradedCardJob < ApplicationJob
  queue_as :default

  def perform
    CreateGradedCard.call
  end
end
