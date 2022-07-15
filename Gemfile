# frozen_string_literal: true

ruby "3.1.2"
source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem "net-smtp"
gem "puma"
gem "sinatra"
gem "sinatra-contrib", require: false

gem "faraday"
gem "hamlit"
gem "mail"

group :development do
  gem "citizens-advice-style", github: "citizensadvice/citizens-advice-style-ruby", tag: "v9.0.0"
  gem "debug"
end
