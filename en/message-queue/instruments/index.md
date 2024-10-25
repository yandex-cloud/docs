# Tools for working with {{ message-queue-full-name }}

To access the API, use any Amazon SQS compatible tools, such as AWS CLI, Boto3, or other [supported by SDK](https://aws.amazon.com/tools/#sdk).

## Getting started {#preparations}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

Use the following parameters when configuring the tools:

* Static key ID for `AWS_ACCESS_KEY_ID`
* Secret key for `AWS_SECRET_ACCESS_KEY`
* `{{ region-id }}` for the region
* `https://message-queue.{{ api-host }}` for the endpoint

