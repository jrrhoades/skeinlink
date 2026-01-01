FROM ruby:3.3-slim

ENV BINDING=0.0.0.0

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
      build-essential \
      libxml2-dev \
      libxslt1-dev \
      imagemagick \
      libmariadb-dev \
      libsqlite3-dev \
      vim \
      mariadb-client && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /srv/skeinlink

# Copy Gemfiles first for caching
COPY Gemfile Gemfile.lock ./

RUN gem update --system && \
    bundle install -j4 --retry 3

# Copy the full app code
COPY . .

# Precompile assets for production (assumes RAILS_ENV=production)
RUN bundle exec rails assets:precompile

CMD ["bundle", "exec", "rails", "server"]
