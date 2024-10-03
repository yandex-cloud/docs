# Creating a trigger for {{ cloud-logging-name }} that invokes a {{ serverless-containers-name }} container

Create a [trigger for {{ cloud-logging-name }}](../concepts/trigger/cloud-logging-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when entries are added to a [log group](../../logging/concepts/log-group.md).

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* A log group that activates the trigger when entries are added there. If you do not have a log group, [create one](../../logging/operations/create-group.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

   1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-containers }}**.

   1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_logging }}`.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_container }}`.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_logging }}**, specify:

      {% include [logging-settings](../../_includes/functions/logging-settings.md) %}

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      {% include [batch-settings](../../_includes/functions/batch-settings.md) %}

      {% include [batch-messages](../../_includes/serverless-containers/batch-messages.md) %}

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead-letter queue and the service account with write permissions for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

   ```bash
   yc serverless trigger create logging \
     --name <trigger_name> \
     --log-group-name <log_group_name> \
     --batch-size <message_batch_size> \
     --batch-cutoff <maximum_wait_time> \
     --resource-ids <resource_ID> \
     --resource-types <resource_type> \
     --stream-names <logging_stream> \
     --log-levels <logging_level> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts <number_of_retry_invocation_attempts> \
     --retry-interval <interval_between_retry_attempts> \
     --dlq-queue-id <dead_letter_queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--log-group-name`: Name of the log group that invokes a container when records are added.

   {% include [batch-settings-messages](../../_includes/serverless-containers/batch-settings-messages.md) %}

   {% include [logging-cli-param](../../_includes/functions/logging-cli-param.md) %}

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1s5msktijh2********
   folder_id: b1gmit33hgh2********
   created_at: "2022-10-24T15:19:15.353909857Z"
   name: logging-trigger
   rule:
     logging:
       log_group_id: e23bidnftlh2********
       resource_type:
         - serverless.functions
       resource_id:
         - d4e1gpsgam78********
       stream_name:
         - test
       levels:
         - INFO
       batch_settings:
         size: "1"
         cutoff: 1s
       invoke_container:
         container_id: bba5jb38o8h2********
         service_account_id: aje03adgd2h2********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:b1gmit33ngh2********:dlq
           service-account-id: aje3lebfemh2********
   status: ACTIVE
   ```

- {{ TF }} {#tf}

   {% include [terraform-definition](../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

   To create a trigger for {{ cloud-logging-name }}:

   1. In the configuration file, describe the trigger parameters:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name = "<trigger_name>"
        container {
          id                 = "<container_ID>"
          service_account_id = "<service_account_ID>"
          retry_attempts     = "<number_of_retry_invocation_attempts>"
          retry_interval     = "<interval_between_retry_attempts>"
        }
        logging {
          group_id       = "<log_group_ID>"
          resource_types = [ "<resource_type>" ]
          resource_ids   = [ "<resource_ID>" ]
          stream_names   = [ "<logging_stream>" ]
          levels         = [ "logging_level", "logging_level" ]
          batch_cutoff   = "<maximum_wait_time>"
          batch_size     = "<message_batch_size>"
        }
        dlq {
         queue_id           = "<dead_letter_queue_ID>"
         service_account_id = "<service_account_ID>"
       }
      }
      ```

      Where:

      * `name`: Trigger name. The name format is as follows:

         {% include [name-format](../../_includes/name-format.md) %}

      * `container-name`: Container parameters:

         {% include [tf-container-params](../../_includes/serverless-containers/tf-container-params.md) %}

         {% include [tf-retry-params](../../_includes/serverless-containers/tf-retry-params.md) %}

      * `logging`: Trigger parameters:

         * `group_id`: ID of the log group that invokes the container when entries are added there.
         * `resource_types`: Types of resources, e.g., {{ sf-name }} functions. This is an optional parameter.
         * `resource_ids`: IDs of your resources or {{ yandex-cloud }} resources, e.g., {{ sf-name }} functions. This is an optional parameter.
         * `stream_names`: Log streams. This is an optional parameter.
         * `levels`: Logging levels. This is an optional parameter.

            A trigger fires when records are added to the specified log group that satisfy all of the following parameters: `resource_ids`, `resource_types`, `stream_names`, and `levels`. If a parameter is not specified, the trigger fires for any value of the parameter.

         {% include [tf-batch-msg-params](../../_includes/serverless-containers/tf-batch-msg-params.md) %}

      {% include [tf-dlq-params](../../_includes/serverless-containers/tf-dlq-params.md) %}

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Create resources:

      {% include [terraform-validate-plan-apply](../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {% include [terraform-check-result](../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

      ```bash
      yc serverless trigger list
      ```

- API {#api}

   To create a trigger for {{ cloud-logging-name }}, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [{#T}](../../functions/operations/trigger/cloud-logging-trigger-create.md)
* [{#T}](../../api-gateway/operations/trigger/cloud-logging-trigger-create.md)
