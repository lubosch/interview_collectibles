class CreateGradedCards < ActiveRecord::Migration[7.0]
  def change
    create_table :graded_cards do |t|
      t.references :card, null: false, foreign_key: true
      t.string :name, null: false
      t.string :grade
      t.string :qualifier

      t.timestamps
    end
  end
end
