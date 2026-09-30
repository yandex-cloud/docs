# Creating an email trigger that invokes a container from {{ serverless-containers-name }}

Create an [email trigger](../concepts/trigger/mail-trigger.md) that invokes a [container](../concepts/container.md) from {{ serverless-containers-name }} when an email arrives. {{ sf-name }} will automatically generate an email address when creating the trigger.

## Getting started {#before-you-begin}

To create a trigger, you will need:

* Container the trigger will invoke. If you do not have a container:

    * [Create a container](../../serverless-containers/operations/create.md).
    * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* Optionally, a [dead-letter queue](../../serverless-containers/concepts/dlq.md) for unprocessed messages from the container. If you do not have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with the following permissions:
    
    * To invoke a container.
    * Optionally, to write to a dead-letter queue.
    * Optionally, to upload objects to buckets.
    
    You can use the same service account or different ones. If you do not have a service account, [create one](../../iam/operations/sa/create.md).

* Optionally, [bucket](../../storage/concepts/bucket.md) to save email attachments to. If you do not have a bucket, [create one](../../storage/operations/buckets/create.md) with restricted access.

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

    1. [Navigate]({{ link-console-main }}/link/serverless-containers) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

    1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Optionally, enter a trigger name and description.

        * {% include [triggers-labels-step](../../_includes/functions/triggers-labels-step.md) %}

        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_mail }}`.

    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_mail-attachments }}**:

        {% include [mail-trigger-attachements](../../_includes/functions/mail-trigger-attachements.md) %}

    1. {% include [batch-settings](../../_includes/functions/batch-settings.md) %}

    1. Under **Targets**:

        1. In the **Target type** field, select `Container`.

        1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

        1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

            {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

        1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select a dead-letter queue and a service account with write permissions for that queue.

        1. {% include [trigger-console-filter](../../_includes/functions/trigger-console-filter.md) %}

        1. {% include [trigger-console-template](../../_includes/functions/trigger-console-template.md) %}

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To create a trigger that invokes a container, run this command:

    ```bash
    yc serverless trigger create mail \
      --name <trigger_name> \
      --batch-size <message_batch_size> \
      --batch-cutoff <maximum_timeout> \
      --attachements-bucket <bucket_name> \
      --attachements-service-account-id <service_account_ID> \
      --invoke-container-id <container_ID> \
      --invoke-container-service-account-id <service_account_ID> \
      --retry-attempts <number_of_retry_attempts> \
      --retry-interval <interval_between_retry_attempts> \
      --dlq-queue-id <dead-letter_queue_ID> \
      --dlq-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.

    {% include [batch-settings-messages](../../_includes/serverless-containers/batch-settings-messages.md) %}

    {% include [attachments-params](../../_includes/functions/attachments-params.md) %}

    {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

    Result:

    ```text
    id: a1sfe084v4h2********
    folder_id: b1g88tflruh2********
    created_at: "2022-12-04T08:45:31.131391Z"
    name: mail-trigger
    rule:
      mail:
        email: a1s8h8avglh2********-cho1****@serverless.yandexcloud.net
        batch_settings:
          size: "3"
          cutoff: 20s
        attachments_bucket:
          bucket_id: bucket-for-attachments
          service_account_id: ajejeis235ma********
        invoke_container:
          container_id: d4eofc7n0mh2********
          service_account_id: aje3932acdh2********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmkh2********:dlq
            service-account-id: aje3932acdh2********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

    {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

    {% include [terraform-install](../../_includes/terraform-install.md) %}
  
    To create an email trigger that invokes a container:
  
    1. Describe the trigger in the configuration file:

       ```hcl
       resource "yandex_serverless_triggers" "my_trigger" {
         name = "<trigger_name>"
         source {
           mail {
             attachments_bucket {
               bucket_id          = "<bucket_name>"
               service_account_id = "<service_account_ID>"
             }
             batch_settings {
               max_count = "<max_number_of_messages>"
               max_bytes = "<max_group_size_in_bytes>"
               cutoff    = "<maximum_wait_time>"
             }
           }
         }
         action {
           invoke_container {
             container_id       = "<container_ID>"
             path               = "<HTTP_path>"
             service_account_id = "<service_account_ID>"
           }
           retry_policy {
             retry_attempts = "<number_of_retries>"
             interval       = "<interval_between_retries>"
           }
           dead_letter {
             dead_letter_queue {
               queue_arn          = "<Dead_Letter_Queue_ARN>"
               service_account_id = "<service_account_ID>"
             }
           }
         }
       }
       ```

       Where:

       {% include [tf-triggers-common-params](../../_includes/tf-triggers-common-params.md) %}

       * `source`: Event source settings:

         * `mail`: Mail trigger settings:

           * `attachments_bucket`: Settings of the bucket to save email attachments to. This is an optional section:

               * `bucket_id`: Bucket name.
               * `service_account_id`: ID of the service account with permissions to upload objects to the {{ objstorage-name }} bucket.

           {% include [tf-triggers-batch-settings](../../_includes/tf-triggers-batch-settings.md) %}

       {% include [tf-triggers-action-container](../../_includes/serverless-containers/tf-triggers-action-container.md) %}

       The email address to send the mail to will be assigned to the trigger when it is created; you can view it in the trigger properties.

       For more on the properties of the `yandex_serverless_triggers` resource, see [this provider guide]({{ tf-provider-resources-link }}/serverless_triggers).

       {% cut "Configuration for the yandex_function_trigger resource" %}

       ```hcl
       resource "yandex_function_trigger" "my_trigger" {
         name = "<trigger_name>"
         container {
           id                 = "<container_ID>"
           service_account_id = "<service_account_ID>"
           retry_attempts     = <number_of_retry_attempts>
           retry_interval     = <time_between_retry_attempts>
         }
         mail {
           attachments_bucket_id = "<bucket_name>"
           service_account_id    = "<service_account_ID>"
           batch_cutoff          = <maximum_wait_time>
           batch_size            = <message_batch_size>
         }
         dlq {
           queue_id           = "<dead-letter_queue_ID>"
           service_account_id = "<service_account_ID>"
         }
       }
       ```

       Where:

       * `name`: Trigger name. Follow these naming requirements:

          {% include [name-format](../../_includes/name-format.md) %}
    
       * `container`: Container settings:
         
          {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

          {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}

       * `mail`: Trigger settings:

           * `attachments_bucket_id`: Name of the bucket to save email attachments to. This is an optional setting.
           * `service_account_id`: ID of the service account with permissions to upload objects to the {{ objstorage-name }} bucket. This is an optional setting.

           {% include [tf-batch-msg-params.md](../../_includes/serverless-containers/tf-batch-msg-params.md) %}

       {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

       For more on the properties of the `yandex_function_trigger` resource, see [this provider guide]({{ tf-provider-resources-link }}/function_trigger).

       {% endcut %}

    1. Create the resources:

        {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

        {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

        ```bash
        yc serverless trigger list
        ```

- API {#api}

  To create an email trigger, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

{{ serverless-containers-name }} will automatically generate an email address for which the trigger will fire when messages are sent to it. To view it, [get trigger details](trigger-list.md#trigger-get).

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

#### Useful links {#see-also}

* [{#T}](../../functions/operations/trigger/mail-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/mail-trigger-create.md)
