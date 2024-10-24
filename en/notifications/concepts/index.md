# {{ cns-full-name }} overview

{% include [about-service](../../_includes/notifications/about-service.md) %}

{% include [preview-stage](../../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../../_includes/notifications/ask-for-turning-on.md) %}

Compatibility with the Amazon SNS API enables you to work with the service using the existing tools, such as the [AWS CLI](../tools/aws-cli.md) and AWS SDK.

## Notification channels {#channels}

In {{ cns-name }}, messages to end users are sent through _notification channels_.

{% include [channels-push-preview](../../_includes/notifications/channels-push-preview.md) %}

## Mobile push notifications {#mobile-push-notifications}

_Mobile push notifications_ are pop-up messages on your smartphone screen with information about a service event, available services, promotions, news, and updates.

Push notifications are sent via mobile platform notification services:
* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs)
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM)
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS)

Push notification via the [RuStore](https://www.rustore.ru/help/sdk/push-notifications) platform will also be implemented later.

Push notification delivery algorithm using FCM as an example:
1. In {{ cns-short-name }}, you create a [mobile push notification channel](#mobile-channel) for a specific platform (FCM) and your app.
1. FCM maintains a persistent network connection with all registered mobile devices to deliver push notifications to apps on those devices.
1. Your app on a particular device registers in FCM and receives a unique token to send push notifications to that device.
1. The token is stored in {{ cns-short-name }} as a parameter of the application's [mobile endpoint](#mobile-endpoints).
1. To send a notification, you publish a message in {{ cns-short-name }} and specify the endpoint ID (ARN) as the recipient.

### Mobile push notification channel {#mobile-channel}

Minimum list of source data to create a mobile push notification channel:

{% list tabs %}

- Apple iOS (APNs)

   {% include [auth-apns](../../_includes/notifications/auth-apns.md) %}

   The notification channel name must be unique in the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). For APNs channels, we recommend specifying the bundle ID in the name.

- Google Android (FCM)

   {% include [auth-fcm](../../_includes/notifications/auth-fcm.md) %}

   The notification channel name must be unique in the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). For FCM channels, we recommend specifying the full package name.

- Huawei Android (HMS)

   {% include [auth-hms](../../_includes/notifications/auth-hms.md) %}

   The channel name must be unique in the [cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud). For HMS channels, we recommend specifying the full package name.

{% endlist %}

Once you create a notification channel, it gets a unique ID (ARN).

### Mobile endpoints {#mobile-endpoints}

Each channel has its own base of _mobile endpoints_ to send notifications directly to the app on user devices.

A mobile endpoint contains information about a token to send push notifications to a specific device and notification channel ID (ARN).

### Token lifetime {#token-lifetime}

Push notification tokens have a limited lifetime that depends on a specific platform, user actions, and other factors.

{{ cns-short-name }} gets feedback from each platform when sending notifications and uses it to manage tokens. If the token has changed, {{ cns-short-name }} will write a new token to the endpoint, or delete the endpoint if the token is out of date.

Recommended algorithm for working with tokens using a mobile app:
1. The app registers in the mobile notification service, e.g., APNs, and receives a token to send push notifications.
1. The app provides the token to {{ cns-short-name }}, gets the endpoint ID (ARN), and stores it on the device.
1. Each time the app is launched, it registers again in the mobile notification service, e.g., APNs, and checks to see if the token has changed.
1. If the token has changed, the app provides the new token and the endpoint ID (ARN) to {{ cns-short-name }}. If such an endpoint ID (ARN) does not already exist for some reason, a new endpoint is created in {{ cns-short-name }} and stored in the app.

{% note tip %}

We do not recommend overwriting the token in the endpoint each time the app is launched. If the token has not changed, in some cases this may result in lost notifications.

{% endnote %}

## See also {#see-also}

* [{#T}](../quickstart.md)
* [{#T}](../tools/aws-cli.md)