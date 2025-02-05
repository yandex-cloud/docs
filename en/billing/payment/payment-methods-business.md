# Bank account transfers

Businesses and individual entrepreneurs can top up their personal accounts and pay for consumed resources by transferring funds from their bank accounts.

## Funds transfer and payment against invoice {#transaction}

To transfer funds, you should first get a [payment invoice](../concepts/bill.md). You can pay it at any bank or through an online banking system.<br/>Before making a transfer, make sure the following details in the payment order are entered correctly:

* Payment amount.
* Banking details of Yandex.Cloud LLC (Russia and Belarus), Cloud Services Kazakhstan LLP (Kazakhstan), Iron Hive doo Beograd (Serbia) (for non-residents of Russia and Kazakhstan), or Direct Cursus Technology L.L.C. (Dubai) (for non-resients of Russia and Kazakhstan).

  {% include [legal-entity-nonresidents](../../_includes/billing/legal-entity-nonresidents.md) %}

* Your company or individual entrepreneur TIN.
* [Account number](../concepts/personal-account.md#id) in the payment purpose.
* [Agreement number](../concepts/contract.md) in the payment purpose.

{% include [payment-bill-note](../_includes/payment-bill-note.md) %}


## Payment terms {#limits}

Invoices must be paid before the deadline set out in the agreement. How fast the funds will be credited to your personal account depends on the bank performing the transaction.

The due date for payments is specified in Chapter 6 (Payment Procedure) of the [agreement](../concepts/contract.md) or in a monthly [report](../concepts/act.md#report-of-completion) that we send to our clients.

{% note info %}

We recommend that you keep track of the money you spend from your personal account and [maintain a positive balance at all times](../operations/pay-the-bill.md). If the personal account balance drops to zero, {{ yandex-cloud }} reserves the right to change the status of your billing account to [PAYMENT_REQUIRED](../concepts/billing-account-statuses.md#conditions). For more information, see [Billing cycle](../payment/billing-cycle-business.md).

{% endnote %}
