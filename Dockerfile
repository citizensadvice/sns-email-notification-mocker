FROM ruby:3.1.2-alpine3.16 AS builder

ENV APP_HOME /app
ENV LANG C.UTF-8

RUN apk add --update --no-cache build-base

WORKDIR $APP_HOME
COPY Gemfile* /app/

RUN bundle config set without development && \
    bundle install && \
    rm -rf /usr/local/bundle/*/*/cache && \
    find /usr/local/bundle -name "*.c" -delete && \
    find /usr/local/bundle -name "*.o" -delete

COPY . $APP_HOME

#################################################

FROM ruby:3.1.2-alpine3.16

ENV APP_HOME /app

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

RUN adduser -D ruby
USER ruby

COPY --chown=ruby . $APP_HOME

WORKDIR $APP_HOME

CMD ["bundle", "exec", "rackup", "-p", "4000"]
