---
title: How to receive and delete messages in {{ message-queue-full-name }}
description: Follow this guide to receive and delete messages.
---

# Receiving and deleting messages

Messages queued in {{ message-queue-name }} are received by consumers, i.e., components of distributed applications. After messages are received and processed, they should be deleted from the queue.

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. [Install and configure](configuring-aws-cli.md) the AWS CLI.
  1. [Create](message-queue-new-queue.md) a message queue and [send](message-queue-send-message.md) a test message to it.
  1. Receive the message you sent earlier:

      ```bash
      aws sqs receive-message \
        --queue-url <queue_URL> \
        --endpoint <endpoint>
      ```

      Where:

      * `--queue-url`: URL of the queue to receive the message from.
      * `--endpoint`: Endpoint set to `https://message-queue.{{ api-host }}/`.

      Result:

      ```json
      {
          "Messages": [
              {
                  "MessageId": "948de7-9ec8d787-c*******-*",
                  "ReceiptHandle": "EAEggbj********",
                  "MD5OfBody": "ed076287532e86365e841e92********",
                  "Body": "Hello World",
                  "Attributes": {
                      "ApproximateFirstReceiveTimestamp": "15459********",
                      "ApproximateReceiveCount": "1",
                      "SentTimestamp": "15459********",
                      "SenderId": "abcdefkbh72is78********"
                  }
              }
          ]
      }
      ```

      Save the `ReceiptHandle` value: you will need it later.

      {% note info %}

      If there are no messages in the queue, the `aws sqs receive-message` command will end with no text output to the terminal.

      {% endnote %}

  1. To delete a message from a queue, use the [receipt ID](../concepts/message.md): the `ReceiptHandle` parameter value received together with the message.

     Delete the received message from the queue:

      ```bash
      aws sqs delete-message \
        --queue-url <queue_URL> \
        --endpoint <endpoint> \
        --receipt-handle <receipt_ID>
      ```

      Where:

      * `--queue-url`: URL of the queue to delete the message from.
      * `--endpoint`: Endpoint set to `https://message-queue.{{ api-host }}/`.
      * `--receipt-handle`: Previously saved message receipt ID (`ReceiptHandle`).

{% endlist %}

If the delete command is executed successfully, no text is output to the terminal. To check the deletion of the message:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you created the message queue.
  1. In the list of services, select **{{ message-queue-name }}**.
  1. The current number of enqueued messages is specified in the **Messages in queue** field.

{% endlist %}
