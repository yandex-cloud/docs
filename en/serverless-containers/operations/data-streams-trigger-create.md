# Creating a trigger for {{ yds-full-name }}

 Create a [trigger for {{ yds-name }}](../concepts/trigger/data-streams-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when data is sent to a [stream](../../data-streams/concepts/glossary.md#stream-concepts). 

## Before you begin {#before-you-begin}

To create a trigger, you need:

* A container that the trigger will launch. If you don't have a container:

   * [Create a container](create.md).
   * [Create a container revision](manage-revision.md#create).

* (optional) A [Dead Letter Queue](../concepts/dlq.md) where messages that could not be processed by a container will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a container.
   * To read from the stream that activates the trigger when data is sent there.
   * (optional) To write to the Dead Letter Queue.

   You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

* The stream that activates the trigger when it receives data.  If you don't have a stream, [create one](../../data-streams/quickstart/create-stream.md). 

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
      * In the **Type** field, select **{{ yds-name }}**.
      * In the **Launched resource** field, select **Container**.

   1. Under **{{ yds-name }} settings**, select a data stream and a service account with rights to read data from this data stream and write data to it.

   1. (optional) Under **Batch message settings**, specify:

      * Size of the message group in bytes. Valid values range from 1 B to 64 KB. The default is 1 B.
      * Maximum wait time. Valid values range from 1 to 60 seconds. The default is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a container. The total amount of data passed to a container may exceed the specified group size if the data is transmitted as a single message. Otherwise, the amount of data does not exceed the group size.

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

* [Trigger for {{ yds-name }} that calls a {{ sf-name }} function](../../functions/operations/trigger/data-streams-trigger-create.md).
