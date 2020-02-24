# SNS email notification mocker

Sends mock SNS email notifications to an endpoint.

## Background

In order for an application to receive emails we use Amazon Simple Email Service (SES)
to send a notification to a http(s) endpoint using Amazon Simple Notification Service (SNS).

See https://docs.aws.amazon.com/ses/latest/DeveloperGuide/monitor-sending-activity-using-notifications-sns.html

This application allows you to send a test messages to that endpoint without configuring AWS.

## Usage

You will need to disable message verification in your application.
Only do this in development environments.

```
docker run
  --rm
  -p 4002:4000
  --env ENDPOINT=http://endpoint/for/sns/messages
  citizensadvice/sns-email-notification-mocker
```

Visit http://localhost:4002/

You may wish to add a script to your application to start this for you with
the appropriate settings for the application.

## Build

```
docker build -t citizensadvice/sns-email-notification-mocker .
```

## Local testing

```
docker-compose up
```
