# Configuring the AWS CLI

{% note warning %}

Currently, there is no support for the AWS CLI versions with JSON protocol. Use the [AWS CLI](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-json-faqs.html#json-protocol-getting-started) `1.29.81` or an older version.

{% endnote %}

You can manage queues and messages in {{ message-queue-name }} using the [AWS CLI](https://aws.amazon.com/cli/).

To configure the AWS CLI to work with {{ message-queue-name }}:

1. [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI.
1. [Create](../../iam/operations/sa/create.md) a service account with the `editor` role.
1. [Create](../../iam/operations/sa/create-access-key.md) static access keys. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.
1. Set up the AWS CLI:

   {% include [configure-aws-cli](../../_includes/message-queue/configure-aws-cli.md) %}