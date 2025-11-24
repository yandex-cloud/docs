  {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  To create a message queue: 
    
  1. In the configuration file, describe the parameters of the queue to create:
            
     Sample configuration file for a standard queue:

     ```
     provider "yandex" {
         token     = "<OAuth_or_static_key_of_service_account>"
         folder_id = "<folder_ID>"
         zone      = "{{ region-id }}-a"
       }

     resource "yandex_message_queue" "example_queue" {
       name                        = "mq-terraform-example"
       visibility_timeout_seconds  = 600
       receive_wait_time_seconds   = 20
       message_retention_seconds   = 1209600
       access_key                  = "<static_access_key_ID>"
       secret_key                  = "<secret_part_of_static_access_key>"
     }
     ```

     Sample configuration file for a FIFO queue:

     ```
     provider "yandex" {
         token     = "<OAuth_or_static_key_of_service_account>"
         folder_id = "<folder_ID>"
         zone      = "{{ region-id }}-a"
       }

     resource "yandex_message_queue" "example-fifo-queue" {
       name                        = "mq-terraform-example.fifo"
       visibility_timeout_seconds  = 600
       receive_wait_time_seconds   = 20
       message_retention_seconds   = 1209600
       fifo_queue                  = true
       access_key                  = "<static_access_key_ID>"
       secret_key                  = "<secret_part_of_static_access_key>"
     }
     ```

     Example of a configuration file for a queue with a redirect policy for moving undelivered messages to a DLQ named `mq_terraform_deadletter_example`:

     ```
     provider "yandex" {
         token     = "<OAuth_or_static_key_of_service_account>"
         folder_id = "<folder_ID>"
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
       access_key                  = "<static_access_key_ID>"
       secret_key                  = "<secret_part_of_static_access_key>"
     }

     resource "yandex_message_queue" "example_deadletter_queue" {
       name                        = "mq_terraform_deadletter_example"
       access_key                  = "<static_access_key_ID>"
       secret_key                  = "<secret_part_of_static_access_key>"
     }
     ```

     Where:

     * `name`: Queue name.
     * `visibility_timeout_seconds`: [Visibility timeout](../concepts/visibility-timeout.md).
     * `receive_wait_time_seconds`: Waiting time for messages to enter the queue if [Long Polling](../concepts/long-polling.md) is used. The valid values are from 0 to 20 seconds. The default value is 0 seconds.
     * `message_retention_seconds`: Message retention time in the queue, in seconds.
     * `redrive_policy`: Redirect policy for moving messages to a [dead-letter queue](../concepts/dlq.md).
       * `deadLetterTargetArn`: ARN of the DLQ messages will be redirected to.
       * `maxReceiveCount`: Number of attempts to read a message from the queue before redirecting it to the DLQ.
     * `fifo_queue`: Indicates that a [FIFO queue](../concepts/queue.md#fifo-queues) is created.
     * `content_based_deduplication`: Enables [content-based deduplication](../concepts/deduplication.md#content-based-deduplication) in FIFO queues.
     * `access_key`: ID of the service account's static access key for the queue. If it is not specified in the queue configuration, the ID from the provider configuration is used.
     * `secret_key`: Secret part of the static access key. If no secret key is set in the queue configuration, the key from the provider configuration is used.

     For more information about the resources you can create with {{ TF }}, see [this provider article]({{ tf-provider-link }}).
     
  1. Make sure the configuration files are correct.
     
     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:
        ```
        terraform plan
        ```
     If the configuration description is correct, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out. 
        
  1. Deploy the cloud resources.

     1. If the configuration does not contain any errors, run this command:
        ```
        terraform apply
        ```
     1. Confirm creating the resources.
     
     This will create all the resources you need in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}). To delete the resources you created, run the `terraform destroy` command.