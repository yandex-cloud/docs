# Getting started with {{ cns-full-name }}

{% include [preview-stage](../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../_includes/notifications/ask-for-turning-on.md) %}

{% include [about-service](../_includes/notifications/about-service.md) %}

{% include [channels-push-preview](../_includes/notifications/channels-push-preview.md) %}

With {{ cns-name }}, you can send notifications to apps registered in the following services:
* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs)
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM)
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS)

Push notifications via the [RuStore](https://www.rustore.ru/help/sdk/push-notifications) platform will also be implemented later.

To get started with the service:
1. [Prepare your cloud](#before-you-begin).
1. [Create a notification channel](#create-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a notification channel {#create-channel}

In {{ cns-name }}, messages to end users are sent through [notification channels](./concepts/index.md#channels).

To create a channel:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a notification channel in.
  1. In the list of services, select **{{ cns-name }}**.
  1. Click **Create notification channel**.
  1. Select a platform for sending mobile push notifications:
      * `Apple iOS`: For iOS devices.
      * `Google Android`: For Android devices with Google Play services installed.
      * `Huawei Android`: For Android devices with Huawei services installed.
  1. Depending on the platform you select, set the authentication parameters:

      **Apple iOS**

      * Select the **Authentication method**: `Token` or `Certificate`.

        {% include [auth-apns](../_includes/notifications/auth-apns.md) %}

      * For **Environment**, select either `Development` or `Production`. Use `Development` to test the application.

      **Google Android**

      Specify which **FCM API version** will be used: `HTTP v1` or `Legacy`.

      {% include [auth-fcm](../_includes/notifications/auth-fcm.md) %}

      **Huawei Android**

      {% include [auth-hms](../_includes/notifications/auth-hms.md) %}

  1. Enter a **name** for your notification channel. The name must be unique within the [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud). It may contain lowercase and uppercase Latin letters, numbers, underscores, hyphens, and periods. It may be 1 to 256 characters long. For APNs channels, we recommend specifying the bundle ID in the name, and for FCM and HMS, the full package name.
  1. (Optional) Click ![image](../_assets/console-icons/plus.svg) **Add description** and enter a description for your notification channel.
  1. Click **Create**.

  Creating a notification channel may take some time.

{% endlist %}

## Create an endpoint {#create-endpoint}

Each channel has its own base of [endpoints](./concepts/index.md#mobile-endpoints) to send notifications directly to the app on user devices.

To create an endpoint:

{% list tabs group=instructions %}

- Management console {#console}

  1. Select the notification channel you previously created.
  1. Go to the ![image](../_assets/console-icons/layers-3-diagonal.svg) **Endpoints** tab.
  1. Click **Create endpoint**.
  1. Enter the **Device token**, i.e., a unique token on the user device created by the notification service for the app.
  1. (Optional) Enter the **User data**: [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded text up to 2,048 characters long.
  1. Click **Create**.

  Creating an endpoint may take some time.

{% endlist %}

## Send a notification {#publish}

{% list tabs group=instructions %}

- Management console {#console}

  1. Select the endpoint you previously created.
  1. Under **Sending notifications**, select the notification format: `Text` or `JSON`.
  1. Enter notification text or a JSON object with notification data.
  1. Click **Send**.

  Each sent notification is assigned a unique ID. To save it, click **Copy ID**.

  You can send a new notification immediately or resend the previous one.

{% endlist %}

## See also {#see-also}

* [Getting started with the AWS CLI in {{ cns-name }}](./tools/aws-cli.md)
* [{{ cns-name }} overview](./concepts/index.md)
