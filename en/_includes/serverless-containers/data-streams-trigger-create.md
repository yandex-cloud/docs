{% if audience == "external" %} Create a trigger for [{{ yds-name }}](../../data-streams/) that calls a {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md) when data is sent to a [stream](../../data-streams/concepts/glossary.md#stream-concepts). {% endif %}

For more information about creating a trigger for {{ yds-name }} that calls a function, see the [{{ sf-name }} documentation](../../functions/operations/trigger/cr-trigger-create.md).

## Before you begin {#before-you-begin}

To create a trigger, you need:

* A container that the trigger will launch. If you don't have a container:

   * [Create a container](../../serverless-containers/operations/create.md).
   * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).

* (optional) A [Dead Letter Queue](../../functions/concepts/dlq.md) where messages that could not be processed by a container will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).

* [Service accounts](../../iam/concepts/users/service-accounts.md) with rights:

   * To invoke a container.
   * To read from the stream that activates the trigger when data is sent there.
   * (optional) To write to the [Dead Letter Queue](../../functions/concepts/dlq.md).

   You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

* The stream that activates the trigger when it receives data. {% if audience == "external" %} If you don't have a stream, [create one](../../data-streams/quickstart/create-stream.md). {% endif %}

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
      * In the **Type** field, select **Data Streams**.
      * In the **Launched resource** field, select **Container**.

   1. Under **Data Streams settings**, select a data stream and a service account with rights to read data from and write data to it.

   1. (optional) Under **Batch message settings**, specify:

      * Size of the message group in bytes. Valid values range from 1 B to 64 KB. The default is 1 B.
      * Maximum wait time. Valid values range from 1 to 60 seconds. The default is 1 second.

      The trigger groups messages for a period of time not exceeding the specified timeout and sends them to a container. The total amount of data passed to a container may exceed the specified group size if the data is transmitted as a single message. Otherwise, the amount of data does not exceed the group size.

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
