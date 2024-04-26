# Monitor expenses


The guide in this checklist item will help you activate the paid version and set up payment for resources in your organization.

## Activate the paid version {#pay-activate}

1. In [{{ billing-name }}]({{ link-console-billing }}) on the **{{ ui-key.yacloud.billing.label_accounts }}** page, select the billing account.
1. On the **{{ ui-key.yacloud.billing.account.switch_overview }}** page, click **{{ ui-key.yacloud.billing.account.button_billing-payment-action }}**.
1. Confirm the action by clicking **{{ ui-key.yacloud.billing.account.button_billing-payment-action }}** again.

Upon activation of the paid version, your [personal account balance](../../billing/concepts/personal-account.md#balance) will be zero by default. We recommend monitoring and [topping up](../../billing/operations/pay-the-bill.md) your account so it is always positive.
<br/>If you fail to top up your account on time and run into arrears, your use of {{ yandex-cloud }} services may be suspended. For more information, see [Billing cycle](../../billing/payment/billing-cycle-business.md).

## Top up your personal account {#pay-personal-account}

{% include [personal-account-balance](../../billing/_includes/personal-account-balance.md) %}

To top up your personal account:
1. In [{{ billing-name }}]({{ link-console-billing }}) on the **{{ ui-key.yacloud.billing.label_accounts }}** page, select the billing account.
1. Click **{{ ui-key.yacloud.billing.account.dashboard-overview.button_refill }}**.
1. Select a payment method:

{% list tabs group=payments %}

- Bank card {#card}

   Enter the payment amount and click **{{ ui-key.yacloud.billing.account.dashboard-overview.popup-refill_button_individual-action }}**. Then enter your card details and click **Pay**. We accept  Visa and MasterCard.

   Your payment will be processed in real time and completed within 15 minutes.

- Bank transfer {#transfer}

   Enter the payment amount and click **{{ ui-key.yacloud.billing.account.dashboard-overview.popup-refill_button_company-action }}**.

   The system will generate a payment invoice. Print the invoice and use it to make a payment in a bank or using a banking client system.

   Before paying, please make sure the following is correct in your payment order:
   * Payment amount.
   * Banking information of Yandex.Cloud LLC (Russia), Cloud Services Kazakhstan LLP (Kazakhstan), and SAG (for non-residents of Russia and Kazakhstan).
   * Your company or individual entrepreneur TIN.
   * [Personal account number](../../billing/concepts/personal-account.md#id) in the payment details.
   * [Contract number](../../billing/concepts/contract.md) in the payment details.

   How fast the funds will be credited to your personal account depends on the bank performing the transaction.

   {% include [payment-bill-note](../../billing/_includes/payment-bill-note.md) %}

{% endlist %}

## Configure notifications {#set-notif}

To manage costs in {{ yandex-cloud }}, configure notifications using [budgets](../../billing/concepts/budget.md).

Available budget types:
* _{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}_: Notification is sent when the cost of resources, without discounts applied, exceeds a specified usage limit.
* _{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}_: Notification is sent when the cost of resources, with discounts and active promo codes applied, exceeds a specified usage limit.
* _{{ ui-key.yacloud.billing.account.budgets.label_type-balance }}_: Notification is sent when the personal account balance falls below a specified threshold.

{% note info %}

You can create a trigger that will invoke a [function](../../functions/concepts/function.md) in {{ sf-name }} or run a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when threshold values are exceeded. Read more about [triggers for budgets](../../functions/operations/trigger/budget-trigger-create.md).

{% endnote %}

## Create a budget {#create-budget}

1. In [{{ billing-name }}]({{ link-console-billing }}) on the **{{ ui-key.yacloud.billing.label_accounts }}** page, select the billing account.
1. Go to the **{{ ui-key.yacloud.billing.account.budgets.label_budgets }}** page and click **{{ ui-key.yacloud.billing.account.budgets.button_create }}**.
   1. Enter the budget name.
   1. Select **{{ ui-key.yacloud.billing.account.budgets.label_type }}**.
   1. Set **Budget amount**:
      * For the **{{ ui-key.yacloud.billing.account.budgets.label_type-cost }}** or **{{ ui-key.yacloud.billing.account.budgets.label_type-expense }}** type, specify the total usage cost.
      * For the **{{ ui-key.yacloud.billing.account.budgets.label_type-balance }}** type, specify the account balance.
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

## Monitor your payment history {#control-pay}

You can view the full history of payments to your [personal account](../../billing/concepts/personal-account.md#balance) on the **{{ ui-key.yacloud.billing.account.switch_history }}** page or in Yandex Balance. The tracking method depends on your legal status ([billing account type](../../billing/concepts/billing-account.md#ba-types)).

Businesses and individual entrepreneurs can track their full payment history in Yandex Balance on the [Invoices](https://balance.yandex.ru/invoices.xml) page.