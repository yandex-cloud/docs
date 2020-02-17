# Creating a timer

{% include [triggers-preview](../../../_includes/functions/triggers-preview-stage.md) %}

Create a [timer](../../concepts/trigger/timer.md) to call your function on a schedule.

{% include [before-begin](../../../_includes/functions/os-timer-before-begin.md) %}

## Create a timer {#timer-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

    To create a timer:
    1. Open the **{{ sf-name }}** section in the folder where you want to create a timer.
    1. Go to the **Triggers** tab.
    1. Click **Create trigger**.
    1. Under **Basic parameters**:
        * Enter a name and description for the trigger.
        * In the **Type** field, select **Timer**.
    1. Under **Timer settings**:
        * In the **Cron expression** field, enter your [cron expression](../../concepts/trigger/timer.md#cron-expression).
    1. Under **Function settings**:
        * Select the function to be called by the timer.
        * Specify [the function version tag](../../concepts/function.md#tag).
        * Specify the service account that will be used to call the function.
    1. Click**Create trigger**.

- CLI

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

    To create a timer, run the command:
    * `--name`: Timer name.
    * `--cron-expression`: Function call schedule in [cron expression](../../concepts/trigger/timer.md#cron-expression) format.
    * `--invoke-function-id`: Function ID.
    * `--invoke-function-service-account-id`: Service account with rights to call the function.

    ```
    $ yc serverless trigger create timer \
        --name my-timer \
        --cron-expression '5 12 * * ? *' \
        --invoke-function-id d4eofc7n0m03lmudse8l \
        --invoke-function-service-account-id aje3932acd0c5ur7dagp
    id: a1sfe084v4se4morbu2i
    folder_id: b1g88tflru0ek1omtsu0
    created_at: "2019-12-04T08:45:31.131391Z"
    name: my-timer
    rule:
      timer:
        cron_expression: 5 12 * * ? *
        invoke_function:
          function_id: d4eofc7n0m03lmudse8l
          function_tag: $latest
          service_account_id: aje3932acd0c5ur7dagp
    ```

{% endlist %}

