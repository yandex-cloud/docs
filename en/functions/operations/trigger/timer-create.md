# Creating a timer that invokes a {{ sf-name }} function

Create a [timer](../../concepts/trigger/timer.md) — a trigger that calls a [{{ sf-name }} function](../../concepts/function.md) on a schedule.

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Timer**.
      * In the **Launched resource** field, select **Function**.

   1. Under **Timer settings**, specify the function invocation schedule in a [cron expression](../../concepts/trigger/timer.md#cron-expression).

   1. Under **Function settings**, select a function and specify:

      {% include [function-settings](../../../_includes/functions/function-settings.md) %}

   1. (optional) Under **Repeat request settings**:

      {% include [repeat-request.md](../../../_includes/functions/repeat-request.md) %}

   1. (optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a function, run the command:

   ```bash
   yc serverless trigger create timer \
     --name <timer name> \
     --cron-expression '<cron expression>' \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead Letter Queue ID> \
     --dlq-service-account-id <service account ID>
   ```

   Where:

   * `--name`: Timer name.
   * `--cron-expression`: Function invocation schedule in [cron expression](../../concepts/trigger/timer.md#cron-expression).

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

- API

   You can create a timer using the [create](../../triggers/api-ref/Trigger/create.md).

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger that launches a function:

   1. In the configuration file, describe the trigger parameters:

      * `name`: Timer name. Name format:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `timer`: Trigger settings:
         * `cron_expression`: Function invocation schedule in [cron expression](../../concepts/trigger/timer.md#cron-expression) format.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.

      Example configuration file structure:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<timer name>"
        description = "<trigger description>"
        timer {
          cron_expression = "* * * * ? *"
        }
        function {
          id = "<function ID>"
        }
      }
      ```

      For more information about the resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/function_trigger).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm the resource creation: type `yes` in the terminal and press **Enter**.

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger ID>
         ```

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [Timer that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/timer-create.md).
