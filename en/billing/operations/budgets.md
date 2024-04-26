# Enabling notifications

To manage costs in {{ yandex-cloud }}, you can configure notifications using [budgets](../concepts/budget.md).

Available budget types:
* _{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}_: Notification is sent when the cost of resources, without discounts applied, exceeds a specified usage limit.
* _{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}_: Notification is sent when the cost of resources, with discounts and active promo codes applied, exceeds a specified usage limit.
* _{{ ui-key.yacloud_billing.billing.account.budgets.label_type-balance }}_: Notification is sent when the personal account balance falls below a specified threshold.


{% note info %}

You can create a trigger that will invoke a [function](../../functions/concepts/function.md) in {{ sf-name }} or run a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when threshold values are exceeded. Read more about [triggers for budgets](../../functions/operations/trigger/budget-trigger-create.md).

{% endnote %}


## Creating a budget {#create-budget}

To create a budget, you need the `editor` role. The `viewer` role is enough for the specified recipients to get budget notifications. For more information on access control, see [{#T}](../../iam/concepts/access-control/roles.md).

To create a budget:

{% list tabs group=instructions %}

- {{ billing-interface }} {#billing}

   1. Go to [**{{ billing-name }}**]({{ link-console-billing }}).

   1. Select an account on the **{{ ui-key.yacloud_billing.billing.title_accounts }}** page.

   1. Go to the **{{ ui-key.yacloud_billing.billing.account.budgets.label_budgets }}** page and click **{{ ui-key.yacloud_billing.billing.account.budgets.button_create }}**.

      1. Enter the budget name.
      1. Select **{{ ui-key.yacloud_billing.billing.account.budgets.label_type }}**.
      1. Set the **Budget amount**: 
         
         * For the **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}** or **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}** type, specify the total usage cost.
         * For the **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-balance }}** type, specify the account balance.

      1. For the **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}** and **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}** types, select a budget tracking period:

         * If you selected the **{{ ui-key.yacloud_billing.billing.account.budgets.reset-period_value_custom }}** period, set the budget start date. The start date is the first day of the month.
         * Set the budget end date. The end date defines when the budget stops tracking usage or the account balance and sending notifications. The end date is the last day of the month. It must be within five years of the current date.

      1. Under **{{ ui-key.yacloud_billing.billing.account.budgets.label_notify }}**, select the users to notify.
      1. For the **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}** and **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}** types, define the budget **{{ ui-key.yacloud_billing.billing.account.budgets.section_scope }}**. You can select individual clouds, folders, and services to include in a set budget. By default, data is collected from all the clouds, folders, and services that the selected billing account has access to.
      1. Set at least one utilization threshold to trigger notifications. You can specify a threshold as a percentage or a cash value and select the users to receive notifications. A budget can have multiple thresholds.

      {% note info %}

      Users listed in the **{{ ui-key.yacloud.common.section-base }}** section will receive notifications when each specified threshold is exceeded. Users listed when setting a threshold will only receive a notification when that specific threshold is reached.

      If several budget thresholds are reached at the same time, users will receive a single notification.

      {% endnote %}

   1. After filling in all the fields, click **{{ ui-key.yacloud.common.create }}**. This will create a budget.

- API {#api}

   To create a budget, use the [create](../api-ref/Budget/create.md) REST API method for the [Budget](../api-ref/Budget/index.md) resource or the [BudgetService/Create](../api-ref/grpc/budget_service.md#Create) gRPC API call.

{% endlist %}


## See also

* [{#T}](../tutorials/serverless-trigger-budget-vm.md)
* [{#T}](../tutorials/serverless-trigger-budget-queue-vm-tg.md)
