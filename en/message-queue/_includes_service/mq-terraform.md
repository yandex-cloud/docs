{% include [terraform-definition](../../solutions/_solutions_includes/terraform-definition.md) %}

  If you don't have Terraform yet, [install it and configure the {{ yandex-cloud }} provider](../../solutions/infrastructure-management/terraform-quickstart.md#install-terraform).

  To create a message queue:

  1. In the configuration file, describe the parameters of the queue to create:
     * `name`: Queue name.
     * `visibility_timeout_seconds`: [Visibility timeout](../concepts/visibility-timeout.md).
     * `receive_wait_time_seconds`: Waiting time for messages to enter the queue if [Long Polling](../concepts/long-polling.md) is used. Valid values: from 0 to 20 seconds. Default: 0 seconds.
     * `message_retention_seconds`: Length of time, in seconds, to retain a message in the queue.
     * `redrive_policy`: Message redrive policy in a [Dead Letter Queue](../concepts/dlq.md).
       * `deadLetterTargetArn`: ARN of the DLQ that messages are moved to.
       * `maxReceiveCount`: Number of attempts to read a message from the queue before redriving it to the DLQ.
     * `fifo_queue`: Indicates that a [FIFO queue](../concepts/queue.md#fifo-queues) is created.
     * `content_based_deduplication`: Enables [content-based deduplication](../concepts/deduplication.md#content-based-deduplication) in FIFO queues.
     * `access_key`: ID of the service account static access key for the queue. If it isn't specified in the queue configuration, the ID from the provider configuration is used.
     * `secret_key`: Secret part of the static access key. If no secret key is set in the queue configuration, the key from the provider configuration is used.

     Sample configuration file for a standard queue:

     ```
     provider "yandex" {
         token = "<OAuth or static key of service account>"
         folder_id = "<folder ID>"
         zone      = "ru-central1-a"
       }
     
     resource "yandex_message_queue" "example_queue" {
       name                        = "ymq-terraform-example"
       visibility_timeout_seconds  = 600
       receive_wait_time_seconds   = 20
       message_retention_seconds   = 1209600
       access_key                  = "<static access key ID>"
       secret_key                  = "<secret part of static access key>"
     }
     ```

     Sample configuration file for a FIFO queue:

     ```
     provider "yandex" {
         token = "<OAuth or static key of service account>"
         folder_id = "<folder ID>"
         zone      = "ru-central1-a"
       }
     
     resource "yandex_message_queue" "example-fifo-queue" {
       name                        = "ymq-terraform-example.fifo"
       visibility_timeout_seconds  = 600
       receive_wait_time_seconds   = 20
       message_retention_seconds   = 1209600
       fifo_queue                  = true
       access_key                  = "<static access key ID>"
       secret_key                  = "<secret part of static access key>"
     }
     ```

     Sample configuration file for a queue with a redrive policy for moving undelivered messages to a DLQ named `ymq_terraform_deadletter_example`:

     ```
     provider "yandex" {
         token = "<OAuth or static key of service account>"
         folder_id = "<folder ID>"
         zone      = "ru-central1-a"
       }
     
     resource "yandex_message_queue" "example_fifo_queue" {
       name                        = "ymq-terraform-example"
       visibility_timeout_seconds  = 600
       receive_wait_time_seconds   = 20
       message_retention_seconds   = 1209600
       redrive_policy              = jsonencode({
         deadLetterTargetArn = yandex_message_queue.example_deadletter_queue.arn
         maxReceiveCount     = 3
       })
       access_key                  = "<static access key ID>"
       secret_key                  = "<secret part of static access key>"
     }
     
     resource "yandex_message_queue" "example_deadletter_queue" {
       name                        = "ymq_terraform_deadletter_example"
       access_key                  = "<static access key ID>"
       secret_key                  = "<secret part of static access key>"
     }
     ```

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  2. Make sure that the configuration files are correct.
     1. In the command line, go to the directory where you created the configuration file.
     2. Run the check using the command:

        ```
        $ terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  3. Deploy the cloud resources.
     1. If the configuration doesn't contain any errors, run the command:

        ```
        $ terraform apply
        ```
     2. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in [management console]({{ link-console-main }}). To delete the created resources, run the `terraform destroy` command.

