  {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a message queue:

  1. In the configuration file, describe the parameters of the queue to create:

     Sample configuration file for a standard queue:

      
      ```
      provider "yandex" {
         token     = "<OAuth or service account static key>"
         folder_id = "<folder ID>"
         zone      = "{{ region-id }}-a"
      }

      resource "yandex_message_queue" "example_queue" {
        name                        = "mq-terraform-example"
        visibility_timeout_seconds  = 600
        receive_wait_time_seconds   = 20
        message_retention_seconds   = 1209600
        access_key                  = "<ID of the static access key>"
        secret_key                  = "<secret part of the static access key>"
      }
      ```



     Sample configuration file for a FIFO queue:

      
      ```
      provider "yandex" {
        token     = "<OAuth or service account static key>"
        folder_id = "<folder ID>"
        zone      = "{{ region-id }}-a"
      }

      resource "yandex_message_queue" "example-fifo-queue" {
        name                        = "mq-terraform-example.fifo"
        visibility_timeout_seconds  = 600
        receive_wait_time_seconds   = 20
        message_retention_seconds   = 1209600
        fifo_queue                  = true
        access_key                  = "<ID of the static access key>"
        secret_key                  = "<secret part of the static access key>"
      }
      ```


     Sample configuration file for a queue with a redrive policy for moving undelivered messages to a DLQ named `mq_terraform_deadletter_example`:

      
      ```
      provider "yandex" {
         token     = "<OAuth or service account static key>"
         folder_id = "<folder ID>"
         zone      = "{{ region-id }}-a"
      }
 
      resource "yandex_message_queue" "example_fifo_queue" {
        name                        = "mq-terraform-example"
        visibility_timeout_seconds  = 600
        receive_wait_time_seconds   = 20
        message_retention_seconds   = 1209600
        redrive_policy              = jsonencode({
          deadLetterTargetArn = yandex_message_queue.example_deadletter_queue.arn
          maxReceiveCount     = 3
        })
        access_key                  = "<ID of the static access key>"
        secret_key                  = "<secret part of the static access key>"
      }
 
      resource "yandex_message_queue" "example_deadletter_queue" {
        name                        = "mq_terraform_deadletter_example"
        access_key                  = "<ID of the static access key>"
        secret_key                  = "<secret part of the static access key>"
      }
      ```



     Where:

     * `name`: Queue name.
     * `visibility_timeout_seconds`: [Visibility timeout](../concepts/visibility-timeout.md).
     * `receive_wait_time_seconds`: Waiting time for messages to enter the queue if [Long Polling](../concepts/long-polling.md) is used. The valid values are from 0 to 20 seconds. The default value is 0 seconds.
     * `message_retention_seconds`: Time, in seconds, to retain a message in the queue.
     * `redrive_policy`: Message redrive policy in a [Dead Letter Queue](../concepts/dlq.md).

        * `deadLetterTargetArn`: ARN of the DLQ that messages are moved to.
        * `maxReceiveCount`: Number of attempts to read a message from the queue before redriving it to the DLQ.

     * `fifo_queue`: Indicates that a [FIFO queue](../concepts/queue.md#fifo-queues) is created.
     * `content_based_deduplication`: Enables [content-based deduplication](../concepts/deduplication.md#content-based-deduplication) in FIFO queues.
     * `access_key`: ID of the service account static access key for the queue. If it is not specified in the queue configuration, the ID from the provider configuration is used.
     * `secret_key`: Secret part of the static access key. If no secret key is set in the queue configuration, the key from the provider configuration is used.

     For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

  1. Make sure the configuration files are valid.

     1. In the command line, go to the directory where you created the configuration file.
     1. Run a check using this command:

        ```
        terraform plan
        ```

     If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy cloud resources.

     1. If the configuration does not contain any errors, run this command:

        ```
        terraform apply
        ```

     1. Confirm that you want to create the resources.

     All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}). To delete the created resources, run the `terraform destroy` command.
