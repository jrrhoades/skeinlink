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

# Install gems first (for layer caching)
COPY Gemfile Gemfile.lock ./
RUN gem update --system && \
    bundle install -j4 --retry 3

# Copy the full application
COPY . .

# Precompile assets for production
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true  # Optional: Serve static files via Puma
RUN bundle exec rails assets:precompile

# Start the server properly
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
