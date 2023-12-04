{% note alert %}

Trigger for {{ cloud-logs-name }} is outdated. Use [triggers for {{ cloud-logging-name }}](../../functions/concepts/trigger/cloud-logging-trigger.md).

{% endnote %}

Create a [trigger for {{ cloud-logs-name }}](../../functions/concepts/trigger/cloudlogs-trigger.md) that invokes your function when messages are received in a log group.

To create a trigger, you need:

* A [function](../../functions/concepts/function.md) that the trigger will launch. If you do not have a function:

   * [Create a function](../../functions/operations/function/function-create.md).
   * [Create a function version](../../functions/operations/function/version-manage.md).

* (Optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a function will be redirected. If you do not have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service account](../../iam/concepts/users/service-accounts.md) with rights to invoke the function and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you do not have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.

   1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

      * Enter a name and description for the trigger.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_cloud-logs }}**.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_cloud-logs }}**, specify what sources the function will process messages from. Log groups are identified automatically.

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_batch-settings }}**, specify:

      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_ymq-cutoff }}**. The values may range from 0 to 20 seconds. The default value is 10 seconds. The trigger will send the batch of messages to the function when the number of messages in the log group reaches the specified batch size or the maximum waiting time expires.
      * **{{ ui-key.yacloud.serverless-functions.triggers.form.field_size }}**. The values may range from 1 to 10. The default value is 1.

   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**:

      * Select the function for the trigger to invoke.

         {% note alert %}

         Selecting a function that serves as the source of logs for the trigger may result in an exponential rise in calls.

         {% endnote %}

      * Specify the [function version tag](../../functions/concepts/function.md#tag).
      * Specify the [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function-retry }}**:

      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-interval }}** field, specify the time after which the function will be invoked again if the current attempt fails. The values may range from 10 to 60 seconds. The default value is 10 seconds.
      * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_retry-attempts }}** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). The values may range from 1 to 5. The default value is 1.

   1. (Optional) Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_dlq }}**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger, run the command:

   ```
   yc serverless trigger create cloud-logs \
     --name <trigger name> \
     --log-groups <comma-separated log group IDs> \
     --batch-size 10 \
     --batch-cutoff 10s \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead Letter Queue ID> \
     --dlq-service-account-id <service account ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--log-groups`: List of IDs of log groups.
   * `--batch-size`: Message batch size. This is an optional parameter. The values may range from 1 to 10. The default value is 1.
   * `--batch-cutoff`: Maximum wait time. This is an optional parameter. The values may range from 0 to 20 seconds. The default value is 10 seconds. The trigger will send the batch of messages to the function when the number of messages in the log group reaches the `batch-size` or the `batch-cutoff` expires.
   * `--invoke-function-id`: Function ID.
   * `--invoke-function-service-account-id`: Service account with rights to invoke the function.
   * `--retry-attempts`: Time after which the function will be invoked again if the current attempt fails. This is an optional parameter. The values may range from 10 to 60 seconds. The default value is 10 seconds.
   * `--retry-interval`: Number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). This is an optional parameter. The values may range from 1 to 5. The default value is 1.
   * `--dlq-queue-id`: [Dead Letter Queue](../../functions/concepts/dlq.md) ID. This is an optional parameter.
   * `--dlq-service-account-id`: Service account with the permission to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). This is an optional parameter.


   Result:

   ```
   id: a1s92agr8mpg********
   folder_id: b1g88tflru0e********
   created_at: "2020-08-13T10:46:55.947Z"
   name: log-trigger
   rule:
     cloud_logs:
       log_group_id:
       - eolhui6rdfg5********
       - eol7tkttsd34********
       batch_settings:
         size: "1"
         cutoff: 10s
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

   To create a trigger for {{ cloud-logs-name }}, use the [create](../../functions/triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../functions/triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../functions/triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% list tabs %}

- Functions

   Make sure the trigger is working properly. To do this, [view](../../functions/operations/function/function-logs.md) logs for the following:
   * The function that the trigger runs.
   * The functions that are specified as log sources.

- IoT Core

   [View](../../iot-core/operations/logs.md) the logs of the registries and devices that are specified as log sources.

{% endlist %}
