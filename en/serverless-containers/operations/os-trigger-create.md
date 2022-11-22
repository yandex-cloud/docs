# Creating a trigger for {{ objstorage-name }}

Create a [trigger for {{ objstorage-name }}](../concepts/trigger/os-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when you create, move, or delete an [object](../../storage/concepts/object.md) in a bucket.

## Before you begin {#before-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* [Bucket](../../storage/concepts/bucket.md) whose object events will fire the trigger. If you don't have a bucket, [create one](../../storage/operations/buckets/create.md).

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
      * In the **Type** field, select **{{ objstorage-name }}**.
      * In the **Launched resource** field, select **Container**.

   1. Under **{{ objstorage-name }} settings**:

      * In the **Bucket** field, select the bucket whose object events you want to create a trigger for.
      * In the **Event types** field, select the events that will fire the trigger.
      * (optional) In the **Object key prefix** field, enter a prefix for filtering.
      * (optional) In the **Object key suffix** field, enter a suffix for filtering.

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

* [Trigger for {{ objstorage-name }} that calls a {{ sf-name }} function](../../functions/operations/trigger/os-trigger-create.md).
