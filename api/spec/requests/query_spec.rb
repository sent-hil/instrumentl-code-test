require 'rails_helper'

RSpec.describe 'Queries', type: :request do
  describe 'GET /index' do
    it 'returns 400 if no query was included' do
      get('/query')
      expect(response).to have_http_status(:bad_request)

      body = JSON.parse(response.body)
      expect(body['error']).to eq('Missing query parameter')
    end

    it 'returns 200 if query was included' do
      get('/query', params: { query: '1' })
      expect(response).to have_http_status(:success)

      body = JSON.parse(response.body)
      expect(body['response']).to eq('1')
      expect(body['error']).to eq(nil)
    end
  end
end
