# Tools for working with {{ message-queue-full-name }}

To work with the API, you can use any tools that are compatible with Amazon SQS: AWS CLI, Boto3, and other tools [supported by the SDK]{% if lang == "ru" %}(https://aws.amazon.com/ru/tools/#sdk){% endif %}{% if lang == "en" %}(https://aws.amazon.com/tools/#sdk){% endif %}.

## Before you start {#preparations}

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

When configuring tools, use the following parameters:

* `AWS_ACCESS_KEY_ID` — the static key ID
* `AWS_SECRET_ACCESS_KEY` — the secret key
* Region: `{{ region-id }}`.
* Endpoint: `https://message-queue.{{ api-host }}`

