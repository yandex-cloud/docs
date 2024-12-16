# Payment invoice

A payment invoice is a document issued for you to pay for the resources consumed. A payment invoice is issued in your [billing account](billing-account.md) and contains aggregate data on all the services used within a single cloud.


The relationship between the payment invoice, billing account, and cloud is shown in the diagram below.

![image](../../_assets/billing/1-1-cloud.png)


## Issuing a payment invoice {#agregate}

A payment invoice is generated automatically and issued at the beginning of the following reporting period under the conditions below:
* The selected payment method is [Transfer from bank account](../payment/payment-methods-business.md).
* [Total invoice amount](#payment-amount) is greater than zero.

Payment invoices are sent only to the email address of the user who created the [billing account](billing-account.md). You cannot change the email address, but you can configure message forwarding. For more information, see [Yandex Mail Help](https://yandex.com/support/mail/web/preferences/filters/forwarding.html).

{% note info %}

{{ yandex-cloud }} reserves the right to issue a payment invoice during the current reporting period if you exceed your established billing threshold.

{% endnote %}


Customers qualifying as a business and not using a linked corporate bank card to top up their account must [generate a payment invoice](../operations/pay-the-bill.md#legal-entities) using the management console. Depending on which company you signed the agreement with, you can find more details in _Yandex Legal documents_ for [Iron Hive doo Beograd (Serbia)](https://yandex.com/legal/cloud_customer_agreement/) or [Direct Cursus Technology L.L.C. (Dubai)](https://yandex.com/legal/cloud_customer_agreement_uae/).


A payment invoice is not a primary accounting document. There are no special legal requirements for drafting this document. In accounting, correct charges for services are made based on reports and tax invoices where all the required details are specified. A payment invoice is generated automatically and there is no way to change customer data.

## Payment invoice amount {#payment-amount}

{% include [bill-amount](../_includes/bill-amount.md) %}


![image](../../_assets/billing/formula.png)

{% list tabs %}



{% endlist %}


## Making payment {#payment}

Invoices must be paid before the deadline set out in the [agreement](../concepts/contract.md). Payment is made by bank transfer. For more information, see [Payment methods for businesses](../payment/payment-methods-business.md).

{% include [payment-bill-note](../_includes/payment-bill-note.md) %}

## Payment invoice details {#parameters}

{% include [bill-requisites](../_includes/bill-requisites.md) %}


## Taxes and fees {#nds}

{% include [nds](../_includes/nds.md) %}
