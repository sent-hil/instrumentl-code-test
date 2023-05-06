class OpenAIClient
  EMBEDDINGS_MODEL_NAME = 'text-embedding-ada-002'.freeze
  AI_MODEL_NAME = 'gpt-3.5-turbo'.freeze

  attr_reader :client

  def initialize(access_token:, uri_base:)
    @client = OpenAI::Client.new(access_token:, uri_base:)
  end

  def fetch_embeddings(query)
    results = client.embeddings(
      parameters: {
        model: EMBEDDINGS_MODEL_NAME,
        input: query
      }
    )

    results['data'].first['embedding']
  end

  def fetch_completion(_relevant_docs, prompt)
    result = client.chat(
      parameters: {
        model: AI_MODEL_NAME,
        messages: [{ role: 'user', content: prompt }],
        temperature: 0.0
      }
    )

    result['choices'].first['message']['content']
  end
end
