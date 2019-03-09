# README

## Quickstart

Install the dependencies...

```sh
$ bundle install
$ yarn install
```

...and run the server.

```sh
$ bin/rails server
```

## Linting

This project uses multiple linters to apply a common code style and catch common mistakes.

`rubocop` helps us implement our agreed upon coding style. `reek` can help find potential candidates for refactorings. `rails_best_pratices` will help us pay attention to gotchas and quirks of Rails.

To run the linters manually, use the following commands:

```sh
$ bundle exec rubocop .
$ bundle exec reek .
$ bundle exec rails_best_practices .
```


`rubocop` is run on every PR automatically by the CI pipeline. The other should be run periodically by the developers to keep our high requirements of quality.
