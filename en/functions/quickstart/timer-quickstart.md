# Creating a timer

{% include [triggers-preview](../../_includes/functions/triggers-preview-stage.md) %}

Create a [timer](../concepts/trigger/timer.md) and run your functions on a schedule.

{% include [before-begin](../../_includes/functions/os-timer-before-begin.md) %}

## Create a timer {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

To create a timer:

1. Open the **{{ sf-name }}** section in the folder where you want to create a timer.
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
    * Specify the service account that will be used to call the function.
1. Click**Create trigger**.

## What's next {#what-is-next}

- Read about the [concept of trigger](../concepts/trigger/index.md).
- Read more about the [timer](../concepts/trigger/timer.md).
- For information about what you can do with triggers, see our [step-by-step instructions](../operations/index.md).

