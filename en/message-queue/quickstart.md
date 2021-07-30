---
title: "Getting started with Yandex Message Queue"
description: "In this tutorial, you will learn how to perform basic operations with message queues in Yandex Message Queue. First, install the AWS CLI, a command line utility for working with Message Queue."
---

# Getting started with {{ message-queue-name }}

Let's perform the basic actions using the AWS CLI, one of the [tools](instruments/index.md) for working with Message Queue.

1. Install the [AWS CLI](https://aws.amazon.com/cli/), a command line utility for working with Message Queue.

1. Create a [service account](../iam/operations/sa/create.md) with the `editor` role.

1. Create [static access keys](../iam/operations/sa/create-access-key.md). Save the ID and secret access key right away. You won't be able to view the secret access key parameters again after you close the window.

1. Set up the AWS CLI.

   {% list tabs %}

   - AWS CLI

     Set the AWS CLI configuration via the `aws configure` command, using the ID and secret access key of the service account:

     ```
     aws configure
     AWS Access Key ID [****************kzJl]: <ID of the service account's access key
     AWS Secret Access Key [****************I3AO]: <ID of the service account's access key
     Default region name [eu-west-1]: ru-central1
     Default output format [None]:
     ```

   {% endlist %}

1. Create a queue named `sample-queue`:

   {% list tabs %}

   - AWS CLI

     ```
     aws sqs create-queue --queue-name sample-queue \
                 --endpoint https://message-queue.api.cloud.yandex.net/
     {
         "QueueUrl": "https://message-queue.api.cloud.yandex.net/aoeaql9r10cd9cfue7v6/000000000000002n034r/sample-queue"
     }
     ```

   - Management console

     1. Open the **Message Queue** section.

     1. Click **Create queue**.

     1. Specify the queue name: `sample-queue`.

        {% include [name](../_includes/message-queue/ymq-name.md) %}

     1. Select the **Standard** type. Do not change other settings.

     1. Click **Create queue**.

   {% endlist %}

1. Send a message to the created queue using the queue URL from the `QueueUrl` parameter that can be found in the response to the previous request:

   {% list tabs %}

   - AWS CLI

     ```
     aws sqs send-message --message-body "Hello World" \
                 --endpoint https://message-queue.api.cloud.yandex.net/ \
                 --queue-url https://message-queue.api.cloud.yandex.net/aoeaql9r10cd9cfue7v6/000000000000002l034r/sample-queue
     {
         "MD5OfMessageBody": "67e63db14341b5a696596634bbf19796",
         "MessageId": "765ff4d2-fa4bc83-6cfcc68e-21a49"
     }
     ```

   {% endlist %}

1. Accept the message from the queue:

   {% list tabs %}

   - AWS CLI

     ```
     aws sqs receive-message \
                 --endpoint https://message-queue.api.cloud.yandex.net/ \
                 --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue
     {
         "Messages": [
             {
                 "MessageId": "948de7-9ec8d787-cbf3465c-c",
                 "ReceiptHandle": "EAEggbjIg_8sKAM",
                 "MD5OfBody": "ed076287532e86365e841e92bfc50d8c",
                 "Body": "Hello World",
                 "Attributes": {
                     "ApproximateFirstReceiveTimestamp": "1545927269377",
                     "ApproximateReceiveCount": "1",
                     "SentTimestamp": "1545922344034"
                 }
             }
         ]
     }
     ```

   {% endlist %}

1. Delete the message from the queue.

   After messages are processed, they should be deleted from the queue so that applications do not process them again.

   To delete the received message from the queue, use the `ReceiptHandle` parameter value from the response to the previous request:

   {% list tabs %}

   - AWS CLI

     ```
     aws sqs delete-message \
                 --endpoint https://message-queue.api.cloud.yandex.net/ \
                 --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue \
                 --receipt-handle EAEggbjIg_8sKAM
     ```

   {% endlist %}

1. Delete the queue:

   {% list tabs %}

   - AWS CLI

     ```
     aws sqs delete-queue \
                 --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue \
                 --endpoint https://message-queue.api.cloud.yandex.net/
     ```

   - Management console
     1. Open the **Message Queue** section.
     1. Click ![image](../_assets/vertical-ellipsis.svg) in the row of the queue to delete.
     1. In the menu that opens, click **Delete**.
     1. In the window that opens, click **Delete**.
{% endlist %}

