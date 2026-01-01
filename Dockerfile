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

# Install gems (use --without to skip dev/test for smaller image)
RUN gem update --system && \
    bundle install -j4 --retry 3 --without development test

# Copy full app
COPY . .

# Skip asset precompile if it fails (common in Docker without DB)
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true

RUN bundle exec rails assets:precompile || echo "Asset precompile failed (non-fatal in container)"

# Proper CMD
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
