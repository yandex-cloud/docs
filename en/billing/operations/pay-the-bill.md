# Top up your personal account

{% include [personal-account-balance](../_includes/personal-account-balance.md) %}

The method for topping up your personal account depends on your legal status.

{% note info %}

You cannot use [grants](../concepts/bonus-account.md) to top up your personal account.

{% endnote %}

## Individuals {#individuals}

To top up your personal account:
1. In the top left-hand corner of the [management console]({{ link-console-billing }}), click ![image](../../_assets/main-menu.svg) and select **Billing**.
1. Select a billing account.
1. Click **Top up account**.
1. Enter a payment amount and click **Top up account**.
1. Enter your card information and click **Pay**.

{% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

Payment is processed in real time and completed within 15 minutes.


## Businesses and individual entrepreneurs {#legal-entities}

To top up your personal account:
1. In the top left-hand corner of the [management console]({{ link-console-billing }}), click ![image](../../_assets/main-menu.svg) and select **Billing**.
1. Select a billing account.
1. Click **Top up account**.
1. Select a payment method:

{% list tabs %}

- Bank card transfer

   Enter a payment amount and click **Top up account**. Then enter your card information and click **Pay**.

   {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

   Payment is processed in real time and completed within 15 minutes.

- Bank transfers (from a bank teller)

   Enter a payment amount and click **Issue bank invoice**.

   The system will generate a payment invoice. Print the invoice and use it to make a payment in a bank or using a banking client system.

   Before paying, please make sure the following is correct in your payment order:
   * Payment amount.
   * Banking information of {{ yandex-cloud }} LLC (Russian Federation), {{ yandex-cloud }} Kazakhstan LLP (Republic of Kazakhstan), SAG (outside the Russian Federation and the Republic of Kazakhstan).
   * Your company TIN or sole proprietor TIN.
   * [Personal account number](../concepts/personal-account.md#id) in the payment details.
   * [Contract number](../concepts/contract.md) in the payment details.

   The amount of time required for the funds to be credited depends on the bank carrying out the transaction.

   {% include [payment-bill-note](../_includes/payment-bill-note.md) %}

{% endlist %}
