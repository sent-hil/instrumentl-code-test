class Resource < ApplicationRecord
  has_many :resource_faqs
  has_many :faqs, -> { order(:priority).limit(5) }, class_name: "ResourceFaq"

  validates :slug, presence: true
  validates :name, presence: true
  validates :summary, presence: true

  before_validation(on: :create) do
    self.slug = self.name.gsub!(/\W/, "").downcase
  end
end
