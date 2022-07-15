FROM ruby:3.1.2-alpine3.16 AS builder

ENV APP_HOME /app
ENV LANG C.UTF-8

RUN apk add --update --no-cache build-base git

WORKDIR $APP_HOME
COPY Gemfile* /app/

RUN bundle install && \
    rm -rf /usr/local/bundle/*/*/cache && \
    find /usr/local/bundle -name "*.c" -delete && \
    find /usr/local/bundle -name "*.o" -delete

COPY . $APP_HOME

#################################################

FROM ruby:3.1.2-alpine3.16

ENV APP_HOME /app
ENV RACK_ENV=production

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

RUN addgroup ruby -g 3000 && adduser -D -h /home/ruby -u 3000 -G ruby ruby

COPY --chown=ruby . $APP_ROOT
WORKDIR $APP_ROOT

USER ruby

CMD ["bundle", "exec", "rackup", "-p", "4000"]
