# Transfer from your bank account

Businesses can top up their personal accounts and pay for consumed resources by transferring funds from their bank accounts.

## Funds transfer and payment against invoice{#transaction}

To have funds transferred, you should first receive a [payment invoice](../concepts/bill.md). You can pay it at any bank or through an online banking system.
<br/>Before making a transfer, make sure the following details in the payment order are entered correctly:

   - Payment amount
   - Bank details of {{ yandex-cloud }} LLC
   - Your company's TIN or sole proprietor's TIN
   - [Personal account number](../concepts/personal-account.md#id) in the Details of Payment field
   - [Contract number](../concepts/contract.md) in the Details of Payment field

{% include [payment-bill-note](../_includes/payment-bill-note.md) %}

## Payment terms {#limits}

Invoices must be paid before the deadline stipulated in the [agreement](../concepts/contract.md). How fast the funds will be credited to your personal account depends on the bank performing the transaction.

{% note info %}

We recommend that you track spending on your personal account and [top up the balance so that it is always positive](../operations/pay-the-bill.md). If the personal account balance drops to zero or exceeds the maximum amount of the billing threshold, {{ yandex-cloud }} reserves the right to change the status of your billing account to [PAYMENT_REQUIRED](../concepts/billing-account-statuses.md#conditions). For more information, see [Billing cycle](../payment/billing-cycle-business.md).

{% endnote %}
