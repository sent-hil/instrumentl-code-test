Hello Instrumentl Team,

This is Senthil's submission for the Engineering code test. The user requirements were:

* On home page, user can ask questions about a 5 products in natural language.
* Each product, get its own page which shows 5 FAQs.

## How it works?

`injest` contains a Python script which is used to preprocess the PDFs. It divides the PDFs into short chunks, gets embeddings for each chunk from OpenAI and stores that in the Pinecone database for later use.

When user asks a question from the Web service, the API finds the relevant docs from Pinecone and sends those docs , along with a prompt to OpenAI which returns an answer that's shown to the user.0

## Technical Requirements:

* Services based architecture
  * Frontend in NextJS
  * Backend in Rails
* PostgresSQL as relational data
* Pinecone for vectors
* OpenAI for LLM
* Deployed on render.com

The site is deployed on Render at https://instrumentl-web.onrender.com.