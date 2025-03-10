class Assessment < ApplicationRecord
  belongs_to :programme
  belongs_to :activity
  has_many   :assessment_attempts, dependent: :destroy

  validates :class_marker_test_id, :link, presence: true
end
