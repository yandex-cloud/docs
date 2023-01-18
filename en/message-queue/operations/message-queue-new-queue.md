# Creating a new message queue

To create a new message queue:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your queue in.
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
   1. To redirect undelivered messages to the [dead letter queue (DLQ)](../concepts/dlq.md):
      * Enable **Redirect undelivered messages**.
      * Specify the **Dead letter queue**.
      * Set the **Maximum number of read attempts**.
   1. Click **Create**.

- AWS CLI

   Run the following command in the terminal:

   ```bash
   aws sqs create-queue \
     --queue-name <queue_name> \
     --endpoint <endpoint>/
   ```

   Where:

   * `sample-queue`: Queue name.
   * `endpoint`: Endpoint, for example: `https://message-queue.{{ api-host }}/`.

   Result:

   ```json
   {
       "QueueUrl": "https://message-queue.{{ api-host }}/aoeaql9r10cd9cfue7v6/000000000000002n034r/sample-queue"
   }
   ```

- {{ TF }}

   {% include [ymq-terraform](../_includes_service/mq-terraform.md) %}

{% endlist %}
