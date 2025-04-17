---
title: Creating an endpoint in {{ cns-full-name }}
description: Follow this guide to create an endpoint.
---

# Creating an endpoint

Each channel has its own base of [endpoints](../../concepts/index.md#mobile-endpoints) to send notifications directly to the app on user devices.

To create an endpoint:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to the folder containing your endpoint.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select a push notification channel.
  1. Navigate to the ![image](../../../_assets/console-icons/layers-3-diagonal.svg) **{{ ui-key.yacloud.cns.label_endpoints }}** tab.
  1. Click **{{ ui-key.yacloud.cns.action_create-endpoint }}**.
  1. Enter **{{ ui-key.yacloud.cns.field_token }}**, a unique token on the user device, the one created by the notification service for the app.
  1. Optionally, enter **{{ ui-key.yacloud.cns.field_endpoint-user-data }}**, a [UTF-8](https://en.wikipedia.org/wiki/UTF-8) encoded text up to 2,048 characters long.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

      {% include [endpoint-create-aws](../../../_includes/notifications/endpoint-create-aws.md) %}

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To create an endpoint, use the following code:

      {% include [endpoint-create-python](../../../_includes/notifications/endpoint-create-python.md) %}

- AWS SDK for PHP {#php}

  1. If you do not have the AWS SDK for PHP yet, [install and configure it](../../tools/sdk-php.md#aws-sdk).
  1. To create an endpoint, use the following code:

      {% include [endpoint-create-php](../../../_includes/notifications/endpoint-create-php.md) %}


- API {#api}

  Use the [create](../../api-ref/create-platform-endpoint.md) HTTP API method for the Endpoint resource in {{ cns-full-name }}.

{% endlist %}

Creating an endpoint may take some time.
