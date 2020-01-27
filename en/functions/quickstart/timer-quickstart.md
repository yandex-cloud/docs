# Creating a timer

{% include [triggers-preview](../../_includes/functions/triggers-preview-stage.md) %}

Create a [timer](../concepts/trigger/timer.md) and run your functions on a schedule.

## Before you start {#before-begin}

To create a timer, you need:

1. A service account with rights for function call. If you don't have a service account, [create one](../../iam/operations/sa/create.md).
1. [A function](../concepts/function.md) that the trigger will send messages to for processing. If you don't have a function:
    - [Create a function](../operations/function/function-create.md).
    - [Create a function version and upload your function code to it](../operations/function/version-manage.md#func-version-create).

## Create a timer {#trigger-create}

To create a timer:

1. Open **{{ sf-name }}** in the folder where you want to create a timer.
1. Go to the **Triggers** tab.
1. Click **Create trigger**.
1. Under **Basic parameters**:
    * Enter a name and description for the trigger.
    * In the **Type** field, select **Timer**.
1. Under **Timer settings**:
    * In the **Cron expression** field, enter your [cron expression](../concepts/trigger/timer.md#cron-expression).
1. Under **Function settings**:
    * Select the function to be called by the timer.
    * Specify [the function version tag](../concepts/function.md#tag).
    * Specify the service account to be used to call the function.
1. Click **Create trigger**.

## What's next {#what-is-next}

- Read about the [concept of triggers](../concepts/trigger/index.md).
- Read more about [timers](../concepts/trigger/timer.md).
- For information about what you can do with triggers, see our [step-by-step instructions](../operations/index.md).

