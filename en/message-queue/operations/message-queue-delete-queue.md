# Deleting a message queue

To delete a message queue:

{% list tabs %}

- Management console
  1. Open the **Message Queue** section.
  1. Click ![image](../../_assets/vertical-ellipsis.svg) in the row of the queue to delete.
  1. In the menu that opens, click **Delete**.
  1. In the window that opens, click **Delete**.

- AWS CLI

  Run the following command in the terminal:

  ```
  $ aws sqs delete-queue \
              --queue-url https://message-queue.api.cloud.yandex.net/aoegtvhtp8ob9rqq8sto/000000000000002p01jp/sample-queue \
              --endpoint https://message-queue.api.cloud.yandex.net/      
  ```

- Terraform

  If you created a message queue using Terraform, you can delete it:

   1. In the command line, go to the directory with the Terraform configuration file.

   2. Delete resources using the command:

      ```
      $ terraform destroy
      ```

      {% note alert %}

      Terraform deletes all the resources that you created in the current configuration, such as clusters, networks, subnets, and VMs.

      {% endnote %}

    3. Confirm the deletion of resources.

{% endlist %}

