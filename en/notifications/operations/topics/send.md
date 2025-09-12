---
title: Creating a topic in {{ cns-full-name }}
description: Follow this guide to send a notification to all endpoints subscribed to a topic.
---

# Sending a notification to a topic

{% list tabs group=instructions %}

- Management console {#console}

  {% include [publish-ui](../../../_includes/notifications/publish-ui.md) %}

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

     {% include [publish-cli](../../../_includes/notifications/publish-cli.md) %}

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To create a push notification channel, use the following code:

     {% include [publish-python](../../../_includes/notifications/publish-python.md) %}

{% endlist %}