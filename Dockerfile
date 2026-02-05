FROM ruby:3.1 AS base

ENV DEBIAN_FRONTEND noninteractive

# Add yarn repo
RUN wget -q -O - https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list

# Install OS packages
RUN apt-get update -qq && apt-get install -y --no-install-recommends nodejs yarn postgresql-client poppler-utils

# Install bundler
RUN gem install bundler

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY package.json /myapp/package.json
COPY yarn.lock /myapp/yarn.lock

FROM base AS dev

WORKDIR /myapp

RUN yarn install
RUN bundle install

ENTRYPOINT ["/myapp/bin/docker-entrypoint"]
EXPOSE 3000

CMD ["bin/dev", "-b", "0.0.0.0"]

FROM base AS prod

ENV BUNDLE_WITHOUT='development test'

WORKDIR /myapp

COPY . /myapp

RUN yarn install --production --frozen-lockfile
RUN bundle install

RUN RAILS_ENV=production SECRET_KEY_BASE=fake-secret DATABASE_URL=postgresql:does_not_exist \
        bundle exec rails assets:precompile

ENTRYPOINT ["/myapp/bin/docker-entrypoint"]
EXPOSE 3000

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
