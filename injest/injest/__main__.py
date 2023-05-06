import os
import glob
import openai
import pinecone

from langchain.document_loaders import PyPDFLoader
from langchain.text_splitter import RecursiveCharacterTextSplitter

from .vectordb import init_vectordb, add_to_vectordb
from .llm import init_llm, embeddings, get_questions

REQUIRED_ENV_KEYS = (
    "HELICONE_AUTH",
    "OPENAI_API_KEY",
    "PINECONE_API_KEY",
    "PINECONE_ENV",
)

# Determines how big each document in vector database in characters.
TEXT_CHUNK_SIZE = 1000

# Determines how much overlap there between chunks in characters.
TEXT_CHUNK_OVERLAP = 50


def check_env_keys_exist(keys):
    for key in keys:
        try:
            os.environ[key]
        except:
            print(f"{key} environment variable is not set")
            exit(1)


def split_text_into_chunks(
    text, metadatas, size=TEXT_CHUNK_SIZE, overlap=TEXT_CHUNK_OVERLAP
):
    text_splitter = RecursiveCharacterTextSplitter(
        chunk_size=size,
        chunk_overlap=overlap,
        length_function=len,
    )
    return text_splitter.create_documents(text, metadatas=metadatas)


def save_embeddings(texts, metadatas):
    split_texts = split_text_into_chunks(texts, metadatas)

    print(f"\tSplit into {len(split_texts)} chunks.")

    add_to_vectordb(split_texts, embeddings())


def clean_text(text):
    c = text.replace("\n", " ").replace("..", " ")
    c = " ".join(c.split())  # split on new line

    return c


def process_pdf(path):
    pages = PyPDFLoader(path).load_and_split()

    print(f"\tParsed {len(pages)} pages for {path}.")

    pdf_contents = []
    metadatas = []
    for i, page in enumerate(pages):
        pdf_contents.append(clean_text(page.page_content))

        filename = os.path.basename(path)
        name = os.path.splitext(filename)[0]
        metadatas.append({"resource": name, "page_number": i + 1})

    save_embeddings(pdf_contents, metadatas)

    # TODO: sometimes this fails on certain PDFs. One fix is to chunk PDFs in a way that's
    # gpt-3.5-turbo model can reliably parse or get API access to the newer chatgpt model.
    #
    # joined = " ".join(x for x in pdf_contents)
    # m = joined[5000 : min(len(joined), 15000)]  # skip table of contents etc.
    # get_questions(m)


if __name__ == "__main__":
    check_env_keys_exist(REQUIRED_ENV_KEYS)
    init_vectordb()
    init_llm()

    for pdf_path in glob.glob("./assets/*.pdf"):
        print(f"Starting to process {pdf_path}...")
        try:
            process_pdf(pdf_path)
            print(f"Processed {pdf_path}.\n")
        except Exception as ex:
            print(f"\tSomething went wrong, processing {pdf_path}.\n")
