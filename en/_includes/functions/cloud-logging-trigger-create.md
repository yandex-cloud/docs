Create a trigger for [{{ cloud-logging-name }}](../../logging/) that calls a {{ sf-name }} [function](../../functions/concepts/function.md) when entries are added to a [log group](../../logging/concepts/log-group.md).

For more information about creating a trigger for {{ cloud-logging-name }} that calls a container, see the [{{ serverless-containers-full-name }} documentation](../../serverless-containers/operations/cloud-logging-trigger-create.md).

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* The log group that activates the trigger when records are added to it. If you don't have a log group, [create one](../../logging/operations/create-group.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

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

   1. (optional) Under **Batch message settings**, specify:

      * Batch size. Valid values range from 1 to 100. The default is 1.
      * Maximum wait time. Valid values range from 1 to 60 seconds. The default is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function. However, the number of messages does not exceed the specified group size.

   1. Under **Function settings**, select a function and specify:

      * [Tag of the function version](../../functions/concepts/function.md#tag);
      * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the function will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that launches a function, run the command:

   ```
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
   * `--batch-size`: Message batch size. Optional. Valid values range from 1 to 100. The default is 1.
   * `--batch-cutoff`: Maximum waiting time. Optional. Valid values range from 0 to 60 seconds. The default is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function. At the same time, the number of messages does not exceed `batch-size`.
   * `--invoke-function-id`: Function ID.
   * `--invoke-function-service-account-id`: ID of the service account with rights to invoke the function.
   * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Optional. Values can be from 10 to 60 seconds. The default is 10 seconds.
   * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../message-queue/concepts/dlq.md). Optional. Values can be from 1 to 5. The default is 1.
   * `--dlq-queue-id`: [Dead Letter Queue](../../functions/concepts/dlq.md) ID. Optional.
   * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional.

   Result:

   ```
   id: a1sfe084v4se4morbu2i
   folder_id: b1g88tflru0ek1omtsu0
   created_at: "2019-12-04T08:45:31.131391Z"
   name: logging-trigger
   rule:
     logging:
       log-group-name: default
       batch_settings:
         size: "1"
         cutoff: 1s
       invoke_function:
         function_id: d4eofc7n0m03********
         function_tag: $latest
         service_account_id: aje3932acd0c********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknn********:dlq
           service-account-id: aje3932acd0c********
   status: ACTIVE
   ```

- API

   You can create a trigger using the API [create](../../functions/triggers/api-ref/Trigger/create.md).

- {{ TF }}

   {% include [terraform-definition](../../_tutorials/terraform-definition.md) %}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   To create a trigger for {{ cloud-logging-name }}:

   1. In the configuration file, describe the trigger parameters.

      Example configuration file structure:

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

      * `name`: Trigger name. Name format:

         {% include [name-format](../../_includes/name-format.md) %}

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

      For more information about resource parameters in {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/function_trigger).

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

         Afterwards, all the necessary resources are created in the specified folder. You can verify that the resources are there and properly configured in the [management console]({{ link-console-main }}) or using the following [CLI](../../cli/quickstart.md) command:

         ```
         yc serverless trigger get <trigger ID>
         ```

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}
