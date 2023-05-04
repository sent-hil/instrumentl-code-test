import os
import pinecone

from langchain.vectorstores import Pinecone

PINECONE_INDEX_NAME = "instrumentl-code-test-1"
PINECONE_INDEX_DIMENSIONS = 1536  # number of dimensions OpenAI embeddings return


def init_vectordb():
    pinecone.init(
        api_key=os.environ["PINECONE_API_KEY"], environment=os.environ["PINECONE_ENV"]
    )
    ensure_index(PINECONE_INDEX_NAME, PINECONE_INDEX_DIMENSIONS)


# WARNING: this will block till the index is created
def ensure_index(index_name, index_dimensions):
    indexes = pinecone.list_indexes()
    if index_name not in indexes:
        print(
            f"Pinecone index: {index_name} not created. Creating...This can take up to 10 minutes."
        )
        pinecone.create_index(index_name, dimension=index_dimensions)


def add_to_vectordb(texts, embeddings, index_name=PINECONE_INDEX_NAME):
    Pinecone.from_documents(texts, embeddings, index_name=index_name)
    print(f"\tSaved {len(texts)} embeddings.")
