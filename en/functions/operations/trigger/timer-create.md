# Creating a timer that invokes a {{ sf-name }} function

Create a [timer](../../concepts/trigger/timer.md), i.e., a trigger that calls a [{{ sf-name }} function](../../concepts/function.md) based on a schedule.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Timer**.
      * In the **Launched resource** field, select **Function**.

   1. Under **Timer settings**:

      * In the **Cron expression** field, specify the function invocation schedule in the [cron expression](../../concepts/trigger/timer.md#cron-expression) format.
      * (Optional) In the **Data** field, enter the message to be delivered to the function if the timer triggers in the `payload` field. Data type: string limited to 4,096 characters.

   1. Under **Function settings**, select a function and specify:

      {% include [function-settings](../../../_includes/functions/function-settings.md) %}

   1. (Optional) Under **Repeat request settings**:

      {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

   1. (Optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

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
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Timer name.
   * `--cron-expression`: Function invocation schedule specified as a [cron expression](../../concepts/trigger/timer.md#cron-expression).
   * `--payload`: Message to be delivered to the function if the timer triggers. String length should not exceed 4,096 characters.

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

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger that launches a function:

   1. In the configuration file, describe the trigger parameters:

      * `name`: Timer name in the following format:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `timer`: Trigger settings:
         * `cron_expression`: Function invocation schedule in the [cron expression](../../concepts/trigger/timer.md#cron-expression) format.
         * `payload`: Message to be delivered to the function if the timer triggers. String length should not exceed 4,096 characters.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.

      Example of the configuration file structure:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<timer_name>"
        description = "<trigger_description>"
        timer {
          cron_expression = "* * * * ? *"
          payload         = "<message>"
        }
        function {
          id = "<function_ID>"
        }
      }
      ```

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/function_trigger).

   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can verify that the resources are there and their configuration is correct using the [management console]({{ link-console-main }}) or the following [CLI](../../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger_ID>
         ```

- API

   To create a timer, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [Timer that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/timer-create.md).
