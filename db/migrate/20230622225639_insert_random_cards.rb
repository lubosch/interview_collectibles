class InsertRandomCards < ActiveRecord::Migration[7.0]
  def up
    Card.insert_all(
      100_000.times.map { |index| { name: "#{SecureRandom.alphanumeric(12)}#{index}" } }
    )
  end

  def down
    Card.delete_all
  end
end
