Create a trigger for [budgets](../../billing/concepts/budget.md) that calls a {{ sf-name }} [function](../../functions/concepts/function.md) when threshold values are exceeded.

For more information about creating a trigger for budgets that calls a container, see the [{{ serverless-containers-full-name }} documentation](../../serverless-containers/operations/budget-trigger-create.md).

## Before you begin {#before-you-begin}

{% include [trigger-before-you-begin](trigger-before-you-begin.md) %}

* A budget which, when exceeded, a trigger is fired. If you don't have a budget, [create one](../../billing/operations/budgets.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your trigger.

   1. Select **{{ sf-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Budget**.
      * In the **Launched resource** field, select **Function**.

   1. Under **Budget settings**, select your billing account and budget. You can select **All budgets**.

   1. Under **Function settings**, select a function and specify:

      * [Tag of the function version](../../functions/concepts/function.md#tag);
      * A [service account](../../iam/concepts/users/service-accounts.md) to be used to invoke the function.

   1. (optional) Under **Repeat request settings**:

      * In the **Interval** field, specify the time after which the function will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
      * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.

   1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To create a trigger that launches a function, run the command:

   ```
   yc serverless trigger create billing-budget \
     --name <trigger name> \
     --billing-account-id <billing account ID> \
     --budget-id <budget ID> \
     --invoke-function-id <function ID> \
     --invoke-function-service-account-id <service account ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead Letter Queue ID> \
     --dlq-service-account-id <service account ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--billing-account-id`: Billing account ID.
   * `--budget-id`: Budget ID.
   * `--invoke-function-id`: Function ID.
   * `--invoke-function-service-account-id`: ID of the service account with rights to invoke the function.
   * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Optional. Values can be from 10 to 60 seconds. The default is 10 seconds.
   * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../message-queue/concepts/dlq.md). Optional. Values can be from 1 to 5. The default is 1.
   * `--dlq-queue-id`: [Dead Letter Queue](../../functions/concepts/dlq.md) ID. Optional.
   * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional.

   Result:

   ```
   id: a1sfe084v4se4morbu2i
   folder_id: b1g88tflru0ek1omtsu0
   created_at: "2019-12-04T08:45:31.131391Z"
   name: budget-trigger
   rule:
     billing-budget:
       billing-account-id: dn2char50j**********
       budget-id: dn2jnshmdlc1********
       invoke_function:
         function_id: d4eofc7n0m03********
         function_tag: $latest
         service_account_id: aje3932acd0c********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmknn********:dlq
           service-account-id: aje3932acd0c********
   status: ACTIVE
   ```

- API

   You can create a trigger using the API [create](../../functions/triggers/api-ref/Trigger/create.md).

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}
