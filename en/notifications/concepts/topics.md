# Topics

To send a notification to multiple endpoints at once, use _topics_. Topics also allow you to group messages by category, e.g., security alerts, promotional messages, etc. To group messages, create a separate topic for each category.

Topics enable you to target messages to all endpoints or phone numbers subscribed to the relevant topic. Each topic has an ARN, its unique identifier.

To add endpoints to a topic, you can use a _subscription_. A subscription associates a topic with a single endpoint added to a notification channel. You do not need to pre-add phone numbers to a notification channel. To send messages to different endpoints, subscribe all these endpoints to the relevant topic.

This is how you set up topics:

1. Use {{ cns-short-name }} to create notification channels.
1. Add endpoints to the notification channels. For SMS, adding an endpoint is optional.
1. Create a topic and enable logging to keep track of sent notifications.
1. Add a subscription to the topic, specifying the ARN of the previously created endpoint or a phone number for SMS notifications.

This is how you send notifications:

1. You can send a notification to the topic's ARN via the SDK or API using the `Publish` method.
   
    You can also use the [management console]({{ link-console-main }}).

    Notification format in JSON:

    {% include [topic-message-json](../../_includes/notifications/topic-message-json.md) %}

    You can use the same text for all channel types or add different texts for each channel. If you provide no notification message for a particular channel, the default text will be used.

1. {{ cns-short-name }} validates the request.
1. If the request is valid, authenticated and authorized, the system sends the notification to all topics’ subscribers.
1. If there is an error, e.g., the limits are exceeded, it will be logged in {{ cloud-logging-name }}. Logging is enabled when you create a topic.

## See also {#see-also}

* [Service overview](index.md)
* [Getting started with the service via the AWS CLI](../tools/aws-cli.md)
* [How to get started with mobile push notifications](../quickstart-push.md)
* [How to get started with browser push notifications](../quickstart-browser.md)
* [Getting started with SMS](../quickstart-sms.md)