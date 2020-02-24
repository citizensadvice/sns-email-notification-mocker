FROM ruby:2.6.5-alpine3.10

ENV APP_ROOT /app

WORKDIR $APP_ROOT

RUN apk add --update --no-cache build-base git
ADD Gemfile* ./
RUN gem install bundler && bundle install -j3 && bundle clean --force

COPY . ./

CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "4000"]
