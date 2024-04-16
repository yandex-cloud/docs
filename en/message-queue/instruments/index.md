# Tools for working with {{ message-queue-full-name }}

{% note warning %}

Currently, there is no support for the latest versions of the `AWS CLI` and `AWS SDK` with JSON protocol. Use [AWS CLI and AWS SDK](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-json-faqs.html#json-protocol-getting-started) without JSON support.

{% endnote %}

To work with the API, you can use any tools that are compatible with Amazon SQS: AWS CLI, Boto3 (prior to version 1.28.0), and other tools [supported by the SDK](https://aws.amazon.com/tools/#sdk).

## Getting started {#preparations}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

Use the following parameters when configuring the tools:

* `AWS_ACCESS_KEY_ID`: Static key ID.
* `AWS_SECRET_ACCESS_KEY`: Secret key.
* Region: `{{ region-id }}`.
* Endpoint: `https://message-queue.{{ api-host }}`.

