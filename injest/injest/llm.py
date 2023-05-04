import openai

from langchain.embeddings.openai import OpenAIEmbeddings
from langchain.llms import OpenAI
from langchain.chains import LLMChain
from langchain.prompts import PromptTemplate
from langchain.chains import SimpleSequentialChain


# Proxy requests through Helicone API to OpenAI API so we can debug them.
OPEN_AI_BASE_URL = "https://oai.hconeai.com/v1"


def init_llm():
    openai.api_base = OPEN_AI_BASE_URL


def embeddings():
    return OpenAIEmbeddings()


def get_questions(text):
    llm = OpenAI(temperature=0)

    template = """
    Given the text of an operating manual, come up 10 questions the user of the product might ask
    about the product and return a short answer to that question.

    If you can't come up with a question, just say "I don't know", don't try to make something up.

    Operation manual text: {text}

    Question:
    Answer:
    """

    prompt_template = PromptTemplate(input_variables=["text"], template=template)
    answer_chain = LLMChain(llm=llm, prompt=prompt_template)
    answer = answer_chain.run(text)

    return answer
