---
title: Creating a subscription in {{ cns-full-name }}
description: Follow this guide to subscribe an endpoint to notifications in a topic.
---

# Creating a subscription

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the topic.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}** on the left.
  
  {% include [subscribe-ui](../../../_includes/notifications/subscribe-ui.md) %}

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  1. Run this command:

     {% include [subscribe-cli](../../../_includes/notifications/subscribe-cli.md) %}

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. Use the following code to subscribe an endpoint to notifications in a topic:
     
     {% include [subscribe-python](../../../_includes/notifications/subscribe-python.md) %}

{% endlist %}