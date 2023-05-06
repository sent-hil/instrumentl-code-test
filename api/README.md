# API

This Rails app serves as JSON API backend to AskPDF app. It has three endpoints:

* /resources
* /resources/:slug
* /query

## Requirements

* Ruby 3.1
* Rails 6
* The following credentials:
```
open_ai:
  api_key:
pinecone:
  api_key:
helicone:
  api_key:
  api_url:
```

## Installation

```
$ rbenv install 3.1.0` # or some other equivalent Ruby
$ bundle
```

## Run

```
$ rake db:create rake db:migrate
$ bundle exec rails s
```