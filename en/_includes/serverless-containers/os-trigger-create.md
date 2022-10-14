Create a trigger for {{ objstorage-name }} that calls a {{ serverless-containers-name }} [container](../../serverless-containers/concepts/container.md) when you create, move, or delete an [object](../../storage/concepts/object.md) in a bucket.

For more information about creating a trigger for {{ objstorage-name }} that calls a function, see the [{{ sf-name }} documentation](../../functions/operations/trigger/os-trigger-create.md).

## Before you begin {#before-begin}

{% include [trigger-before-you-begin](./trigger-before-you-begin.md) %}

* [Bucket](../../storage/concepts/bucket.md) whose object events will fire the trigger. If you don't have a bucket, [create one](../../storage/operations/buckets/create.md).

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
      * In the **Type** field, select **Object Storage**.
      * In the **Launched resource** field, select **Container**.

   1. Under **Object Storage settings**:

      * In the **Bucket** field, select the bucket whose object events you want to create a trigger for.
      * In the **Event types** field, select the events that will fire the trigger.
      * (optional) In the **Object key prefix** field, enter a prefix for filtering.
      * (optional) In the **Object key suffix** field, enter a suffix for filtering.

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
