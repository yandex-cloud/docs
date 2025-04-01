---
title: '{{ message-queue-full-name }}. FAQ'
description: How do I get the logs of my actions in {{ message-queue-full-name }}? Find the answer to this and other questions in this article.
---

# General questions about {{ message-queue-name }}

#### What does the "Cannot create queue: Too many queues" error mean when creating a new queue? {#to-many-queues-err}

This error means that the limit on the maximum number of queues has been reached. To increase the limit, contact [support]({{ link-console-support }}). In your request, specify:

1. ID of the cloud to increase the limit for.
1. Required number of queues.
1. Reason for having that many queues.

#### Do I need to create an account in Amazon to use the AWS CLI for {{ message-queue-name }}?

No, you can use the AWS CLI without creating an account in AWS and obtaining AWS keys. For more information, see [{#T}](../instruments/index.md).

#### What kind of access key do I need to use {{ message-queue-name }}?

To work with the AWS CLI and {{ message-queue-name }}, a static access key is required. To create a key, follow this [guide](../../iam/operations/authentication/manage-access-keys.md#create-access-key).

#### What is the maximum message size?

The maximum size of a message is 256 KB. To learn more about other limits, see [{#T}](../concepts/limits.md).

#### What SLA applies to {{ message-queue-name }}?

{{ message-queue-name }} has an SLA for 99.9% service availability.

#### Can I monitor {{ message-queue-name }} myself using {{ prometheus-name }}?

Yes, you can [export metrics to {{ prometheus-name }}](../../monitoring/operations/metric/prometheusExport.md) and [get a list of metrics](../../monitoring/operations/metric/list.md) for various objects.

#### What should I specify in Default output format \[None\] when configuring the AWS CLI?

Leave this field empty. When configuring the AWS CLI, first specify the key ID and then the secret key.

#### Why are all of my messages stuck in a queue with the "Processing" status for a long time?

This may be due to a large [visibility timeout](../concepts/visibility-timeout.md) value set in the queue settings. The visibility timeout is the period during which a message is hidden from a queue after a consumer read a message.

#### How do I delete a message and its duplicate from a queue if I can only use ReceiptHandle for deleting and cannot sort messages by MessageDeduplicationId?

No message duplicates will be recorded for 5 minutes. After 5 minutes, you should delete a message duplicate based on its own `ReceiptHandle`.

You may see duplicates while reading if the service has not yet deleted the message after the [visibility timeout](../concepts/visibility-timeout.md) expired. In this case, consider extending the timeout.

{% include [logs](../../_qa/logs.md) %}
