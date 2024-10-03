# Creating a trigger for budgets that sends messages to WebSocket connections

Create a [trigger for budgets](../../concepts/trigger/budget-trigger.md) to send messages to [WebSocket connections](../../concepts/extensions/websocket.md) when threshold values are exceeded.

## Getting started {#before-you-begin}

{% include [trigger-before-you-begin](../../../_includes/api-gateway/trigger-before-you-begin.md) %}

* A budget which, when exceeded, fires a trigger. If you do not have a budget, [create one](../../../billing/operations/budgets.md).

## Creating a trigger {#trigger-create}

{% include [trigger-time](../../../_includes/functions/trigger-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a trigger.

    1. Open **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.

    1. In the left-hand panel, select ![image](../../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_base }}**:

       * Enter a name and description for the trigger.
       * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_billing-budget }}`.
       * In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_gateway-broadcast }}`.

    1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_billing-budget }}**, select your billing account and budget. You can select **{{ ui-key.yacloud.serverless-functions.triggers.form.label_any-budget }}**.

    1. {% include [api-gateway-settings](../../../_includes/api-gateway/api-gateway-settings.md) %}

    1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

- CLI {#cli}

    {% include [cli-install](../../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  To create a trigger that sends messages to WebSocket connections, run this command:

    ```bash
    yc serverless trigger create billing-budget \
      --name <trigger_name> \
      --billing-account-id <billing_account_ID> \
      --budget-id <budget_ID> \
      --gateway-id <API_gateway_ID> \
      --gateway-websocket-broadcast-path <path> \
      --gateway-websocket-broadcast-service-account-id <service_account_ID>
    ```

    Where:

    * `--name`: Trigger name.
    * `--billing-account-id`: Billing account ID.
    * `--budget-id`: Budget ID.

    {% include [trigger-cli-param](../../../_includes/api-gateway/trigger-cli-param.md) %}

    Result:

    ```text
    id: a1sfe084v4h2********
    folder_id: b1g88tflruh2********
    created_at: "2019-12-04T08:45:31.131391Z"
    name: budget-trigger
    rule:
      billing-budget:
        billing-account-id: dn2char50jh2********
        budget-id: dn2jnshmdlh2********
        gateway_websocket_broadcast:
          gateway_id: d4eofc7n0mh2********
          path: /
          service_account_id: aje3932acdh2********
    status: ACTIVE
    ```

- API {#api}

  To create a trigger for budgets, use the [create](../../triggers/api-ref/Trigger/create.md) REST API method for the [Trigger](../../triggers/api-ref/Trigger/index.md) resource or the [TriggerService/Create](../../triggers/api-ref/grpc/trigger_service.md#Create) gRPC API call.

{% endlist %}

## Checking the result {#check-result}

{% include [check-result](../../../_includes/api-gateway/check-result.md) %}

## See also {#see-also}

* [Trigger for budgets that invokes a {{ sf-name }} function](../../../functions/operations/trigger/budget-trigger-create.md)
* [{#T}](../../../serverless-containers/operations/budget-trigger-create.md)
