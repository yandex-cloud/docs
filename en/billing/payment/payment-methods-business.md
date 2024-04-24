# Bank account transfers

Businesses and individual entrepreneurs can top up their personal accounts and pay for consumed resources by transferring funds from their bank accounts.

## Funds transfer and payment against invoice {#transaction}

To have funds transferred, you should first receive a [payment invoice](../concepts/bill.md). You can pay it at any bank or through an online banking system.<br/>Before making a transfer, make sure the following details in the payment order are entered correctly:


* Payment amount.
* Banking information of Yandex.Cloud LLC (Russia and Belarus), Yandex.Cloud Kazakhstan LLP (Kazakhstan), and Iron Hive doo Beograd (Serbia) (for non-residents of Russia and Kazakhstan).
* Your company or individual entrepreneur TIN.
* [Personal account number](../concepts/personal-account.md#id) in the payment details.
* [Contract number](../concepts/contract.md) in the payment details.

{% include [payment-bill-note](../_includes/payment-bill-note.md) %}



## Payment terms {#limits}

Payment invoices must be paid before the deadline stipulated in the [agreement](../concepts/contract.md). How fast the funds will be credited to your personal account depends on the bank performing the transaction.


{% note info %}

We recommend that you track spending on your personal account and [top up the balance so that it is always positive](../operations/pay-the-bill.md). If the personal account balance drops to zero or exceeds the billing threshold, {{ yandex-cloud }} reserves the right to change the status of your billing account to [PAYMENT_REQUIRED](../concepts/billing-account-statuses.md#conditions). For more information, see [Billing cycle](../payment/billing-cycle-business.md).

{% endnote %}


