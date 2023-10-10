# Enable notifications

To manage costs in {{ yandex-cloud }}, you can configure notifications using [budgets](../concepts/budget.md).

Available budget types:
* _{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}_: Notification is sent when the cost of resources, without discounts applied, exceeds a specified usage limit.
* _{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}_: Notification is sent when the cost of resources, with discounts and active promo codes applied, exceeds a specified usage limit.
* _{{ ui-key.yacloud.billing.account.budgets.label_type-balance }}_: Notification is sent when the personal account balance falls below a specified threshold.


{% note info %}

You can create a trigger that will invoke a [function](../../functions/concepts/function.md) in {{ sf-name }} or run a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when threshold values are exceeded. Read more about [triggers for budgets](../../functions/operations/trigger/budget-trigger-create.md).

{% endnote %}


## Creating a budget {#create-budget}

To create a budget, you need the `editor` role. The `viewer` role is enough for the specified recipients to get budget notifications. For more information on access control, see [{#T}](../../iam/concepts/access-control/roles.md).

To create a budget:

1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).

1. In the top-left corner, click ![image](../../_assets/main-menu.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.

1. Select ![image](../../_assets/billing.svg) [**{{ billing-name }}**]({{ link-console-billing }}).

1. Select an account on the **{{ ui-key.yacloud.billing.label_accounts }}** page.

1. Go to the **{{ ui-key.yacloud.billing.account.budgets.label_budgets }}** page and click **{{ ui-key.yacloud.billing.account.budgets.button_create }}**.

   1. Enter the budget name.
   1. Select **{{ ui-key.yacloud.billing.account.budgets.label_type }}**.
   1. Set the **Budget amount**: 
            * For the **{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}** or **{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}** type, specify total usage cost.
      * For the **{{ ui-key.yacloud.billing.account.budgets.label_type-balance }}** type, specify account balance.
   1. For the **{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}** and **{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}** types, select a budget tracking period:
      * If you selected **{{ ui-key.yacloud.billing.account.budgets.reset-period_value_custom }}** as the tracking period type, set the budget start date. The start date is the first day of the month.
      * Set the budget end date. The end date defines when the budget stops tracking usage or the account balance and sending notifications. The end date is the last day of the month. It must be within five years of the current date.
   1. Select the users to notify.
   1. For the **{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}** and **{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}** types, define the budget scope. You can select individual clouds, folders, and services to include in a set budget. By default, data is collected from all the clouds, folders, and services that the selected billing account has access to.
   1. Set at least one utilization threshold to trigger notifications. You can specify a threshold as a percentage or a cash value and select the users to receive notifications. A budget can have multiple thresholds.

   {% note info %}

   Users listed in the **{{ ui-key.yacloud.common.section-base }}** section will receive notifications when each specified threshold is exceeded. Users listed when setting a threshold will only receive a notification when that specific threshold is reached.

   If several budget thresholds are reached at the same time, users will receive a single notification.

   {% endnote %}

1. After filling in all the fields, click **{{ ui-key.yacloud.billing.accounts.button_empty-billing-create }}**. This will create a budget.



## See also

* [{#T}](../tutorials/serverless-trigger-budget-vm.md)
