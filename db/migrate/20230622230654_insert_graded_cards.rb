class InsertGradedCards < ActiveRecord::Migration[7.0]
  def up
    graded_cards = []
    Card.find_each(batch_size: 10_000).pluck(:id).each do |card_id|
      graded_cards.push({ card_id:, name: SecureRandom.alphanumeric(12), grade: '10 black', qualifier: 'OC' })
      graded_cards.push({ card_id:, name: SecureRandom.alphanumeric(12), grade: '1 gold', qualifier: 'CB' })
    end
    GradedCard.insert_all(graded_cards)
  end

  def down
    GradedCard.delete_all
  end
end
