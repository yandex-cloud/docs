# Creating a timer that invokes a {{ sf-name }} function

Create a [timer](../../concepts/trigger/timer.md), i.e., a trigger that calls a [{{ sf-name }} function](../../concepts/function.md) based on a schedule.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder you want to create a trigger in.

    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

        * Enter a name and description for the trigger.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}**.
        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_timer }}**:

        * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** field, specify the function invocation schedule as a [cron expression](../../concepts/trigger/timer.md#cron-expression).
        * Optionally, in the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-payload }}** field, enter the message that will be sent to the function if the timer fires in the `payload` field. The data type is a string up to 4,096 characters long.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select a function and specify:

    	{% include [function-settings](../../../_includes/functions/function-settings.md) %}

    1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

    	{% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

    1. Optionally, under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the dead-letter queue and the service account with write permissions for this queue.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a trigger that invokes a function, run this command:

    ```bash
    yc serverless trigger create timer \
      --name <timer_name> \
      --cron-expression '<cron_expression>' \
      --payload <message> \
      --invoke-function-id <function_ID> \
      --invoke-function-service-account-id <service_account_ID> \
      --retry-attempts <number_of_retry_invocation_attempts> \
      --retry-interval <interval_between_retry_attempts> \
      --dlq-queue-id <dead_letter_queue_ID> \
      --dlq-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Timer name.
    * `--cron-expression`: Function invocation schedule specified as a [cron expression](../../concepts/trigger/timer.md#cron-expression).
    * `--payload`: Message that will be sent to the function if the timer fires. The string length must not exceed 4,096 characters.
    
    {% include [trigger-cli-param](../../../_includes/functions/trigger-cli-param.md) %}

    Result:

    ```text
    id: a1sfe084v4**********
    folder_id: b1g88tflru**********
    created_at: "2019-12-04T08:45:31.131391Z"
    name: timer
    rule:
      timer:
        cron_expression: 5 12 * * ? *
        payload: <message>
        invoke_function_with_retry:
          function_id: d4eofc7n0m**********
          function_tag: $latest
          service_account_id: aje3932acd**********
          retry_settings:
            retry_attempts: "1"
            interval: 10s
          dead_letter_queue:
            queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
            service-account-id: aje3932acd**********
    status: ACTIVE
    ```

- {{ TF }} {#tf}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  To create a timer:

  1. In the {{ TF }} configuration file, describe the parameters of the resources you want to create:

     ```hcl
     resource "yandex_function_trigger" "my_trigger" {
       name        = "<trigger_name>"
       description = "<trigger_description>"
       function {
         id                 = "<function_ID>"
         service_account_id = "<service_account_ID>"
         retry_attempts     = "<number_of_retry_invocation_attempts>"
         retry_interval     = "<interval_between_retry_attempts>"
       }
       timer {
         cron_expression = "<cron_expression>"
         payload         = "<message>"
       }
       dlq {
         queue_id           = "<dead_letter_queue_ID>"
         service_account_id = "<service_account_ID>"
       }
     }
     ```

     Where:

     {% include [tf-function-params](../../../_includes/functions/tf-function-params.md) %}

     * `timer`: Trigger parameters:

       * `cron_expression`: Function invocation schedule specified as a [cron expression](../../concepts/trigger/timer.md#cron-expression).
       * `payload`: Message that will be sent to the function if the timer fires. The string length must not exceed 4,096 characters.

     {% include [tf-dlq-params](../../../_includes/serverless-containers/tf-dlq-params.md) %}

     For more information about the `yandex_function_trigger` resource properties, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      {% include [terraform-check-result](../../../_tutorials/_tutorials_includes/terraform-check-result.md) %}

      ```bash
      yc serverless trigger list
      ```

- API {#api}

  To create a timer, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/Trigger/create.md) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [{#T}](../../../serverless-containers/operations/timer-create.md)
* [{#T}](../../../api-gateway/operations/trigger/timer-create.md)
