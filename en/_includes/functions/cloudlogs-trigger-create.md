{% note alert %}

Trigger for {{ cloud-logs-name }} is outdated. Use [triggers for {{ cloud-logging-name }}](../../functions/concepts/trigger/cloud-logging-trigger.md).

{% endnote %}

Create a [trigger for {{ cloud-logs-name }}](../../functions/concepts/trigger/cloudlogs-trigger.md) that invokes your function when messages are received in a log group.

To create a trigger, you need:

* A [function](../../functions/concepts/function.md) that the trigger will launch. If you don't have a function:

   * [Create a function](../../functions/operations/function/function-create.md).
   * [Create a function version](../../functions/operations/function/version-manage.md).

* (optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a function will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service account](../../iam/concepts/users/service-accounts.md) with rights to invoke the function and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Cloud Logs**.

   1. Under **Cloud Logs settings**, specify what sources the function will process messages from. Log groups are identified automatically.

   1. (optional) Under **Batch message settings**, specify:

      * Batch size. Values can be from 1 to 10. The default is 1.
      * Maximum wait time. Values can be from 0 to 20 seconds. The default is 10 seconds. The trigger will send the batch of messages to the function when the number of messages in the log group reaches the specified batch size or the maximum waiting time expires.

   1. Under **Function settings**:

      * Select the function for the trigger to invoke.

         {% note alert %}

         Selecting a function that serves as the source of logs for the trigger may result in an exponential rise in calls.

         {% endnote %}

      * Specify the [function version tag](../../functions/concepts/function.md#tag).
      * Specify the [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the function will be invoked again if the current attempt fails. You can specify values from 10 to 60 seconds, 10 being default.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can specify values from 1 to 5, 1 being default.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **Create trigger**.

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
   * `--batch-size`: Message batch size. This is an optional parameter. Values can be from 1 to 10. The default is 1.
   * `--batch-cutoff`: Maximum waiting time. This is an optional parameter. Values can be from 0 to 20 seconds. The default is 10 seconds. The trigger will send the batch of messages to the function when the number of messages in the log group reaches the `batch-size` or the `batch-cutoff` expires.
   * `--invoke-function-id`: Function ID.
   * `--invoke-function-service-account-id`: Service account with rights to invoke the function.
   * `--retry-attempts`: Time after which the function will be invoked again if the current attempt fails. This is an optional parameter. You can specify values from 10 to 60 seconds, 10 being default.
   * `--retry-interval`: Number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). This is an optional parameter. You can specify values from 1 to 5, 1 being default.
   * `--dlq-queue-id`: [Dead Letter Queue](../../functions/concepts/dlq.md) ID. This is an optional parameter.
   * `--dlq-service-account-id`: Service account with the permission to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). This is an optional parameter.


   Result:

   ```
   id: a1s92agr8mpgeo3kjt48
   folder_id: b1g88tflru0ek1omtsu0
   created_at: "2020-08-13T10:46:55.947Z"
   name: log-trigger
   rule:
     cloud_logs:
       log_group_id:
       - eolhui6rdfg564kl8h67
       - eol7tkttsd345gju74df
       batch_settings:
         size: "1"
         cutoff: 10s
       invoke_function:
         function_id: d4eofc7n0m03lmudsk7y
         function_tag: $latest
         service_account_id: aje3932acd0c5ur7drte
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknnpj1ll45e:dlq
           service-account-id: aje3932acd0c5ur7dagp
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
