# Injest

This Python app when run:
* Parses PDFs stored under `assets/` folder
* Gets embeddings for texts in those PDFs from OpenAI API
* Uploads embeddings to Pinecone

It relies heavily on `langchain` library.

## Requirements

* Python 3.10.11
* Poetry 1.4.2
* The following ENV variables:
  * HELICONE_AUTH
  * OPENAI_API_KEY
  * PINECONE_API_KEY
  * PINECONE_ENV

## Example

Running `poetry run python -m injest` should look something like:

```
$ poetry run python -m injest
Starting to process ./assets/babybreeza_formula_pro_advanced.pdf...
	Parsed 10 pages for ./assets/babybreeza_formula_pro_advanced.pdf.
	Split into 25 chunks.
	Saved 25 embeddings.
Processed ./assets/babybreeza_formula_pro_advanced.pdf.

Starting to process ./assets/bosh_color_monitor.pdf...
	Parsed 2 pages for ./assets/bosh_color_monitor.pdf.
	Split into 6 chunks.
	Saved 6 embeddings.
Processed ./assets/bosh_color_monitor.pdf.

Starting to process ./assets/fujifilm_digital_camera.pdf...
	Parsed 338 pages for ./assets/fujifilm_digital_camera.pdf.
	Split into 333 chunks.
	Saved 333 embeddings.
Processed ./assets/fujifilm_digital_camera.pdf.

Starting to process ./assets/lg_external_hd.pdf...
	Parsed 33 pages for ./assets/lg_external_hd.pdf.
	Split into 35 chunks.
	Saved 35 embeddings.
Processed ./assets/lg_external_hd.pdf.

Starting to process ./assets/dewalt_vacuum.pdf...
	Parsed 38 pages for ./assets/dewalt_vacuum.pdf.
	Split into 85 chunks.
	Saved 85 embeddings.
Processed ./assets/dewalt_vacuum.pdf.
```
