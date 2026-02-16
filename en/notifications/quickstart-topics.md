---
title: Getting started with topics in {{ cns-full-name }}
description: In {{ cns-name }}, you can send notifications to different endpoints subscribed to a topic.
---

# Getting started with topics in {{ cns-full-name }}

{% include [preview-stage](../_includes/notifications/preview-stage.md) %}

{% include [ask-for-turning-on](../_includes/notifications/ask-for-turning-on.md) %}

{% include [about-service](../_includes/notifications/about-service.md) %}

To send messages to different endpoints at the same time, use topics. You can subscribe the endpoints to a _topic_ and send notifications to all of them at once.

To get started with topics:

1. [Get your cloud ready](#before-you-begin).
1. Create notification channels and endpoints: 
   
   * [Mobile push notifications](quickstart-push.md)
   * [In-browser push notifications](quickstart-browser.md)
   * [SMS](quickstart-sms.md) 
      For SMS notifications, you may add phone numbers directly to the topic rather than the channel.

1. [Create a topic](#create-topic).
1. [Subscribe endpoints to the topic](#subscribe-endpoints).
1. [Send a notification to the topic](#send-message).

# Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create the topic {#create-topic}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [topic-create-ui](../_includes/notifications/topic-create-ui.md) %}

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../storage/tools/aws-cli.md).
  1. Run this command:

     {% include [topic-create-cli](../_includes/notifications/topic-create-cli.md) %}

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](tools/sdk-python.md#aws-sdk).
  1. To create a push notification channel, use the following code:

     {% include [topic-create-python](../_includes/notifications/topic-create-python.md) %}

{% endlist %}

## Subscribe endpoints to the topic {#subscribe-endpoints}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [topic-create-ui](../_includes/notifications/subscribe-ui.md) %}

- AWS CLI {#aws-cli}

   Run this command:

   {% include [topic-create-cli](../_includes/notifications/subscribe-cli.md) %}

- AWS SDK for Python {#python}

  Use the following code:

  {% include [topic-create-python](../_includes/notifications/subscribe-python.md) %}

{% endlist %}

## Send a notification to the topic {#send-message}

{% list tabs group=instructions %}

- Management console {#console}

  {% include [topic-create-ui](../_includes/notifications/publish-ui.md) %}

- AWS CLI {#aws-cli}

  Run this command:

  {% include [publish-cli](../_includes/notifications/publish-cli.md) %}

- AWS SDK for Python {#python}

  Use the following code:

  {% include [topic-create-python](../_includes/notifications/publish-python.md) %}

{% endlist %}