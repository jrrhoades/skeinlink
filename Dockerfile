FROM ruby:3.3-slim-bookworm

# System deps
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

# Copy Gemfiles for caching
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem update --system && \
    bundle install -j4 --retry 3

# Copy full app code
COPY . .

# Production setup
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true  # Let Puma serve precompiled assets

# Precompile assets
RUN bundle exec rails assets:precompile

# Proper server start (uses project's bin/rails)
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
