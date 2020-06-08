FROM ruby:2.6.5-alpine3.10

ENV APP_ROOT /app

WORKDIR $APP_ROOT

ADD Gemfile* ./

RUN apk add --update --no-cache build-base git && \
    gem install bundler && bundle install -j3 --without development && bundle clean --force && \
    apk del --purge build-base git

COPY . ./

CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "4000"]
