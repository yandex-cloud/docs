# Creating a trigger for {{ cloud-logging-name }} that invokes a {{ sf-name }} function

Create a [trigger for {{ cloud-logging-name }}](../../concepts/trigger/cloud-logging-trigger.md) that calls a {{ sf-name }} [function](../../concepts/function.md) when entries are added to a [log group](../../../logging/concepts/log-group.md).

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

* A log group that activates the trigger when entries are added there. If you do not have a log group, [create one](../../../logging/operations/create-group.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_logging }}`.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_logging }}**, specify:

        {% include [logging-settings](../../../_includes/functions/logging-settings.md) %}

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

        {% include [batch-settings](../../../_includes/functions/batch-settings.md) %}

        {% include [batch-messages](../../../_includes/functions/batch-messages.md) %}

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

        {% include [function-settings](../../../_includes/functions/function-settings.md) %}

    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

        {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead-letter queue and the service account with write permissions for this queue.

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
      --stream-names <logging_stream> \
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
    * `--log-group-name`: Name of the log group that will invoke a function when entries are added to it.

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

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

     ```
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<trigger_name>"
       description = "<trigger_description>"
       function {
          id                 = "<function_ID>"
          service_account_id = "<service_account_ID>"
          retry_attempts     = "<number_of_retry_attempts>"
          retry_interval     = "<interval_between_retry_attempts>"
       }
       logging {
          group_id       = "<log_group_ID>"
          resource_types = [ "<resource_type>" ]
          resource_ids   = [ "<resource_ID>" ]
          stream_names   = [ "<logging_stream>" ]
          levels         = [ "<logging_level>", "<logging_level>" ]
          batch_cutoff   = "<maximum_timeout>"
          batch_size     = "<message_group_size>"
       }
       dlq {
         queue_id           = "<dead-letter_queue_ID>"
         service_account_id = "<service_account_ID>"
       }
     }
     ```

     Where:

     {% include [tf-function-params](../../../_includes/functions/tf-function-params.md) %}

     * `logging`: Trigger parameters:

        * `group_id`: ID of the log group that will invoke a function when entries are added to it.
        * `resource_types`: Types of resources, e.g., of the `resource_types = [ "serverless.function" ]` {{ sf-name }} function. You can specify multiple types.
        * `resource_ids`: IDs of your resources or {{ yandex-cloud }} resources, e.g., of the `resource_ids = [ "<function_ID>" ]` functions. You can specify multiple IDs.
        * `stream_names`: Log streams. This is an optional parameter.
        * `levels`: Logging levels. For example, `levels = [ "INFO", "ERROR"]`.

          A trigger fires when the specified log group receives entries that comply with all of the following parameters: `resource-ids`, `resource-types`, `stream-names`, and `levels`. If a parameter is not specified, the trigger fires for any value of the parameter.

        * `batch_cutoff`: Maximum wait time. Acceptable values are from 0 to 60 seconds. The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function. The number of messages cannot exceed the specified `batch-size`.
        * `batch_size`: Message batch size. Acceptable values are from 1 to 10.

     {% include [tf-dlq-params](../../../_includes/serverless-containers/tf-dlq-params.md) %}

     For more information about the `yandex_function_trigger` resource parameters, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

  1. Create resources:

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

## See also {#see-also}

* [{#T}](../../../serverless-containers/operations/cloud-logging-trigger-create.md)
* [{#T}](../../../api-gateway/operations/trigger/cloud-logging-trigger-create.md)
