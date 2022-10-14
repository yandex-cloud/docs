Create a trigger for [{{ cloud-logging-name }}](../../logging/) that calls a {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md) when entries are added to a [log group](../../logging/concepts/log-group.md).

For more information about creating a trigger for {{ cloud-logging-name }} that calls a function, see the [{{ sf-name }} documentation](../../functions/operations/trigger/cr-trigger-create.md).

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](./trigger-before-you-begin.md) %}

* The log group that activates the trigger when records are added to it. If you don't have a log group, [create one](../../logging/operations/create-group.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Open **{{ serverless-containers-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **{{ cloud-logging-name }}**.
      * In the **Launched resource** field, select **Container**.

   1. Under **{{ cloud-logging-name }} settings**, specify:

      * The log group.
      * (Optional) Resource types: {{ yandex-cloud }} or your services, such as, `serverless.function`.
      * (Optional) IDs of {{ yandex-cloud }} or your resources, such as {{ serverless-containers-name }} containers.
      * (Optional) Logging levels.

      A trigger activates when records that match all the optional settings are added to the specified log group. If an optional setting is undefined, the trigger activates for any value of the setting.

   1. (optional) Under **Batch message settings**, specify:

      * Batch size. Valid values range from 1 to 100. The default is 1.
      * Maximum wait time. Valid values range from 1 to 60 seconds. The default is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a container. However, the number of messages does not exceed the specified group size.

   1. Under **Container settings**, select a container and specify:

      * A [container revision](../../serverless-containers/concepts/container.md#revision).
      * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the container will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **Create trigger**.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}
