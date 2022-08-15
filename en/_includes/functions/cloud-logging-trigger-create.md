Create a trigger for [{{ cloud-logging-name }}](../../logging/) that calls a {{ sf-name }} [function](../../functions/concepts/function.md) or {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md) when entries are added to a [log group](../../logging/concepts/log-group.md).

## Before you start {#before-you-begin}

To create a trigger, you need:

* A function or a container the trigger will launch.

   * If you don't have a function:

      * [Create a function](../../functions/operations/function/function-create.md).
      * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).

   * If you don't have a container:

      * [Create a container](../../serverless-containers/operations/create.md).
      * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* The log group that activates the trigger when records are added to it. If you don't have a log group, [create one](../../logging/operations/create-group.md).

* (optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a function or a container will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights to invoke a function or a container and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

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
      * Choose what the trigger will launch — a function or a container.

   1. Under **{{ cloud-logging-name }} settings**, specify:

      * The log group.
      * (Optional) Resource types: {{ yandex-cloud }} or your services, such as, `serverless.function`.
      * (Optional) IDs of {{ yandex-cloud }} or your resources, such as {{ sf-name }} functions.
      * (Optional) Logging levels.

      A trigger activates when records that match all the optional settings are added to the specified log group. If an optional setting is undefined, the trigger activates for any value of the setting.

   1. (optional) Under **Batch message settings**, specify:

      * Batch size. Valid values range from 1 to 100. The default is 1.
      * Maximum wait time. Valid values range from 1 to 60 seconds. The default is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a function or container. However, the number of messages does not exceed the specified group size.

   1. If the trigger launches:

      * A function, select one under **Function settings** and specify:

         * [Tag of the function version](../../functions/concepts/function.md#tag);
         * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

      * A container, select one under **Container settings** and specify:

         * [A container revision](../../serverless-containers/concepts/container.md#revision);
         * [A service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the function or the container will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges to this queue.

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
   * `--batch-cutoff`: Maximum waiting time. Optional. Valid values range from 0 to 60 seconds. The default is 1 second. The trigger groups messages for a period not exceeding `batch-cutoff` and sends them to a function or container. At the same time, the number of messages does not exceed `batch-size`.
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

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}
