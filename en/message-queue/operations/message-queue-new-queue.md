---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Creating a new message queue

To create a new message queue:

{% list tabs %}

- Management console

  1. Open the **Message Queue** section.

  1. Click **Create queue**.

  1. Enter a name for the queue.

     {% include [name](../../_includes/message-queue/ymq-name.md) %}

  1. Select the queue type: **Standard** or **FIFO**.

  1. Specify the standard visibility timeout to be applied to enqueued messages after they are read by a consumer.

  1. Specify the message retention period.

  1. Specify the maximum message size.

  1. Specify the delivery delay: the amount of time during which a new message cannot be picked from a queue.

  1. Specify the message receipt timeout.

  1. Click **Create queue**.

- AWS CLI

  Run the following command in the terminal:

  ```
  $ aws sqs create-queue --queue-name sample-queue \
              --endpoint https://message-queue.api.cloud.yandex.net/
  {
      "QueueUrl": "https://message-queue.api.cloud.yandex.net/aoeaql9r10cd9cfue7v6/000000000000002n034r/sample-queue"
  }
  ```

- Terraform

  {% include [ymq-terraform](../_includes_service/mq-terraform.md) %}

{% endlist %}

