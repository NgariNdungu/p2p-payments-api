FROM ruby:2.5.1-alpine
LABEL maintainer="Kariuki Gathitu <kgathi2@gmail.com>"
LABEL version="1.0"

# Packages needed to get Rails running in Alpine.
# DB_PACKAGES="sqlite-dev postgresql-dev mysql-dev" \
ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev" \
    DB_PACKAGES="postgresql-dev postgresql-client" \
    RUBY_PACKAGES="ruby-json yaml nodejs"

# Update and install base packages 
RUN apk update && \
    apk upgrade && \
    apk add --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $DB_PACKAGES \
    $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /usr/src/app

# Create system user to run as non-root. 
RUN addgroup -S admin -g 1000 && adduser -S -g '' -u 1000 -G admin deploy

# Set the Rails Environment Variables for production
ENV RAILS_ROOT /home/deploy/app
ENV RAILS_LOG_TO_STDOUT 1
ENV RAILS_ENV production

# Set user as deploy from here on out
USER deploy

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY --chown=deploy:admin Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install --jobs 20 --retry 10

# Copy the main application.
COPY --chown=deploy:admin . ./

# Expose the applications port to the host machine
EXPOSE 3000

# Command to run when the container is started. 
CMD ["puma", "-C", "config/puma.rb"]
