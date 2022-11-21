# Creating a email trigger

Create a [email trigger](../concepts/trigger/mail-trigger.md) to call a {{ serverless-containers-name }} [container](../concepts/container.md) when an email arrives. The service automatically generates an email address when creating the trigger.

For more information about creating an email trigger to call a function, see the [{{ sf-full-name }} documentation](../../functions/operations/trigger/mail-trigger-create.md).

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Select **{{ serverless-containers-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * (optional) Enter a trigger name and description.
      * In the **Type** field, select **Email**.
      * In the **Launched resource** field, select **Container**.

   1. Under **Container settings**, select a container and specify:

      * A [container revision](../concepts/container.md#revision).
      * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the container.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the container will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the Dead Letter Queue. Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

{% endlist %}

{{ serverless-containers-name }} will automatically generate an email address that will cause the trigger to fire when messages are sent to it. To see it, [retrieve detailed trigger information](trigger-list.md#trigger-get).

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}