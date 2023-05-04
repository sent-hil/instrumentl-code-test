require 'pinecone'

PINECONE_ENVIRONMENT = 'us-west1-gcp-free'.freeze

Pinecone.configure do |config|
  config.api_key  = Rails.application.credentials.pinecone[:api_key]
  config.environment = PINECONE_ENVIRONMENT
end