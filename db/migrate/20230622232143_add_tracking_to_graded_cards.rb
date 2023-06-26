class AddTrackingToGradedCards < ActiveRecord::Migration[7.0]
  def change
    add_column :graded_cards, :tracking, :boolean, null: false, default: false
  end
end
