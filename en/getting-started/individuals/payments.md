# Monitor expenses

The guide in this checklist item will help you activate the paid version and set up payment for resources in your organization.

## Activate the paid version {#pay-activate}

1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.
2. Select an account on the **Accounts** page.
3. On the **Overview** page, click **Upgrade to the paid version**.
4. Confirm the action by clicking **Upgrade to the paid version** again.

Once you activate the paid version, your [personal account balance](../../billing/concepts/personal-account.md#balance) is set to zero by default. We recommend monitoring and [topping up](../../billing/operations/pay-the-bill.md) your personal account balance so that it is always positive.
<br/>If you fail to top up your account balance on time and incur arrears, your {{ yandex-cloud }} account may be suspended. For more information, see [Billing cycle](../../billing/payment/billing-cycle-individual.md).

## Top up your personal account {#pay-personal-account}

{% include [personal-account-balance](../../billing/_includes/personal-account-balance.md) %}

1. In the top left corner of the [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) and select **Billing**.
1. Select a billing account.
1. Click **Top up account**.
1. Enter your payment amount and click **Top up account**.
1. Enter your card details and click **Pay**. Visa, MasterCard, and MIR bank cards are accepted.

Payment is processed in real time and completed within 15 minutes.

## Configure notifications {#set-notif}

To manage costs in {{ yandex-cloud }}, configure notifications using [budgets](../../billing/concepts/budget.md).

Available budget types:
* _Usage cost_: A notification goes out when the cost of resources with no discounts applied exceeds an established usage limit.
* _Amount payable_: A notification goes out when the cost of resources, including discounts and active promo codes, exceeds an established usage limit.
* _Account balance_: A notification goes out when a personal account balance falls below an established threshold.

{% note info %}

You can create a trigger that will invoke a [function](../../functions/concepts/function.md) in {{ sf-name }} or run a [container](../../serverless-containers/concepts/container.md) in {{ serverless-containers-name }} when threshold values are exceeded. Read more about [triggers for budgets](../../functions/operations/trigger/budget-trigger-create.md).

{% endnote %}

## Create a budget {#create-budget}

1. In the [management console]({{ link-console-billing }}), click ![image](../../_assets/ugly-sandwich.svg) and go to **Billing**.

1. Select an account on the **Accounts** page.

1. Go to the **Budgets** page and click **Create budget**.

   1. Enter the budget name.
   1. Select **Budget type**.
   1. Set **Budget amount**:
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

## Monitor your payment history {#control-pay}

You can view the full history of payments to your [personal account](../../billing/concepts/personal-account.md#balance) either on the **Payment history** page or in the Yandex Balance service. The tracking method depends on your legal status ([billing account type](../../billing/concepts/billing-account.md#ba-types)).

Individuals can view the full history of payments on the page **Payment history**.
<br/>All payments are arranged chronologically with the earliest payment displayed at the very bottom.
<br/>To filter the payments, set the date range. The results will be shown in a table.

  Name | Description
  ----- | -----
  Description | Payment details.
  Payment date | Date when funds were credited to the personal account balance.
  Status | Payment status.
  Payment amount | The amount actually credited to the  personal account balance, in rubles.

<br/>The payment history contains aggregate data on all services. Detailed information about the services rendered is available on the [Usage details](../../billing/operations/check-charges.md) page.