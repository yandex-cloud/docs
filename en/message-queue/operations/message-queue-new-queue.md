---
title: "How to create a message queue in {{ message-queue-full-name }}"
description: "Follow this guide to create a message queue."
---

# Creating a new message queue

Message queues in {{ message-queue-name }} enable [messaging](../concepts/message.md) between components of distributed applications. Messages can be sent to queues using the [API](../api-ref/index.md) or other supported [tools](../instruments/index.md).

To create a new message queue:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to create your queue in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
   1. Click **{{ ui-key.yacloud.ymq.queues.button_create }}**.
   1. Under **{{ ui-key.yacloud.ymq.queue.form.section_base }}**, fill in the following fields:
      * **{{ ui-key.yacloud.common.name }}**: Enter a name for the queue.

         {% include [name](../../_includes/message-queue/ymq-name.md) %}

      * **{{ ui-key.yacloud.ymq.queue.form.switch_fifo-queue }}**: Select the `{{ ui-key.yacloud.ymq.queue.form.type_switch_standard }}` or `{{ ui-key.yacloud.ymq.queue.form.type_switch_fifo }}` queue type.
      * **{{ ui-key.yacloud.ymq.queue.form.field_visibility-timeout }}**: Specify the standard visibility timeout to be applied to enqueued messages after they are read by a consumer.
      * **{{ ui-key.yacloud.ymq.queue.form.field_keeping-time }}**: Set the maximum period for retaining messages in the queue.
      * **{{ ui-key.yacloud.ymq.queue.form.field_max-size }}**: Specify the maximum message size.
      * **{{ ui-key.yacloud.ymq.queue.form.field_sending-delay }}**: Specify the amount of time during which a new message cannot be picked from the queue.
      * **{{ ui-key.yacloud.ymq.queue.form.field_receiving-delay }}**: Specify the message receipt timeout.
   1. To redirect undelivered messages to the [dead letter queue (DLQ)](../concepts/dlq.md), do the following under **{{ ui-key.yacloud.ymq.queue.form.section_message-settings }}**:

      * Enable **{{ ui-key.yacloud.ymq.queue.form.switch_redirect-messages }}**.
      * Specify **{{ ui-key.yacloud.ymq.queue.form.field_messages-queue }}**.
      * Set **{{ ui-key.yacloud.ymq.queue.form.field_max-read-tries }}**.

   1. Click **{{ ui-key.yacloud.common.create }}**.

- AWS CLI {#cli}

   1. [Install and configure](configuring-aws-cli.md) the AWS CLI.

   1. Run the following command in the terminal:

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
          "QueueUrl": "https://message-queue.{{ api-host }}/aoeaql9r10cd********/000000000000002n034r/sample-queue"
      }
      ```

- {{ TF }} {#tf}

   {% include [ymq-terraform](../_includes_service/mq-terraform.md) %}

{% endlist %}


When the limit on the maximum number of queues is reached, the `Cannot create queue: Too many queues` error occurs. To increase the limit, contact [support]({{ link-console-support }}).
