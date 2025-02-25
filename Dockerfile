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

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

FROM base AS dev

WORKDIR /myapp

RUN yarn install
RUN bundle install

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

FROM base AS prod

WORKDIR /myapp

COPY . /myapp

RUN yarn install --production --frozen-lockfile
RUN bundle install --without development test

RUN RAILS_ENV=production SECRET_KEY_BASE=fake-secret DATABASE_URL=postgresql:does_not_exist \
        bundle exec rails assets:precompile

ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
