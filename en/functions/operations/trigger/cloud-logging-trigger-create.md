# Creating a trigger for {{ cloud-logging-name }} that invokes a {{ sf-name }} function

Create a [trigger for {{ cloud-logging-name }}](../../concepts/trigger/cloud-logging-trigger.md) that calls a {{ sf-name }} [function](../../concepts/function.md) when entries are added to a [log group](../../../logging/concepts/log-group.md).

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/functions/trigger-before-you-begin.md) %}

* The log group that activates the trigger when records are added to it. If you don't have a log group, [create one](../../../logging/operations/create-group.md).

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
      * In the **Type** field, select **{{ cloud-logging-name }}**.
      * In the **Launched resource** field, select **Function**.

   1. Under **{{ cloud-logging-name }} settings**, specify:

      * The log group.
      * (Optional) Resource types: {{ yandex-cloud }} or your services, such as, `serverless.function`.
      * (Optional) IDs of {{ yandex-cloud }} or your resources, such as {{ sf-name }} functions.
      * (Optional) Logging levels.

      A trigger activates when records that match all the optional settings are added to the specified log group. If an optional setting is undefined, the trigger activates for any value of the setting.

   1. (Optional) Under **Batch message settings**, specify:

      * Batch size. The values may range from 1 to 100. The default value is 1.
      * Maximum wait time. The values may range from 1 to 60 seconds. The default value is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function. However, the number of messages does not exceed the specified group size.

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
   yc serverless trigger create logging \
     --name <trigger name> \
     --log-group-name <log group name> \
     --batch-size 1 \
     --batch-cutoff 1s \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead Letter Queue ID> \
     --dlq-service-account-id <service account ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--log-group-name`: The name of the log group that will cause the function to be called when records are added.
   * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 to 100. The default value is 1.
   * `--batch-cutoff`: Maximum waiting time. This is an optional parameter. The values may range from 0 to 60 seconds. The default value is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. The number of messages cannot exceed `batch-size`.

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

- {{ TF }}

   {% include [terraform-definition](../../../_tutorials/terraform-definition.md) %}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger for {{ cloud-logging-name }}:

   1. In the configuration file, describe the trigger parameters.

      Example of the configuration file structure:

      ```hcl
      resource "yandex_function_trigger" "my_trigger" {
        name        = "<trigger name>"
        description = "<trigger description>"
        logging {
           group_id       = "<log group ID>"
           resource_types = [ "<resource type>" ]
           resource_ids   = [ "<resource ID>" ]
           levels         = [ "INFO", "ERROR" ]
           batch_cutoff   = 1
           batch_size     = 1
        function {
           id                 = "<function ID>"
           service_account_id = "<service account ID>"
        }
      }
      ```

      Where:

      * `name`: Trigger name. The name format is as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `description`: Trigger description.
      * `logging`: Logging parameters, which will activate the trigger when added to the log group, and the batch message settings:
         * `group_id`: Log group ID.
         * `resource_types`: Resource types: your services or {{ yandex-cloud }} services, for example, `resource_types = [ "serverless.function" ]`. You can specify more than one service at a time.
         * `resource_ids`: IDs of your resources or {{ yandex-cloud }} resources, for example, functions `resource_ids = [ "<function ID>" ]`. You can specify multiple IDs.
         * `levels`: Logging levels. For example, `levels = [ "INFO", "ERROR"]`.
         * `batch_cutoff`: Maximum wait time. Acceptable values are from 0 to 60 seconds. The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function or container. At the same time, the number of messages does not exceed the specified `batch-size` group.
         * `batch_size`: Message batch size. Acceptable values are from 1 to 100.
      * `function`: Settings for the function, which will be activated by the trigger:
         * `id`: Function ID.
         * `service_account_id`: ID of the service account with rights to invoke a function.

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
         yc serverless trigger get <trigger ID>
         ```

- API

   To create a trigger for {{ cloud-logging-name }}, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/functions/check-result.md) %}

## See also {#see-also}

* [Trigger for {{ cloud-logging-name }} that invokes a {{ serverless-containers-name }} container](../../../serverless-containers/operations/cloud-logging-trigger-create.md).
