# Billing accounts


Billing accounts are used to identify users paying for resources in {{ yandex-cloud }}.

A billing account can be linked to multiple clouds and one [personal account](personal-account.md). You can only use the payment method that corresponds to the type of billing account and your [agreement](contract.md).

The relationship between clouds, billing accounts, personal accounts, and payment methods is shown in the diagram below.

![image](../../_assets/billing/cloud-billing-account-svg.svg)

{% note info %}

A billing account is not used for managing {{ yandex-cloud }} resources.

{% endnote %}

To go to the list of billing accounts:

{% list tabs %}

- Management console

   1. Open the {{ yandex-cloud }} [management console]({{ link-console-main }}).
   1. In the upper-left corner, click ![image](../../_assets/main-menu.svg) **All services**.
   1. Select ![image](../../_assets/billing.svg) [**Billing**]({{ link-console-billing }}).

{% endlist %}

## Billing account types {#ba-types}

{% list tabs %}

- Individual account

   * Intended for residents of Russia or Kazakhstan.
   * Resources are paid for using a [bank card](../payment/payment-methods-individual.md).
   * Funds for the resources consumed are debited automatically. For more information, see [Billing cycle for individuals](../payment/billing-cycle-individual.md).


- Business account

   * Intended for residents and non-residents of Russia and Kazakhstan.
   * Consumed resources are paid for by bank transfer from the [business's bank account](../payment/payment-methods-business.md) or a [corporate bank card](../payment/payment-methods-card-business.md).
   * Payments for resources consumed are made based on the [agreement](../concepts/contract.md) and [bank invoice](bill.md), or the amount is debited automatically from the linked bank card. For more information, see [Billing cycle for businesses](../payment/billing-cycle-business.md).
   * A statement of the services rendered (for residents of Russia and Kazakhstan) and an invoice (Russian residents only) are sent to your email address at the beginning of the next billing cycle. Invoices for residents of the Republic of Kazakhstan are generated electronically. For more information, see [Reporting documents](../payment/documents.md).

{% endlist %}

## Effective term {#dates}

Billing accounts do not expire.

However, if {{ yandex-cloud }} services are suspended for non-payment, and you have not paid the outstanding amount within 30 days of the suspension, all your data, including the billing account, will be permanently locked and deleted.

You can [delete a billing account](../operations/delete-account.md) if you no longer plan to use {{ yandex-cloud }} services.

## Number of billing accounts {#restrictions}

{% include [billing-account-amounts](../_includes/billing-account-amounts.md) %}

{% include [pin-cloud-note](../_includes/pin-cloud-note.md) %}

{% include [billing-account-payers](../_includes/billing-account-payers.md) %}

{% include [billing-account-payers-example](../_includes/billing-account-payers-example.md) %}


