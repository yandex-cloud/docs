# How to generate a payment invoice



## Issue description {#case-description}

You need to generate a payment invoice for the previous reporting period of your {{ yandex-cloud }} usage.

## Solution {#case-resolution}

The invoice is automatically sent at the end of the month to the billing account owner's email address, specified by the owner in the [management console settings]({{ link-console-settings }}).

You can also generate an invoice yourself [in the **{{ ui-key.yacloud_billing.billing.label_service }}** section]({{ link-console-billing }}). To top up your account balance, use [this guide](../../../billing/operations/pay-the-bill#legal-entities.md).

{% note info %}

To generate payment invoices, assign the `billing.accounts.editor` or `billing.accounts.admin` role to your IAM account. To learn how to do this, see [this guide](../../../billing/security/index.md#role-list).

{% endnote %}

How fast the funds will be credited to your personal account depends on the bank performing the transaction. Original closing documents are automatically sent by Russian Post on the 5th to 7th business day following the reporting period (from the 1st to the 30th or 31st day of the month).

Closing documents are CC’d to the email address of the billing account owner.

You can also download closing documents in the [management console]({{ link-console-main }}) using [this guide](../../../billing/operations/download-reporting-docs.md).

## If nothing helped {#if-nothing-worked}

If you are still unable to issue a payment invoice, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. ID of the billing account or of the cloud for which you need to get a payment invoice or closing documents. You can find this ID on the [page with the billing account details]({{ link-console-billing }}).
1. Detailed description of what you need to do.
