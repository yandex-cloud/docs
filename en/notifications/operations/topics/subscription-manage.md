---
title: Creating a subscription in {{ cns-full-name }}
description: Follow this guide to subscribe an endpoint to notifications in a topic.
---

# Managing a subscription

## Updating a subscription {#subscribe-update}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the topic.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}** on the left.
  1. Select the topic containing the subscription.
  1. Select **{{ ui-key.yacloud.cns.shared.CnsTopicLayout.subscriptions_cp53u }}** on the left.
  1. Select the subscription and specify the new settings.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- AWS CLI {#aws-cli}

  1. View the list of subscriptions for the topic:
     ```bash
     aws sns set-subscription-attributes \
      --subscription-arn **subscription_ARN** <attributes>
     ```
  1. Update the subscription:
     ```bash
     aws sns set-subscription-attributes \
      --subscription-arn **subscription_ARN** <attributes>
     ```
  1. View the new subscription settings:
     ```bash
     aws sns get-subscription-attributes \
      --subscription-arn **subscription_ARN**
     ```

  For more information about the [set-subscription-attributes](https://docs.aws.amazon.com/cli/latest/reference/sns/set-subscription-attributes.html) and [get-subscription-attributes](https://docs.aws.amazon.com/cli/latest/reference/sns/get-subscription-attributes.html) commands, see the AWS documentation.

- AWS SDK for Python {#python}

  To update a subscription, use the code below:

  ```python
  try:
    response = sns.set_subscription_attributes(
      SubscriptionArn='<subscription_arn>',
      AttributeName='<attribute_name>',
      AttributeValue='<new_value>'
    )
  ```

{% endlist %}

## Deleting a subscription {#subscribe-delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the topic.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}** on the left.
  1. Select the topic containing the subscription.
  1. Select **{{ ui-key.yacloud.cns.shared.CnsTopicLayout.subscriptions_cp53u }}** on the left.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the subscription and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- AWS CLI {#aws-cli}

  Run this command:

  ```bash
  aws sns unsubscribe --subscription-arn **subscription_ARN**
  ```

  For more information about the `aws sns unsubscribe` command, see the [AWS documentation](https://docs.aws.amazon.com/cli/latest/reference/sns/unsubscribe.html).

- AWS SDK for Python {#python}

  Use the following code:

  ```python
  try:
    response = sns.unsubscribe(
      SubscriptionArn='**subscription_ARN**'
  ```

{% endlist %}

Deleting a subscription does not delete the endpoint associated with it.