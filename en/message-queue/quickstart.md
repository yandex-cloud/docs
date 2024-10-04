---
title: Getting started with {{ message-queue-full-name }}
description: In this tutorial, you will learn how to make basic actions with message queues in {{ message-queue-full-name }}. First of all, install the AWS CLI, a command line utility for working with {{ message-queue-name }}.
---

# Getting started with {{ message-queue-name }}

Let's perform the basic actions using the [AWS CLI](https://aws.amazon.com/cli/), one of the [tools](instruments/index.md) you can use to work with {{ message-queue-name }}.

1. [Install](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) the AWS CLI, a command line utility for working with {{ message-queue-name }}.

   {% note warning %}

   Currently, there is no support for the new AWS CLI versions with JSON protocol. Use [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-version.html#:~:text=Install%20past%20releases%20of%20the%20AWS%20CLI%20version%202) 2.13.33 or lower until the `AWS JSON-1.0 protocol` protocol is deployed.

   {% endnote %}

1. [Create](../iam/operations/sa/create.md) a service account with the `editor` role.
1. [Create](../iam/operations/sa/create-access-key.md) static access keys. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.
1. Set up the AWS CLI:

   {% include [configure-aws-cli](../_includes/message-queue/configure-aws-cli.md) %}

1. Create a queue named `sample-queue`:

   {% list tabs group=instructions %}

   - AWS CLI {#cli}
  
     ```bash
     aws sqs create-queue \
       --queue-name <queue_name> \
       --endpoint <endpoint>
     ```

     ```bash
     aws sqs create-queue \
       --queue-name <queue_name> \
       --endpoint <endpoint>
     ```

     Where:

     * `--queue-name`: Name of the new queue, e.g., `sample-queue`.
     * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.

     Result:

     ```json
     {
         "QueueUrl": "https://message-queue.{{ api-host }}/aoeaql9r10cd********/000000000000********/sample-queue"
     }
     ```

     Save the obtained queue URL. You will need it at the next steps.

   - Management console

     1. In the [management console]({{ link-console-main }}), select the folder to create the queue in.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
     1. Click **{{ ui-key.yacloud.ymq.queues.button_create }}**.
     1. Enter a name for the queue: `sample-queue`.
        {% include [name](../_includes/message-queue/ymq-name.md) %}

     1. Select the `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}` type. Do not change other settings.
     1. Click **{{ ui-key.yacloud.common.create }}**.
     1. Open the queue you created.
     1. In the **{{ ui-key.yacloud.common.overview }}** tab, under **{{ ui-key.yacloud.ymq.queue.overview.section_base }}**, copy the queue URL as you will need it later.


   {% endlist %}

1. Send a message to the created queue using the saved queue URL:

   {% list tabs group=instructions %}

   - AWS CLI {#cli}

     ```bash
     aws sqs send-message \
       --message-body "<message_text>" \
       --endpoint <endpoint> \
       --queue-url <queue_URL>
     ```

     Where:

     * `--message-body`: Text of the message you want to send to the queue, e.g., `Hello World`.
     * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.
     * `--queue-url`: URL of the queue the message will be sent to.

     Result:

     ```json
     {
         "MD5OfMessageBody": "67e63db14341b5a696596634********",
         "MessageId": "765ff4d2-fa4bc83-6cfcc***-*****"
     }
     ```

   {% endlist %}

1. Accept the message from the queue:

   {% list tabs group=instructions %}

   - AWS CLI {#cli}

     ```bash
     aws sqs receive-message \
       --endpoint <endpoint> \
       --queue-url <queue_URL>
     ```

     Where:

     * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.
     * `--queue-url`: URL of the queue to receive the message from.

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

     Save the `ReceiptHandle` parameter value. You will need it at the next steps.

   {% endlist %}

1. Delete the message from the queue.

   After messages are processed, they should be deleted from the queue for applications not to process them again.

   To delete a message received from the queue, use the `ReceiptHandle` parameter value you saved earlier:

   {% list tabs group=instructions %}

   - AWS CLI {#cli}

     ```bash
     aws sqs delete-message \
       --endpoint <endpoint> \
       --queue-url <queue_URL>
       --receipt-handle <receipt_ID>
     ```
     Where:

     * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.
     * `--queue-url`: URL of the queue to delete the message from.
     * `--receipt-handle`: Previously saved message receipt ID (`ReceiptHandle`).

   {% endlist %}

1. Delete the queue:

   {% list tabs group=instructions %}

   - AWS CLI {#cli}
  
     ```bash
     aws sqs delete-queue \
       --endpoint <endpoint> \
       --queue-url <queue_URL>
     ```

     ```bash
     aws sqs delete-queue \
       --endpoint <endpoint> \
       --queue-url <queue_URL>
     ```

     Where:

     * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.
     * `--queue-url`: URL of the queue you need to delete.

   - Management console

     1. In the [management console]({{ link-console-main }}), select the folder the queue belongs to.
     1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
     1. Click ![image](../_assets/console-icons/ellipsis.svg) next to the appropriate queue and select **{{ ui-key.yacloud.common.delete }}**.
     1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

   {% endlist %}
