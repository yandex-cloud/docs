# Tools for working with Yandex Message Queue

To work with the API, you can use any tools that are compatible with Amazon SQS: AWS CLI, Boto3, and other tools [supported by the SDK](https://aws.amazon.com/en/tools/#sdk).

## Before you start {#preparations}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

When configuring tools, use the following parameters:

* `AWS_ACCESS_KEY_ID` — the static key ID
* `AWS_SECRET_ACCESS_KEY` — the secret key
* Region — `ru-central1`
* Endpoint — `https://message-queue.api.cloud.yandex.net`

