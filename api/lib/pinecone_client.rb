class PineconeClient
  attr_reader :client, :index

  def initialize(index_name)
    @client = Pinecone::Client.new
    @index = client.index(index_name)
  end

  def fetch_relevant_docs(embeddings)
    relevant_docs = index.query(vector: embeddings)
    relevant_docs['matches'].map { |x| x['metadata']['text'] }
  end
end
