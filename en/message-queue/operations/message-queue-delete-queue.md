# Deleting a message queue

To delete a message queue:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder the queue belongs to.
   1. Open the **Message Queue** section.
   1. Click ![image](../../_assets/horizontal-ellipsis.svg) in the row of the queue to delete.
   1. In the resulting menu, click **Delete**.
   1. In the window that opens, click **Delete**.

- AWS CLI

   Run the following command in the terminal:

   ```
   aws sqs delete-queue \
     --queue-url <message_queue_URL> \
     --endpoint <endpoint>/
   ```

   Where:
   * `queue-url`: Message queue URL, for example: `https://message-queue.{{ api-host }}/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue`.
   * `endpoint`: Endpoint, for example: `https://message-queue.{{ api-host }}/`.

- {{ TF }}

   If you created a message queue using {{ TF }}, you can delete it:
   1. In the command line, go to the directory with the {{ TF }} configuration file.
   1. Delete resources using the command:

      ```bash
      terraform destroy
      ```

      {% note alert %}

      {{ TF }} deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

   1. Type the word `yes`, then press **Enter**.

{% endlist %}
