{% note alert %}

Triggers for {{ cloud-logs-name }} are deprecated. Use [triggers for {{ cloud-logging-name }}](../../functions/concepts/trigger/cloud-logging-trigger.md).

{% endnote %}

Create a [trigger for {{ cloud-logs-name }}](../../functions/concepts/trigger/cloudlogs-trigger.md) that will run your function when messages are received in a [log group](../../functions/concepts/log-group.md).

To create a trigger, you need:

* [Functions](../../functions/concepts/function.md) that the trigger will call. If you don't have a function:
    * [Create a function](../../functions/operations/function/function-create.md).
    * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).
* (optional) The [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that the function couldn't process are moved. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).
* Service account with rights to invoke the function and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create a trigger.
    1. Open **{{ sf-name }}**.
    1. Go to the **Triggers** tab.
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

        * Specify the service account to be used to invoke the function.
    1. (optional) Under **Repeat request settings**:
        * In the **Interval** field, specify the time after which the function will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
        * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.
    1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and service account with rights to write messages to it.
    1. Click **Create trigger**.

- CLI

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To create a trigger, run the command:

    ```
    yc serverless trigger create cloud-logs \
        --name <trigger name> \
        --log-groups <comma-separated list of log group IDs> \
        --batch-size 10 \
        --batch-cutoff 10s \
        --invoke-function-id <function ID> \
        --invoke-function-service-account-id <service account ID> \
        --retry-attempts 1 \
        --retry-interval 10s \
        --dlq-queue-id <Dead Letter Queue ID> \
        --dlq-service-account-id <service account ID>
    ```

    where:
    * `--name`: Trigger name.
    * `--log-groups`: List of IDs of [log groups](../../functions/concepts/log-group.md).
    * `--batch-size`: Message batch size. Optional parameter. Values can be from 1 to 10. The default is 1.
    * `--batch-cutoff`: Maximum waiting time. Optional parameter. Values can be from 0 to 20 seconds. The default is 10 seconds. The trigger will send the batch of messages to the function when the number of messages in the log group reaches the `batch-size` or the `batch-cutoff` expires.
    * `--invoke-function-id`: Function ID.
    * `--invoke-function-service-account-id`: Service account with rights to call the function.
    * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Optional parameter. Values can be from 10 to 60 seconds. The default is 10 seconds.
    * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional parameter. Values can be from 1 to 5. The default is 1.
    * `--dlq-queue-id`: ID of the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional parameter.
    * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional parameter.

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
            queue-id: yrn:yc:ymq:ru-central1:aoek49ghmknnpj1ll45e:dlq
            service-account-id: aje3932acd0c5ur7dagp
    status: ACTIVE
    ```

- API

    You can create a trigger for {{ cloud-logs-name }} using the [create](../../functions/triggers/api-ref/Trigger/create.md) API method.

{% endlist %}

## Checking the result {#check-result}

{% list tabs %}

- Functions

    Make sure the trigger is working properly. To do this, [view](../../functions/operations/function/function-logs.md) the logs of:
    * The function that the trigger runs.
    * The functions that are specified as log sources.

- IoT Core

    [View](../../iot-core/operations/logs.md) the logs of the registries and devices that are specified as log sources.

{% endlist %}

