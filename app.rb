# frozen_string_literal: true

require "sinatra"
require "sinatra/reloader"
require "hamlit"
require "mail"
require "faraday"
require "json"

enable :reloader
set :haml, format: :html5

$stdout.sync = true

get "/" do
  haml :form
end

post "/" do
  @mail = Mail.new
  @mail.from = params["from"]
  @mail.reply_to = params["reply_to"] if params["reply_to"].to_s.strip != ""
  @mail.to = params["to"]
  @mail.cc = params["cc"]
  @mail.subject = params["subject"]
  if params["html"].to_s.strip != ""
    @mail.html_part = params["html"]
    @mail.text_part = params["body"] if params["body"].to_s.strip != ""
  else
    @mail.body = params["body"]
  end

  @result = Faraday.post(
    ENV["ENDPOINT"],
    JSON.generate(
      message(@mail)
    ),
    "Content-Type" => "application/json",
    "X_AMZ_SNS_MESSAGE_TYPE" => "Notification"
  )
  haml :form
end

post "/debug" do
  puts JSON.pretty_generate(JSON.parse(request.body.read))
end

def message(mail)
  {
    "Message" => JSON.generate(
      "content" => mail.to_s
    ),
    "MessageId" => SecureRandom.uuid,
    "Timestamp" => Time.now.iso8601,
    "TopicArn" => "arn",
    "Type" => "Notification"
  }
end
