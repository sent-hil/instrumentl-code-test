# API

This Rails app serves as JSON API backend to AskPDF app. The most interesting part is `AnsweringService`.

It has three endpoints:

* /resources
* /resources/:slug
* /query


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