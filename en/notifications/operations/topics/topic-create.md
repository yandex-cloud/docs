---
title: Creating a topic in {{ cns-full-name }}
description: Follow this guide to create a topic.
---

# Create topic

{% list tabs group=instructions %}

- Management console {#console}

  {% include [topic-create-ui](../../../_includes/notifications/topic-create-ui.md) %}

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

     {% include [topic-create-cli](../../../_includes/notifications/topic-create-cli.md) %}

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. Use the following code to create a topic:

     {% include [topic-create-python](../../../_includes/notifications/topic-create-python.md) %}

{% endlist %}

Once you create a topic, you cannot change its name. To add endpoints to a topic, [create subscriptions](subscription-create.md).