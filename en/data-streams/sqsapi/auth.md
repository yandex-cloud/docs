---
title: Authenticating and connecting to a database via the Amazon SQS-compatible HTTP API
description: In this tutorial, you will learn how to authenticate and establish a database connection using the Amazon SQS-compatible HTTP API.
---

# Authenticating and connecting to a database via the Amazon SQS-compatible HTTP API

## Endpoint {#endpoint}

The connection endpoint is displayed in the [management console]({{ link-console-main }}) on your database page. This endpoint is identical for both Amazon Kinesis Data Streams and Amazon Simple Queue Service (SQS) protocols.

## Prerequisites {#requirements}

To authenticate, take these steps:

1. [Create a service account](../../iam/operations/sa/create.md).
1. [Assign the following roles to the service account](../../iam/operations/sa/assign-role-for-sa.md):
   * To read from a data stream: `ydb.viewer`.
   * To write to a data stream: `ydb.editor`.
   * To create or delete a queue: `ydb.editor`.
1. [Create a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key) for the service account. Save the ID and secret key to a secure location.

## Authentication {#auth}

Just like Amazon SQS, the Amazon SQS-compatible HTTP API uses [Signature Version 4](https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-api-request-authentication.html) to authenticate requests.

The following parameters are required:

* `<access_key_id>`: [Static access key](../../iam/concepts/authorization/access-key.md) ID.
* `<secret_access_key>`: Secret part of the static access key.

Configure the AWS CLI:

{% include [configure-aws-cli](../../_includes/message-queue/configure-aws-cli.md) %}

## Queue creation example {#create-queue}

This example uses the following parameters:

* `<sqs_api_endpoint>`: [Endpoint](#endpoint).
* `<stream_name>`: [Data stream](../concepts/glossary.md#stream-concepts) name.

1. Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) if you have not done that already.

1. Create a queue:

   ```bash
   aws --endpoint "<sqs_api_endpoint>" sqs create-queue \
     --queue-name "<stream_name>"
   ```

   This command creates a data stream with the specified name and a shared consumer named `ydb-sqs-consumer`.

   To create a FIFO queue, specify `FifoQueue=true`. We recommend appending `.fifo` to the queue name:

   ```bash
   aws --endpoint "<sqs_api_endpoint>" sqs create-queue \
     --queue-name "<stream_name>.fifo" \
     --attributes FifoQueue=true
   ```

## Example of writing and reading a message {#example}

This example uses the following parameters:

* `<sqs_api_endpoint>`: [Endpoint](#endpoint).
* `<stream_name>`: [Data stream](../concepts/glossary.md#stream-concepts) name.

1. Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) if you have not done that already.

1. Get the stream `QueueUrl`:

   ```bash
   QUEUE_URL="$(aws --endpoint "<sqs_api_endpoint>" sqs get-queue-url \
     --queue-name "<stream_name>" \
     --query 'QueueUrl' --output text)"
   ```

1. Send a message to the stream:

   ```bash
   aws --endpoint "<sqs_api_endpoint>" sqs send-message \
     --queue-url "$QUEUE_URL" \
     --message-body "test message"
   ```

1. Read a message from the stream:

   ```bash
   aws --endpoint "<sqs_api_endpoint>" sqs receive-message \
     --queue-url "$QUEUE_URL" \
     --wait-time-seconds 20 \
     --max-number-of-messages 1
   ```

For details on working with {{ yds-name }} via an Amazon SQS-compatible HTTP API and more examples, refer to the [YDB guides]({{ ydb.docs }}/reference/sqs-api/?version=v26.3).
