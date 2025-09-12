---
title: Managing a topic in {{ cns-full-name }}
description: Follow this guide to update or delete a topic.
---

# Managing a topic

## Updating a topic {#topic-update}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the topic.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}** on the left.
  1. Select the topic.
  1. At the top right, click ![image](../../../_assets/edit.svg) **{{ ui-key.yacloud.common.edit }}**.
  1. Edit the topic name. The name must be unique within {{ cns-name }}.
  1. Under **{{ ui-key.yacloud.cns.section_logging }}**, enable or disable **{{ ui-key.yacloud.cns.field_logging }}**.
  1. Update the existing log group or create a new one.
  1. Click **{{ ui-key.yacloud.common.save-changes }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../../storage/tools/aws-cli.md).
  
  1. Run this command:

     ```bash
     aws sns set-topic-attributes \
      --topic-arn <topic_ARN> <attributes>
     ```
  1. View the new topic settings:

     ```bash
     aws sns get-topic-attributes \
      --topic-arn <topic_ARN>
     ```
     
  For more information about the [set-topic-attributes](https://docs.aws.amazon.com/cli/latest/reference/sns/set-topic-attributes.html) and [get-topic-attributes](https://docs.aws.amazon.com/cli/latest/reference/sns/get-topic-attributes.html) commands, see the AWS documentation.

- AWS SDK for Python {#python}

  1. If you do not have the AWS SDK for Python (boto3) yet, [install and configure it](../../tools/sdk-python.md#aws-sdk).
  1. To update a topic, use the code below:

     ```python
     try:
       response = client.set_topic_attributes(
          TopicArn = "<topic_ARN>",
          AttributeName='<attribute_name>',
          AttributeValue='<attribute_value>'
       )
     print("Response metadata:", response['ResponseMetadata'])
     ```

{% endlist %}

## Deleting a topic {#topic-delete}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder containing the topic.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cns }}**.
  1. Select **{{ ui-key.yacloud.cns.local.label_topics_vhBR3 }}** on the left.
  1. Click ![image](../../../_assets/console-icons/ellipsis.svg) next to the topic of interest and select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm the deletion.

- AWS CLI {#aws-cli}

  Run this command:

  ```bash
  aws sns delete-topic --topic-arn <topic_ARN>
  ```

  For more information about the `aws sns delete-topic` command, see the [AWS documentation](https://docs.amazonaws.cn/en_us/sns/latest/dg/sns-delete-subscription-topic.html).

- AWS SDK for Python {#python}

  Use the following code:

  ```python
  @staticmethod
    def delete_topic(topic):

        try:
            topic.delete()
            logger.info("Deleted topic %s.", topic.arn)
        except ClientError:
            logger.exception("Couldn't delete topic %s.", topic.arn)
            raise
  ```

{% endlist %}

Deleting a topic will also delete all its subscriptions. The endpoints associated with the subscriptions will remain. Topic deletion may take a while. You cannot create a new topic with the same name while the topic is being deleted.