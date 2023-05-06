require 'rails_helper'

RSpec.describe 'Resources', type: :request do
  describe 'GET /index' do
    it 'returns list of resources' do
      6.times { create(:resource) }

      get '/resources'

      body = JSON.parse(response.body)
      expect(body.size).to eq(5)
      expect(body[0].keys.sort).to eq(%w[slug name url].sort)
    end
  end

  describe 'GET /:slug' do
    it 'returns resource' do
      r = create(:resource)

      get "/resources/#{r.slug}"

      body = JSON.parse(response.body)
      expect(body.keys.sort).to eq(%w[slug name url faqs].sort)
    end

    it 'returns resource with only 5 faqs' do
      r = create :resource
      6.times { create(:resource_faq, resource: r) }

      get "/resources/#{r.slug}"

      body = JSON.parse(response.body)
      expect(body['faqs'].size).to eq(5)
    end
  end
end
