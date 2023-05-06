class AnsweringService
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
    embeddings = llm.fetch_embeddings(query)
    relevant_docs = vector_db.fetch_relevant_docs(embeddings)
    llm.fetch_completion(
      relevant_docs,
      QUERY_FN.call(relevant_docs.join('\n\n'), query)
    )
  end
end
