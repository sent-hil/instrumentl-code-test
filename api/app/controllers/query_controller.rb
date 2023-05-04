class QueryController < ApplicationController
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
  end

  private

  def open_ai
    OpenAI::Client.new(
      access_token: Rails.application.credentials.open_ai[:api_key],
      uri_base: Rails.application.credentials.helicone[:api_url]
    )
  end

  def pinecone
    Pinecone::Client.new
  end
end
