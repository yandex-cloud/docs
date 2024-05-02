# Monitor expenses


This checklist item will guide you through setting up your organization's payments for resources.

After you are done creating a billing account, your [personal account balance](../../billing/concepts/personal-account.md#balance) will be zero by default. We recommend monitoring and [topping up](../../billing/operations/pay-the-bill.md) your account balance so that it always stays positive.
<br/>If you fail to top up your account on time and run into arrears, your use of {{ yandex-cloud }} services may be suspended. For more information, see [Billing cycle](../../billing/payment/billing-cycle-individual.md).

## Top up your personal account {#pay-personal-account}

{% include [personal-account-balance](../../billing/_includes/personal-account-balance.md) %}

1. In [{{ billing-name }}]({{ link-console-billing }}) under **{{ ui-key.yacloud_billing.billing.title_accounts }}**, select the billing account.
1. Click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.button_refill }}**.
1. Enter the payment amount and click **{{ ui-key.yacloud_billing.billing.account.dashboard-overview.popup-refill_button_individual-action }}**.
1. Enter your card details and click **Pay**. We accept Visa and MasterCard.

Your payment will be processed in real time and completed within 15 minutes.

## Configure notifications {#set-notif}

To manage costs in {{ yandex-cloud }}, configure notifications using [budgets](../../billing/concepts/budget.md).

Available budget types:
* _{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}_: Notification is sent when the cost of resources, without discounts applied, exceeds a specified usage limit.
* _{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}_: Notification is sent when the cost of resources, with discounts and active promo codes applied, exceeds a specified usage limit.
* _{{ ui-key.yacloud_billing.billing.account.budgets.label_type-balance }}_: Notification is sent when the personal account balance falls below a specified threshold.

{% note info %}

You can create a trigger that will invoke a [function](../../functions/concepts/function.md) in {{ sf-name }} or run a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when threshold values are exceeded. Read more about [triggers for budgets](../../functions/operations/trigger/budget-trigger-create.md).

{% endnote %}

## Create a budget {#create-budget}

1. In [{{ billing-name }}]({{ link-console-billing }}) under **{{ ui-key.yacloud_billing.billing.title_accounts }}**, select the billing account.
1. Go to the **{{ ui-key.yacloud_billing.billing.account.budgets.label_budgets }}** page and click **{{ ui-key.yacloud_billing.billing.account.budgets.button_create }}**.

   1. Enter the budget name.
   1. Select **{{ ui-key.yacloud_billing.billing.account.budgets.label_type }}**.
   1. Set **Budget amount**:

      * For the **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}** or **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}** type, specify the total usage cost.
      * For the **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-balance }}** type, specify the account balance.

   1. For the **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}** and **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}** types, select a budget tracking period:
      * If you selected **{{ ui-key.yacloud_billing.billing.account.budgets.reset-period_value_custom }}** as the tracking period type, set the budget start date. The start date is the first day of the month.
      * Set the budget end date. The end date defines when the budget stops tracking usage or the account balance and sending notifications. The end date is the last day of the month. It must be within five years of the current date.
   1. Select the users to notify.
   1. For the **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-cost }}** and **{{ ui-key.yacloud_billing.billing.account.budgets.label_type-expense }}** types, define the budget scope. You can select individual clouds, folders, and services to include in a set budget. By default, data is collected from all the clouds, folders, and services that the selected billing account has access to.
   1. Set at least one utilization threshold to trigger notifications. You can specify a threshold as a percentage or a cash value and select the users to receive notifications. A budget can have multiple thresholds.

   {% note info %}

   Users listed in the **{{ ui-key.yacloud.common.section-base }}** section will receive notifications when each specified threshold is exceeded. Users listed when setting a threshold will only receive a notification when that specific threshold is reached.

   If several budget thresholds are reached at the same time, users will receive a single notification.

   {% endnote %}

1. After filling in all the fields, click **{{ ui-key.yacloud.common.create }}**. This will create a budget.

## Monitor your payment history {#control-pay}

You can view the full history of payments to your [personal account](../../billing/concepts/personal-account.md#balance) on the **{{ ui-key.yacloud_billing.billing.account.switch_history }}** page or in [Yandex Balance](https://yandex.ru/support/balance/operations/find-bill.html). The tracking method depends on your legal status ([billing account type](../../billing/concepts/billing-account.md#ba-types)).
Payment receipt information is generated by Yandex Balance (to learn more, see the [Yandex Balance documentation](https://yandex.ru/support/balance/concepts/receipts.html)).

Individuals can view the full history of payments on the **{{ ui-key.yacloud_billing.billing.account.switch_history }}** page.
<br/>All payments are arranged chronologically with the earliest payment displayed at the very bottom.
<br/>To filter the payments, set the date range. The results will be shown in a table.

| Name | Description |
----- | -----
| {{ ui-key.yacloud_billing.billing.account.history.column_description }} | Payment details. |
| {{ ui-key.yacloud_billing.billing.account.history.column_date }} | Date when funds were credited to the personal account. |
| {{ ui-key.yacloud_billing.billing.account.history.column_status }} | Payment status. |
| {{ ui-key.yacloud_billing.billing.account.history.column_money }} | Amount actually credited to the personal account, in rubles. |

<br/>The payment history contains aggregate data on all services. Detailed information about the services rendered is available on the [Usage details](../../billing/operations/check-charges.md) page.