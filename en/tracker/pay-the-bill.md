# Payments

The billing period in {{ tracker-full-name }} is one calendar month. If 6 or more employees have [full access to {{ tracker-name }}](access.md) for a month, you have to pay for the service for that month. The fee is calculated monthly in accordance with the [{{ tracker-name }} pricing policy](pricing.md).

{% note info %}

{% include [first-month-tarification.md](../_includes/tracker/first-month-tarification.md) %}

{% endnote %}

## Procedure for debiting payments {#charge}

The fees for using {{ tracker-name }} are debited from the balance of the linked [billing account](billing-account.md):

* At the start of each month, a preliminary payment amount is calculated based on the number of users with full access on the first day of the month. This amount is immediately debited from the balance of the billing account.

   {% note info %}

   After the preliminary payment amount is calculated, the balance may become negative, but a negative balance is not considered arrears until the end of the month.

   {% endnote %}

* If an organization starts using paid services during the month and [links a billing account to {{ tracker-name }}](billing-account.md#bind) for the first time, the payment amount will only be calculated for the rest of the month.

* If the number of users with full access increases during the month, the payment amount for the current month will increase as well. If the number of users with full access decreases, the payment amount will not change.

* On the first day of each month, a report for services rendered for the previous month is generated. If the balance of the billing account is negative at this time, the unpaid amount will become an [arrear](#debt).

{% note tip %}

We recommend [topping up your balance](#card) at the end of the month in advance so that it becomes positive.

{% endnote %}


## Arrears {#debt}

Arrears appear on the billing account if the balance was negative at the end of the previous month.

* To keep access to {{ tracker-name }}, pay off the arrears by the 15th of the current month.

* If the arrears are not paid in time, {{ tracker-name }} will switch to [<q>Read only</q>](access.md#readonly) mode. In this case, to regain full access to the service, top up your balance to a positive value within 45 days. This requires paying off the previous period's arrears and pre-paying for the current month.

* If the arrears are not paid within 2 months, the billing account will be permanently blocked. In this case, to continue using {{ tracker-name }}, contact technical support to link a new billing account to {{ tracker-name }}.


## Check your account balance {#balance}

To check your account balance:

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

1. Select your billing account on the **List of accounts** page.

   Go to the **Overview** page and you will see your current balance under the account name.

## Top up your account with a bank card {#card}

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

1. Select your billing account on the **List of accounts** page.

1. Click **Top up balance** in the section with the account name.

1. Enter the payment amount and click **Top up balance** again.

## Top up your account via bank transfer {#transfer}

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

1. Select your billing account on the **List of accounts** page.

1. Click **Top up balance** in the section with the account name.

1. Enter a payment amount and click **Issue receipt**. The system will generate a payment invoice.

1. Print the invoice and use it to make a payment in a bank or using a banking client system.

## View your payment history {#history}

You can view the full deposit history of your billing account on the **Payment history** page or in Yandex Balance. The payer type affects how the deposit history is tracked.

{% list tabs %}

- Legal entities and individual entrepreneurs

   Organizations and individual entrepreneurs can track their full deposit history in Yandex Balance on the [Invoices]({{ link-balance-invoices }}) page.

- For individuals

   1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

   1. Select your billing account on the **List of accounts** page.

   1. Select **Payment history** on the left-hand panel.

{% endlist %}