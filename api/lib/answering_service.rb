class AnsweringService
  # TODO: move these constants to some other responsible class.
  OPEN_AI_EMBEDDINGS_MODEL_NAME = 'text-embedding-ada-002'.freeze
  OPEN_AI_MODEL_NAME = 'gpt-3.5-turbo'.freeze
  PINECONE_INDEX_NAME = 'instrumentl-code-test-1'.freeze

  QUERY_FN = lambda do |docs, query|
    <<~TERM
      Use the following pieces of context to answer the question at the end.
      If you don't know the answer, just say that "I don't know", don't try to make up an answer.

      #{docs}

      Question: #{query}
      Helpful Answer:
    TERM
  end

  attr_reader :llm, :vector_db

  def initialize(llm:, vector_db:)
    @llm = llm
    @vector_db = vector_db
  end

  def run(query)
    embeddings = fetch_embeddings(query)
    relevant_docs = fetch_relevant_docs(embeddings)
    fetch_completion(relevant_docs, query)
  end

  private

  def fetch_embeddings(query)
    results = llm.embeddings(
      parameters: {
        model: OPEN_AI_EMBEDDINGS_MODEL_NAME,
        input: query
      }
    )

    results['data'].first['embedding']
  end

  def fetch_relevant_docs(embeddings)
    index = vector_db.index(PINECONE_INDEX_NAME)
    relevant_docs = index.query(vector: embeddings)

    relevant_docs['matches'].map { |x| x['metadata']['text'] }
  end

  def fetch_completion(relevant_docs, query)
    result = llm.chat(
      parameters: {
        model: OPEN_AI_MODEL_NAME,
        messages: [{ role: 'user', content: QUERY_FN.call(relevant_docs.join('\n\n'), query) }],
        temperature: 0.0
      }
    )

    result['choices'].first['message']['content']
  end
end
