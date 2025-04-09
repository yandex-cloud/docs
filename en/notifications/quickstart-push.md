---
title: Getting started with push notifications in {{ cns-full-name }}
description: 'With {{ cns-name }}, you can send push notifications to apps registered in the following services: Apple Push Notification service (APNs), Firebase Cloud Messaging (FCM), Huawei Mobile Services (HMS).'
---


# Getting started with push notifications in {{ cns-full-name }}

{% include [preview-stage](../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../_includes/notifications/ask-for-turning-on.md) %}

{% include [about-service](../_includes/notifications/about-service.md) %}

With {{ cns-name }}, you can send push notifications to apps registered in the following services:
* [Apple Push Notification service](https://developer.apple.com/notifications/) (APNs).
* [Firebase Cloud Messaging](https://firebase.google.com/) (FCM).
* [Huawei Mobile Services](https://developer.huawei.com/consumer/) (HMS).
* [RuStore](https://www.rustore.ru/help/sdk/push-notifications/).

To get started with push notifications:
1. [Get your cloud ready](#before-you-begin).
1. [Create a push notification channel](#create-channel).
1. [Create an endpoint](#create-endpoint).
1. [Send a notification](#publish).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a push notification channel {#create-channel}

In {{ cns-name }}, messages to end users are sent through [notification channels](./concepts/index.md#channels).

To create a channel:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [push-channel-create](../_includes/notifications/push-channel-create.md) %}

{% endlist %}

Creating a notification channel may take some time.

## Create an endpoint {#create-endpoint}

Each channel has its own base of [endpoints](./concepts/index.md#mobile-endpoints) to send notifications directly to the app on user devices.

To create an endpoint:

{% list tabs group=instructions %}

- Management console {#console}

  1. Select the notification channel you previously created.
  1. Navigate to the ![image](../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}** tab.
  1. Click **{{ ui-key.yacloud.cns.action_create-endpoint }}**.
  1. Enter **{{ ui-key.yacloud.cns.field_token }}**, a unique token residing on the user device, created by the notification service for the app.
  1. Optionally, enter **{{ ui-key.yacloud.cns.field_endpoint-user-data }}**, a [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded text up to 2,048 characters long.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  Creating an endpoint may take some time.

{% endlist %}

## Send a notification {#publish}

{% list tabs group=instructions %}

- Management console {#console}

  1. Select the endpoint you previously created.
  1. Under **{{ ui-key.yacloud.cns.section_message-sending }}**, select a notification format, `{{ ui-key.yacloud.cns.label_editor-text }}` or `{{ ui-key.yacloud.cns.label_editor-json }}`.
  1. Enter notification text or a JSON object with notification data.
  1. Click **{{ ui-key.yacloud.cns.action_send-msg }}**.
  
  Each sent notification is assigned a unique ID. To save it, click **{{ ui-key.yacloud.cns.action_copy-msg-id }}**.

  You can send a new notification immediately or resend the previous one.

{% endlist %}

## See also {#see-also}

* [Getting started with SMS](quickstart-sms.md)
* [Getting started with the service via the AWS CLI](./tools/aws-cli.md)
* [Service overview](./concepts/index.md)
* [Mobile push notification channel](./concepts/push.md)
