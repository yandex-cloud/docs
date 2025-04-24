# In-browser push notifications

_In-browser push notifications_ are messages popping up in your browser.

Push notifications may inform you about new content, special offers, and other key updates. Browser notifications work across different platforms: desktops, smartphones, and tablets with any OS. Users do not need to install additional software to receive notifications, a standard browser is enough.

Push notifications are also supported in progressive web apps ([PWA](https://ru.wikipedia.org/wiki/Прогрессивное_веб-приложение)). A PWA is a web application that runs in a browser but also has mobile app features. For example, PWAs can work offline but do not require users to download updates; updates are deployed on the server side.

To send a notification to the browser over a secure channel, the user must subscribe to notifications through the notification server used by their browser. Then you need to create an endpoint for this user in the {{ cns-short-name }} notification channel.

{% include [limits-warning](../../_includes/notifications/limits-warning.md) %}

To set up push notifications:

1. In {{ cns-short-name }}, create the **{{ ui-key.yacloud.cns.type_web }}** channel.
1. From the user browser, call the JavaScript [subscribe](https://developer.mozilla.org/en-US/docs/Web/API/PushManager/subscribe#applications) method using a [Service Worker](https://developer.mozilla.org/ru/docs/Web/API/Service_Worker_API/Using_Service_Workers).

   When the method is called, the browser sends a request to its notification delivery server. For example, Google Chrome sends a request to Firebase Cloud Messaging (FCM), and Safari, to Apple Push Notification service (APNs). The response will return a [PushSubscription](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription) object.

1. Convert the object you got to JSON by calling the [toJSON](https://developer.mozilla.org/en-US/docs/Web/API/PushSubscription/toJSON) method.

1. Use this JSON when creating the endpoint. Through this endpoint, you will send notifications to the user.

1. To send a notification, create a message in {{ cns-short-name }} and specify the endpoint ID (ARN) as the recipient.

To send notifications to different users, create a database of endpoints for all users.

This is how push notifications are delivered:

1. Your web app initiates a notification through an in-browser push notification channel.
1. {{ cns-short-name }} receives the send command.
1. {{ cns-short-name }} sends notifications to the servers specified in the endpoints.
1. Notification servers (FCM, APNs) deliver notifications to user browsers.

Working with in-browser push notifications is similar to working with mobile ones.

#### See also {#see-also}

* [Service overview](index.md)
* [Getting started with push notifications](../quickstart-push.md)
* [Getting started with the service via the AWS CLI](../tools/aws-cli.md)
* [SMS](sms.md)