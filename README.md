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

### Ruby

`RuboCop` helps us implement our agreed upon coding style. `reek` can help find potential candidates for refactorings. `rails_best_pratices` will help us pay attention to gotchas and quirks of Rails.

To run the linters, use the following commands:

```sh
$ bundle exec rubocop .
$ bundle exec reek .
$ bundle exec rails_best_practices .
```

### JavaScript

We are using `ESLint` with the `airbnb-base` preset that follows the [Airbnb style guide](https://github.com/airbnb/javascript).

To run ESLint, use

```sh
$ yarn lint
```

### Continous Integration

Only `RuboCop` and `ESLint` are run on every Pull Request automatically by the CI pipeline. The other should be run periodically by the developers to keep our high requirements of quality.
