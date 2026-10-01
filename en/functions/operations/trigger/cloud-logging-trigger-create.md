# Creating a trigger for {{ cloud-logging-name }} that invokes {{ sf-name }}

Create a [trigger for {{ cloud-logging-name }}](../../concepts/trigger/cloud-logging-trigger.md) that invokes [{{ sf-name }}](../../concepts/function.md) whenever entries are added to the [log group](../../../logging/concepts/log-group.md).

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

* Log group whose new entries will set off the trigger. If you do not have a log group, [create one](../../../logging/operations/create-group.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

    1. [Navigate]({{ link-console-main }}/link/functions) to **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.

        * {% include [triggers-labels-step](../../../_includes/functions/triggers-labels-step.md) %}

        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_logging }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_logging }}**, specify the following:

        {% include [logging-settings](../../../_includes/functions/logging-settings.md) %}

    1. {% include [batch-settings](../../../_includes/functions/batch-settings.md) %}

    1. Under **Targets**:

        1. In the **Target type** field, select `Function`.

        1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

            {% include [function-settings](../../../_includes/functions/function-settings.md) %}

        1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

            {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

        1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select a dead-letter queue and a service account with write permissions for that queue.

        1. {% include [trigger-console-filter](../../../_includes/functions/trigger-console-filter.md) %}

        1. {% include [trigger-console-template](../../../_includes/functions/trigger-console-template.md) %}

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a trigger that invokes a function, run this command:

    ```bash
    yc serverless trigger create logging \
      --name <trigger_name> \
      --log-group-name <log_group_name> \
      --batch-size <message_group_size> \
      --batch-cutoff <maximum_timeout> \
      --resource-ids <resource_ID> \
      --resource-types <resource_type> \
      --stream-names <log_stream> \
      --log-levels <logging_level> \
      --invoke-function-id <function_ID> \
      --invoke-function-service-account-id <service_account_ID> \
      --retry-attempts <number_of_retry_attempts> \
      --retry-interval <interval_between_retry_attempts> \
      --dlq-queue-id <dead-letter_queue_ID> \
      --dlq-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.
    * `--log-group-name`: Name of the log group whose new log entries will invoke the function.

    {% include [batch-settings-messages](../../../_includes/functions/batch-settings-messages.md) %}

    {% include [logging-cli-param](../../../_includes/functions/logging-cli-param.md) %}

    {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

    Result:

    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2019-12-04T08:45:31.131391Z"
    name: logging-trigger
    rule:
      logging:
        log-group-name: default
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
        invoke_function:
          function_id: d4eofc7n0m**********
          function_tag: $latest
          service_account_id: aje3932acd**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
            service-account-id: aje3932a**********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a trigger for {{ cloud-logging-name }}:

  1. In the {{ TF }} configuration file, describe the resources you want to create:

     ```hcl
     resource "yandex_serverless_triggers" "my_trigger" {
       name        = "<trigger_name>"
       description = "<trigger_description>"
       source {
         logging {
           log_group_id  = "<log_group_ID>"
           resource_type = [ "<resource_type>" ]
           resource_id   = [ "<resource_ID>" ]
           stream_name   = [ "<log_stream>" ]
           levels        = [ "<logging_level>", "<logging_level>" ]
           batch_settings {
             max_count = "<max_number_of_messages>"
             max_bytes = "<max_group_size_in_bytes>"
             cutoff    = "<maximum_wait_time>"
           }
         }
       }
       action {
         invoke_function {
           function_id        = "<function_ID>"
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

     {% include [tf-triggers-common-params](../../../_includes/tf-triggers-common-params.md) %}

     * `source`: Event source settings:

       * `logging`: Log group settings:

         * `log_group_id`: ID of the log group whose new log entries will invoke the function.
         * `resource_type`: Types of resources, e.g., `resource_type = [ "serverless.function" ]` in {{ sf-name }}. You can specify multiple types.
         * `resource_id`: IDs of your resources or {{ yandex-cloud }} resources, e.g., `resource_id = [ "<function_ID>" ]`. You can specify multiple IDs.
         * `stream_name`: Log streams. This is an optional parameter.
         * `levels`: Logging levels, e.g., `levels = [ "INFO", "ERROR" ]`.

             A trigger fires when the specified log group receives entries that comply with all of the following parameters: `resource_id`, `resource_type`, `stream_name`, and `levels`. If the setting is not specified, the trigger fires for any value.

         {% include [tf-triggers-batch-settings](../../../_includes/tf-triggers-batch-settings.md) %}

     {% include [tf-triggers-action-function](../../../_includes/functions/tf-triggers-action-function.md) %}

     For more on the properties of the `yandex_serverless_triggers` resource, see [this provider guide]({{ tf-provider-resources-link }}/serverless_triggers).

     {% cut "Configuration for the yandex_function_trigger resource" %}

     ```
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<trigger_name>"
       description = "<trigger_description>"
       function {
          id                 = "<function_ID>"
          service_account_id = "<service_account_ID>"
          retry_attempts     = "<number_of_retry_attempts>"
          retry_interval     = "<time_between_retry_attempts>"
       }
       logging {
          group_id       = "<log_group_ID>"
          resource_types = [ "<resource_type>" ]
          resource_ids   = [ "<resource_ID>" ]
          stream_names   = [ "<log_stream>" ]
          levels         = [ "<logging_level>", "<logging_level>" ]
          batch_cutoff   = "<maximum_wait_time>"
          batch_size     = "<message_batch_size>"
       }
       dlq {
         queue_id           = "<dead-letter_queue_ID>"
         service_account_id = "<service_account_ID>"
       }
     }
     ```

     Where:

     {% include [tf-function-params](../../../_includes/functions/tf-function-params.md) %}

     * `logging`: Trigger settings:

        * `group_id`: ID of the log group whose new log entries will invoke the function.
        * `resource_types`: Types of resources, e.g., {{ sf-name }} such as `resource_types = [ "serverless.function" ]`. You can specify multiple types. 
        * `resource_ids`: IDs of your resources or {{ yandex-cloud }} resources, e.g., `resource_ids = [ "<function_ID>" ]`. You can specify multiple IDs.
        * `stream_names`: Log streams. This is an optional setting.
        * `levels`: Logging levels, e.g., `levels = [ "INFO", "ERROR"]`.

          A trigger fires when the specified log group receives entries that comply with all of the following settings: `resource-ids`, `resource-types`, `stream-names`, and `levels`. If the setting is not specified, the trigger fires for any value.

        * `batch_cutoff`: Maximum wait time. The valid values range from 0 to 60 seconds. The trigger groups messages within the specified wait time and sends them to the function. The number of messages cannot exceed the specified `batch-size`.
        * `batch_size`: Message batch size. The valid values range from 1 to 10.

     {% include [tf-dlq-params](../../../_includes/serverless-containers/tf-dlq-params.md) %}

     For more on the properties of the `yandex_function_trigger` resource, see [this provider guide]({{ tf-provider-resources-link }}/function_trigger).

     {% endcut %}

  1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     {% include [terraform-check-result](../../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

     ```bash
     yc serverless trigger list
     ```

- API {#api}

  To create a trigger for {{ cloud-logging-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

#### Useful links {#see-also}

* [{#T}](../../../serverless-containers/operations/cloud-logging-trigger-create.md)
* [{#T}](../../../api-gateway/operations/trigger/cloud-logging-trigger-create.md)
