# == Schema Information
#
# Table name: graded_cards
#
#  id         :bigint           not null, primary key
#  grade      :string
#  name       :string           not null
#  qualifier  :string
#  tracking   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  card_id    :bigint           not null
#
# Indexes
#
#  index_graded_cards_on_card_id                          (card_id)
#  index_graded_cards_on_card_id_and_grade_and_qualifier  (card_id,grade,qualifier) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (card_id => cards.id)
#
class GradedCard < ApplicationRecord
  belongs_to :card
  validates :qualifier, inclusion: { in: %w[OC OD OB MB CB] }, allow_nil: true
  validates :card_id, uniqueness: { scope: %i[grade qualifier] }
end
