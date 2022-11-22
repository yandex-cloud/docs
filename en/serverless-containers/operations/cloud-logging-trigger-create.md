# Creating a trigger for {{ cloud-logging-full-name }}

Create a [trigger for {{ cloud-logging-name }}](../concepts/trigger/cloud-logging-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when entries are added to a [log group](../../logging/concepts/log-group.md).

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* The log group that activates the trigger when records are added to it. If you don't have a log group, [create one](../../logging/operations/create-group.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

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

      {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (optional) Under **Repeat request settings**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (optional) **Under Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also

* [Trigger for {{ cloud-logging-name }} that calls a {{ sf-name }} function](../../functions/operations/trigger/cloud-logging-trigger-create.md).
