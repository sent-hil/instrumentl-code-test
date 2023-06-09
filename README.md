Hello Instrumentl Team,

This is Senthil's submission for the Engineering code test. The user requirements were:

* On home page, user can ask questions about a 5 products in natural language.
* Each product, get its own page which shows 5 FAQs.

## How it works?

`injest` contains a Python script which is used to preprocess the PDFs in `injest/assets` folder. It divides the PDFs into short chunks, gets embeddings for each chunk from OpenAI API and stores the embeddings and text in Pinecone database through API.

When user asks a question from the Web service, the API finds the relevant docs from Pinecone and sends those docs, along with a prompt to OpenAI API which returns an answer that's shown to the user.

## Technical Requirements:

* Services based architecture
  * Frontend in NextJS
  * Backend in Rails
* PostgresSQL for storing relational data
* Pinecone for storing vectors
* OpenAI for LLM
* Deploy on render.com

The site is deployed on Render at https://instrumentl-web.onrender.com. I made a short loom explaning the site here: https://www.loom.com/share/b13fafa78d5245489b23e64113237661