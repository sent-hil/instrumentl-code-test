class ResourceFaq < ApplicationRecord
  belongs_to :resource, dependent: :destroy

  validates_numericality_of :priority

  validates :priority, presence: true, numericality: { only_integer: true }
  validates :question, presence: true
  validates :answer, presence: true
end
