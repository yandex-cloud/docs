Create a trigger for [budgets](../../billing/concepts/budget.md) that will invoke a [function](../../functions/concepts/function.md) in {{ sf-name }} or a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when threshold values are exceeded.

## Before you start {#before-you-begin}

To create a trigger, you need:

* A function or container the the trigger will launch.
    * If you don't have a function:
        * [Create a function](../../functions/operations/function/function-create.md).
        * [Create a function version](../../functions/operations/function/version-manage.md#func-version-create).
    * If you don't have a container:
        * [Create a container](../../serverless-containers/operations/create.md).
        * [Create a container revision](../../serverless-containers/operations/manage-revision.md#create).
* A budget which, when exceeded, a trigger is fired. If you don't have a budget, [create one](../../billing/operations/budgets.md).
* (optional) The [Dead Letter Queue](../../functions/concepts/dlq.md), where messages that the function or container could not process will be redirected. If you don't have a queue, [create one](../../message-queue/operations/message-queue-new-queue.md).
* Service accounts with rights to invoke a function or a container and (optionally) write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). You can use the same service account or different ones. If you don't have a service account, [create one](../../iam/operations/sa/create.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](trigger-time.md) %}

{% list tabs %}

- Management console
    1. In the [management console]({{ link-console-main }}), go to the folder where you want to create a trigger.
    1. Open **{{ sf-name }}**.
    1. Go to the **Triggers** tab.
    1. Click **Create trigger**.
    1. Under **Basic parameters**:
        * Enter a name and description for the trigger.
        * In the **Type** field, select **Budget**.
        * Choose what will fire a trigger — a function or a container.
    1. Under **Budget settings**, select your billing account and budget. You can select **All budgets**.
    1. If the trigger launches:
    * A function, select one under **Function settings** and specify:
        * [Tag of the function version](../../functions/concepts/function.md#tag).
        * A service account to be used to invoke the function.
    * A container, select one under **Container settings** and specify:
        * [A container revision](../../serverless-containers/concepts/container.md#revision).
        * A service account to be used to invoke the container.
    1. (optional) Under **Repeat request settings**:
        * In the **Interval** field, specify the time after which the function or the container will be invoked again if the current attempt fails. Values can be from 10 to 60 seconds. The default is 10 seconds.
        * In the **Number of attempts** field, specify the number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../functions/concepts/dlq.md). Values can be from 1 to 5. The default is 1.
    1. (optional) Under **Dead Letter Queue settings**, select the [Dead Letter Queue](../../functions/concepts/dlq.md) and service account with rights to write messages to it.
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
    * `--retry-attempts`: The time after which the function will be invoked again if the current attempt fails. Optional parameter. Values can be from 10 to 60 seconds. The default is 10 seconds.
    * `--retry-interval`: The number of invocation retries before the trigger moves a message to the [Dead Letter Queue](../../message-queue/concepts/dlq.md). Optional parameter. Values can be from 1 to 5. The default is 1.
    * `--dlq-queue-id`: ID of the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional parameter.
    * `--dlq-service-account-id`: Service account with rights to write messages to the [Dead Letter Queue](../../functions/concepts/dlq.md). Optional parameter.

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
            queue-id: yrn:yc:ymq:ru-central1:aoek49ghmknn********:dlq
            service-account-id: aje3932acd0c********
    status: ACTIVE
    ```

- API

    You can create a trigger using the [create](../../functions/triggers/api-ref/Trigger/create.md) API method.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](check-result.md) %}

