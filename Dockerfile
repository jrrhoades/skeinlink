FROM ruby:3.3-slim-bookworm

# Install system dependencies
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

# Install gems
RUN gem update --system && \
    bundle install -j4 --retry 3

# Copy full app
COPY . .

# Precompile assets (for production)
ENV RAILS_ENV=production
RUN bundle exec rails assets:precompile

# Run server using project's binstub
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
