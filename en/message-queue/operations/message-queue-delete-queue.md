# Deleting a message queue

To delete a message queue:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the queue belongs to.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_message-queue }}**.
   1. In the row of the queue you need, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.common.delete }}**.
   1. In the window that opens, click **{{ ui-key.yacloud.common.delete }}**.

- AWS CLI

   1. Get the URL of the message queue to be deleted:

      ```bash
      aws sqs list-queues \
        --endpoint <endpoint>
      ```

      Where `--endpoint` is the endpoint in the `https://message-queue.{{ api-host }}/` value.

   1. Delete the message queue:

      ```
      aws sqs delete-queue \
        --queue-url <queue_URL> \
        --endpoint <endpoint>
      ```

      Where:
      * `--queue-url`: URL of the queue to be deleted.
      * `--endpoint`: Endpoint in the `https://message-queue.{{ api-host }}/` value.

- {{ TF }}

   If you created a message queue using {{ TF }}, you can delete it:
   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete the resources using this command:

      ```bash
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} will delete all the resources you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

   1. Type `yes` and press **Enter**.

{% endlist %}
