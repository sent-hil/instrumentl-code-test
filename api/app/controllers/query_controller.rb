class QueryController < ApplicationController
  OPEN_AI_EMBEDDINGS_MODEL_NAME = 'text-embedding-ada-002'.freeze
  OPEN_AI_MODEL_NAME = 'gpt-3.5-turbo'.freeze

  PINECONE_INDEX_NAME = 'instrumentl-code-test-1'.freeze

  QUERY_FN = lambda do |docs, query|
    <<~TERM
      Use the following pieces of context to answer the question at the end.
      If you don't know the answer, just say that you don't know, don't try to make up an answer.

      #{docs}

      Question: #{query}
      Helpful Answer:
    TERM
  end

  def query
    q = params[:query]

    if q.blank?
      return render status: :bad_request,
                    json: { error: 'Missing query parameter' }
    end

    embeddings = get_embeddings(q)
    relevant_docs = get_relevant_docs(embeddings)

    result = open_ai_client.chat(
      parameters: {
        model: OPEN_AI_MODEL_NAME,
        messages: [{ role: 'user', content: QUERY_FN.call(relevant_docs.join('\n\n'), q) }],
        temperature: 0.0
      }
    )

    render status: :ok,
           json: {
             error: nil, response: result['choices'].first['message']['content']
           }
  end

  private

  def get_embeddings(query)
    results = open_ai_client.embeddings(
      parameters: {
        model: OPEN_AI_EMBEDDINGS_MODEL_NAME,
        input: query
      }
    )

    results['data'].first['embedding']
  end

  def get_relevant_docs(embeddings)
    pinecone = Pinecone::Client.new
    index = pinecone.index(PINECONE_INDEX_NAME)
    relevant_docs = index.query(vector: embeddings)

    relevant_docs['matches'].map { |x| x['metadata']['text'] }
  end

  def open_ai_client
    @open_ai_client ||= OpenAI::Client.new(
      access_token: Rails.application.credentials.open_ai[:api_key],
      uri_base: Rails.application.credentials.helicone[:api_url]
    )
  end
end
