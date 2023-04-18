# Enable notifications

To manage costs in {{ yandex-cloud }}, you can configure notifications using [budgets](../concepts/budget.md).

Available budget types:
* _Usage cost_: A notification goes out when the cost of resources with no discounts applied exceeds an established usage limit.
* _Amount payable_: A notification goes out when the cost of resources, including discounts and active promo codes, exceeds an established usage limit.
* _Account balance_: A notification goes out when a personal account balance falls below an established threshold.


{% note info %}

You can create a trigger that will invoke a [function](../../functions/concepts/function.md) in {{ sf-name }} or run a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when threshold values are exceeded. Read more about [triggers for budgets](../../functions/operations/trigger/budget-trigger-create.md).

{% endnote %}


## Creating a budget {#create-budget}

To create a budget, you need the `editor` role. The `viewer` role is enough to receive notifications. For more information on access control, see [{#T}](../../iam/concepts/access-control/roles.md).

To create a budget:

1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).

1. In the upper-left corner, click ![image](../../_assets/main-menu.svg) **All services**.

1. Select ![image](../../_assets/billing.svg) [**Billing**]({{ link-console-billing }}).

1. Select an account on the **Accounts** page.

1. Go to the **Budgets** page and click **Create budget**.

   1. Enter the budget name.
   1. Select **Budget type**.
   1. Specify the **Budget amount**: 
            * For the **Usage cost** or **Amount payable** types, set a total usage cost.
      * For the **Account balance** type, set an account balance.
   1. For the **Usage cost** and **Amount** payable types, select a budget tracking period:
      * If you selected **Customizable** as the tracking period type, set the budget start date. The start date is the first day of a month.
      * Set the budget end date. The end date defines when the budget stops tracking usage or the account balance and sending notifications. The end date is the last day of a month. It must be no more than five years from the current date.
   1. Select the users to notify.
   1. For the **Usage cost** and **Amount** payable types, define the budget scope. You can select individual clouds, folders, and services to include in a set budget. By default, data is collected from all the clouds, folders, and services that the selected billing account has access to.
   1. Set at least one utilization threshold to trigger notifications. You can specify a threshold as a percentage or a cash value and select the users to receive notifications. A budget can have multiple thresholds.

   {% note info %}

   Users listed in the **General information** section will receive notifications when each specified threshold is exceeded. Users listed when setting a threshold will only receive a notification when a specific threshold is reached.

   If several budget thresholds are reached at the same time, users will only receive a single notification.

   {% endnote %}

1. After filling in all the fields, click **Create**. This will create a budget.


## See also

* [{#T}](../tutorials/serverless-trigger-budget-vm.md).

