[![License](https://img.shields.io/github/license/svkurowski/aktenkoffer)](LICENSE)
[![Deploy to Heroku](https://img.shields.io/badge/%E2%86%91_Deploy_to-Heroku-7056bf.svg)](https://heroku.com/deploy)
[![Build status](https://img.shields.io/circleci/build/github/svkurowski/aktenkoffer)](https://app.circleci.com/pipelines/github/svkurowski/aktenkoffer)

# Usage

## Installation

First, set up a PostgreSQL database and an AWS S3 bucket + IAM user with writing permissions.
See [doc/aws/cloudformation-template.yaml](doc/aws/cloudformation-template.yaml) for a CloudFormation template you can use to create these.
Alternatively, you should be able to use any other [ActiveStorage](https://edgeguides.rubyonrails.org/active_storage_overview.html) service by changing [config/storage.yml](config/storage.yml), but S3 is the only one supported out of the box at the moment.

You will also need to install `poppler-utils` system package as it is used to extract PDF text through `pdftotext`.

```sh
$ bundle install
$ yarn install
$ export DATABASE_URL='postgresql://dbuser:dbpw@dbhost/dbname?pool=5'
$ export RAILS_ENV='production'
$ export SECRET_KEY_BASE='OoGho8Lee8KeiVayiepu' # replace with a randomly generated key you store securely
$ export AWS_ACCESS_KEY_ID='AKIAIOSFODNN7EXAMPLE'
$ export AWS_SECRET_ACCESS_KEY='wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY'
$ export AWS_BUCKET='your-bucket-name'
$ export AWS_DEFAULT_REGION='eu-west-1' # replace with your region's identifier
$ bin/rails db:schema:load
$  bin/rails 'user:create[ThisIsTheUserName,ThisIsThePassword]' # choose a strong password, avoid password being stored in terminal history
$ bin/rails server
```

Next, you should create a new contact for your home address, and set the environment variable `HOME_CONTACT_ID` to the UUID of the contact record (you can find it on the edit page URL).
Changing this value requires restarting the server.
We use the home address in various places to offer a better user experience.

### Heroku
This repository includes some configuration that enables easy installation of Aktenkoffer on Heroku.
All functionality works even when running in Heroku's free tier.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Update
```sh
$ bundle install
$ yarn install
$ bin/rails db:migrate
```

# Development

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
$ bundle exec rubocop . # required to succeed for PRs
$ bundle exec reek . # optional
$ bundle exec rails_best_practices . # optional
```

### JavaScript

We are using `ESLint` with the `airbnb-base` preset that follows the [Airbnb style guide](https://github.com/airbnb/javascript).

To run ESLint, use

```sh
$ yarn lint
```

### Continous Integration

Only `RuboCop` and `ESLint` are run on every Pull Request automatically by the CI pipeline. The other should be run periodically by the developers.

## Acknowledgements

+ Favicons by [twemoji](https://twemoji.twitter.com/)
