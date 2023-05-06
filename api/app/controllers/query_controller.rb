class QueryController < ApplicationController
  PINECONE_INDEX_NAME = 'instrumentl-code-test-1'.freeze

  def query
    q = params[:query]
    if q.blank?
      return render status: :bad_request,
                    json: { error: 'Missing query parameter' }
    end

    result = AnsweringService.new(llm: open_ai, vector_db: pinecone).run(q)

    puts result

    render status: :ok,
           json: { error: nil, response: result }
  rescue StandardError => e
    puts('ERROR:', e)

    render status: :internal_server_error,
           json: { error: e.class.name, response: nil }
  end

  private

  def open_ai
    OpenAIClient.new(
      access_token: Rails.application.credentials.open_ai[:api_key],
      uri_base: Rails.application.credentials.helicone[:api_url]
    )
  end

  def pinecone
    PineconeClient.new(PINECONE_INDEX_NAME)
  end
end
