---
title: Creating a push notification channel in {{ cns-full-name }}
description: Follow this guide to create a push notification channel.
---

# Creating a push notification channel

In {{ cns-name }}, messages to end users are sent through [notification channels](../../concepts/index.md#channels).

To create a channel:

{% list tabs group=instructions %}

- Management console {#console}

  {% include [push-channel-create](../../../_includes/notifications/push-channel-create.md) %}

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

      {% include [push-channel-create-aws](../../../_includes/notifications/push-channel-create-aws.md) %}

- AWS SDK for Python (boto3) {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To create a push notification channel, use the following code:

      {% include [push-channel-create-python](../../../_includes/notifications/push-channel-create-python.md) %}

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To create a push notification channel, use the following code:

      {% include [push-channel-create-php](../../../_includes/notifications/push-channel-create-php.md) %}

- API {#api}

  Use the [create](../../api-ref/create-platform-application.md) HTTP API method for the _PlatformApplications_ resource in {{ cns-full-name }}.

{% endlist %}

Creating a notification channel may take some time.