class AddIndexToGradedCards < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def up
    execute(
      <<-SQL
        CREATE UNIQUE INDEX CONCURRENTLY index_graded_cards_on_card_id_and_grade_and_qualifier
        ON graded_cards(card_id, grade, qualifier)
        NULLS NOT DISTINCT;
      SQL
    )
  end

  def down
    execute(
      <<-SQL
        DROP INDEX CONCURRENTLY index_graded_cards_on_card_id_and_grade_and_qualifier
      SQL
    )
  end
end
