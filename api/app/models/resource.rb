class Resource < ApplicationRecord
  has_many :resource_faqs

  # alias of resource_faqs, so we can order and limit the way client wants it
  has_many :faqs, -> { order(:priority).limit(5) }, class_name: 'ResourceFaq'

  validates :slug, presence: true
  validates :name, presence: true
  validates :url, presence: true

  before_validation(on: :create) do
    self.slug = name.gsub(/\W/, '_').downcase
  end
end
