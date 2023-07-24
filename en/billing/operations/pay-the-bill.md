# Top up your personal account

{% include [personal-account-balance](../_includes/personal-account-balance.md) %}

{{ yandex-cloud }} reserves the right to automatically debit funds from the linked card during the current reporting period if your account balance exceeds the established credit limit.

The method for topping up your personal account depends on your legal status.

{% note info %}

A billing cycle runs automatically for [individuals](../payment/billing-cycle-individual.md) as well as [businesses and individual entrepreneurs](../payment/billing-cycle-business.md) if they have a bank card linked to their billing account.

{% endnote %}

## Individuals {#individuals}

To top up your personal account:
1. In the top left corner of the [management console]({{ link-console-billing }}), click ![image](../../_assets/main-menu.svg) and select **Billing**.
1. Select a billing account.
1. Click **Top up account**.
1. Enter your payment amount and click **Top up account**.
1. Enter your card details and click **Pay**.

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

   Enter your payment amount and click **Top up account**. Then enter your card details and click **Pay**.

   {% include [payment-card-types](../../_includes/billing/payment-card-types.md) %}

   Payment is processed in real time and completed within 15 minutes.

- Bank transfer from your account

   Enter your payment amount and click **Issue receipt**.

   The system will generate a payment invoice. Print the invoice and use it to make a payment in a bank or using a banking client system.

   Before paying, please make sure the following is correct in your payment order:
   * Payment amount.
   * Banking information of Yandex.Cloud LLC (Russian Federation), Yandex.Cloud Kazakhstan LLP (Republic of Kazakhstan), SAG (outside the Russian Federation and the Republic of Kazakhstan).
   * Your company or individual entrepreneur TIN.
   * [Personal account number](../concepts/personal-account.md#id) in the payment details.
   * [Contract number](../concepts/contract.md) in the payment details.

   The amount of time required for the funds to be credited depends on the bank carrying out the transaction.

   {% include [payment-bill-note](../_includes/payment-bill-note.md) %}

{% endlist %}
