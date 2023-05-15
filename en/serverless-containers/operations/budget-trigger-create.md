# Creating a trigger for budgets that invokes a {{ serverless-containers-name }} container

Create a [trigger for budgets](../concepts/trigger/budget-trigger.md) that invokes a {{ serverless-containers-name }} [container](../concepts/container.md) when threshold values are exceeded.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../_includes/serverless-containers/trigger-before-you-begin.md) %}

* A budget which, when exceeded, a trigger is fired. If you don't have a budget, [create one](../../billing/operations/budgets.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../_includes/functions/trigger-time.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create your trigger.

   1. Open **{{ serverless-containers-name }}**.

   1. On the left-hand panel, select ![image](../../_assets/functions/triggers.svg) **Triggers**.

   1. Click **Create trigger**.

   1. Under **Basic parameters**:

      * Enter a name and description for the trigger.
      * In the **Type** field, select **Budget**.
      * In the **Launched resource** field, select **Container**.

   1. Under **Budget settings**, select your billing account and budget. You can select **All budgets**.

   1. {% include [container-settings](../../_includes/serverless-containers/container-settings.md) %}

   1. (optional) Under **Repeat request settings**:

      {% include [repeat-request](../../_includes/serverless-containers/repeat-request.md) %}

   1. (optional) **Under Dead Letter Queue settings**, select the Dead Letter Queue and the service account with write privileges for this queue.

   1. Click **Create trigger**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To create a trigger that invokes a container, run this command:

   ```bash
   yc serverless trigger create billing-budget \
     --name <trigger_name> \
     --billing-account-id <billing_account_ID> \
     --budget-id <budget_ID> \
     --invoke-container-id <container_ID> \
     --invoke-container-service-account-id <service_account_ID> \
     --retry-attempts 1 \
     --retry-interval 10s \
     --dlq-queue-id <Dead_Letter_Queue_ID> \
     --dlq-service-account-id <service_account_ID>
   ```

   Where:

   * `--name`: Trigger name.
   * `--billing-account-id`: Billing account ID.
   * `--budget-id`: Budget ID.

   {% include [trigger-cli-param](../../_includes/serverless-containers/trigger-cli-param.md) %}

   Result:

   ```text
   id: a1sfe084v4**********
   folder_id: b1g88tflru**********
   created_at: "2019-12-04T08:45:31.131391Z"
   name: budget-trigger
   rule:
     billing-budget:
       billing-account-id: dn2char50j**********
       budget-id: dn2jnshmdl**********
       invoke_container:
         container_id: d4eofc7n0m**********
         service_account_id: aje3932acd**********
         retry_settings:
           retry_attempts: "1"
           interval: 10s
         dead_letter_queue:
           queue-id: yrn:yc:ymq:{{ region-id }}:aoek49ghmk**********:dlq
           service-account-id: aje3932acd**********
   status: ACTIVE
   ```

- API

   To create a trigger for budgets, use the [create](../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../_includes/serverless-containers/check-result.md) %}

## See also {#see-also}

* [Trigger for budgets that invokes a {{ sf-name }} function](../../functions/operations/trigger/budget-trigger-create.md).
