# Mobile push notifications

_Push notifications_ are pop-up messages on your smartphone screen with information about {{ cns-full-name }} events, its services, promotions, news, and updates.

Push notifications are sent via mobile platform notification services:
* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs).
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM).
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS).
* [RuStore](https://www.rustore.ru/help/sdk/push-notifications/).

{% include [limits-warning](../../_includes/notifications/limits-warning.md) %}

Push notification delivery algorithm using FCM as an example:
1. In {{ cns-short-name }}, you create a [mobile push notification channel](#mobile-channel) for a specific platform (FCM) and your app.
1. FCM maintains a persistent network connection with all registered mobile devices to deliver push notifications to apps on those devices.
1. Your app on a particular device registers in FCM and receives a unique token to send push notifications to that device.
1. The token is stored in {{ cns-short-name }} as a parameter of the application's [mobile endpoint](#mobile-endpoints). 
1. To send a notification, you publish a message in {{ cns-short-name }} and specify the endpoint ID (ARN) as the recipient.

## Mobile push notification channel {#mobile-channel}

_Mobile push notification_ channel is a tool for message delivery via a notification service. Notification channels correspond to platforms where you can send push notifications.

Channel names are unique within the entire {{ cns-short-name }}. You cannot create a channel with a name that is already taken. Once you create a channel, you cannot change its name.

The minimum information you need to create a channel depends on the platform and may include:

* Key or key ID, token, or certificate.
* Developer, application, or project ID.

For the full list of details required for each notification channel, see [{#T}](../operations/push/channel-create.md). You can get your authentication parameters in the developer console of the relevant mobile platform.

Once you create a notification channel, it gets a unique ID (ARN).

## Mobile endpoints {#mobile-endpoints}

Each channel has its own base of _mobile endpoints_ to send notifications directly to the app on user devices.

A mobile endpoint contains information about a token to send push notifications to a specific device and notification channel ID (ARN). 

## Token lifetime {#token-lifetime}

Push notification tokens have a limited lifetime that depends on a specific platform, user actions, and other factors.

{{ cns-short-name }} gets feedback from each platform when sending notifications and uses it to manage tokens. If a token is out of date, {{ cns-short-name }} will delete the endpoint.

Recommended algorithm for working with tokens using a mobile app:
1. The app registers in the mobile notification service, e.g., APNs, and receives a token to send push notifications.
1. The app provides the token to {{ cns-short-name }}, gets the endpoint ID (ARN), and stores it on the device.
1. Each time the app is launched, it registers again in the mobile notification service, e.g., APNs, and checks to see if the token has changed.
1. If the token has changed, the app provides the new token and the endpoint ID (ARN) to {{ cns-short-name }}. If such an endpoint ID (ARN) does not already exist for some reason, a new endpoint is created in {{ cns-short-name }} and stored in the app.

{% note tip %}

We do not recommend overwriting the token in the endpoint each time the app is launched. If the token has not changed, in some cases this may result in lost notifications.

{% endnote %}

## See also {#see-also}

* [Service overview](index.md)
* [Getting started with push notifications](../quickstart-push.md)
* [Getting started with the service via the AWS CLI](../tools/aws-cli.md)
* [SMS](sms.md)