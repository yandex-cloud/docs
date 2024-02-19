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

* On the first day of each month, a report for services rendered for the previous month is generated. If your billing account is at a deficit at that point, the unpaid amount will turn into [arrears](#debt).

{% note tip %}

We recommend [topping up your balance](#card) at the end of the month in advance so that it becomes positive.

{% endnote %}


## Arrears {#debt}

Arrears appear on the billing account if the balance was negative at the end of the previous month.

* To keep access to {{ tracker-name }}, pay off the arrears by the 15th of the current month.

* If the arrears are unpaid when due, {{ tracker-name }} will switch to [read only](access.md#readonly) mode. In this case, to regain full access to the service, top up your balance to a positive value within 45 days. This requires paying off the previous period's arrears and pre-paying for the current month.

* If the arrears are not paid within two months, the billing account will be permanently suspended. In this case, to continue using {{ tracker-name }}, contact technical support to link a new billing account to {{ tracker-name }}.


## Check your account balance {#balance}

To check your account balance:

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

1. Select your billing account on the **{{ ui-key.yacloud.billing.switch_accounts }}** page.

   Go to the **{{ ui-key.yacloud.billing.account.switch_dashboard }}** page and you will see your current balance under the account name.

## Top up your account with a bank card {#card}

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

1. Select your billing account on the **{{ ui-key.yacloud.billing.switch_accounts }}** page.

1. Click **{{ ui-key.startrek.ui_components_page-admin_BillingAccountInfo.refill-balance }}** in the section with the account name.

1. Enter your payment amount and click **{{ ui-key.startrek.ui_components_page-admin_BillingAccountInfo.refill-balance }}** again.

## Top up your account via bank transfer {#transfer}

1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

1. Select your billing account on the **{{ ui-key.yacloud.billing.accounts.label_title }}** page.

1. Click **{{ ui-key.startrek.ui_components_page-admin_BillingAccountInfo.refill-balance }}** in the section with the account name.

1. Enter the payment amount and click **{{ ui-key.startrek.ui_components_page-admin_BillingAccountInfo.refill-dialog-ok-issue }}**. The system will generate a payment invoice.

1. Print the invoice and use it to make a payment in a bank or using a banking client system.

## View your payment history {#history}

You can view the full history of payments to your billing account on the **{{ ui-key.yacloud.billing.account.switch_history }}** page or in Yandex&#160;Balance. The payer type affects how the deposit history is tracked.

{% list tabs group=customers %}

- Businesses and individual entrepreneurs {#businesses}

   Organizations and individual entrepreneurs can track their full deposit history in Yandex Balance on the [Invoices]({{ link-balance-invoices }}) page.

- Individuals {#individuals}

   1. On the top panel in {{ tracker-name }}, click ![](../_assets/tracker/tracker-burger.png) → **Billing**.

   1. Select your billing account on the **{{ ui-key.yacloud.billing.switch_accounts }}** page.

   1. In the left-hand panel, select **{{ ui-key.yacloud.billing.account.switch_history }}**.

{% endlist %}