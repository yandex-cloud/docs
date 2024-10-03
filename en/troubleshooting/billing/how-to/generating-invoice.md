# How to generate a payment invoice


## Issue description {#case-description}

* You need to generate a payment invoice for the previous reporting period of your Yandex Cloud usage.

## Solution {#case-resolution}

The invoice is automatically sent at the end of the month to the billing account owner's email address, specified by the owner in the [Management console settings](https://console.cloud.yandex.ru/settings).

You can also generate a bill yourself in the "Billing" section.
To top up your account balance, use [this guide](../../../billing/operations/pay-the-bill#legal-entities.md).

{% note info %}

To generate payment invoices, assign your IAM account the roles of `billing.accounts.editor` or `billing.accounts.admin`.
For more details on how to do this, see this [documentation section](../../../billing/security/index.md#role-list).

{% endnote %}

How fast the funds will be credited to your personal account depends on the bank performing the transaction.
Original closing documents are automatically sent by Russian Post on the 5-7th working day following the reporting period (from the 1st to the 30th or 31st day of the month).
Closing documents are CCed to the email address of the billing account owner.

You can also download closing documents in the Management console using [this guide](../../../billing/operations/download-reporting-docs.md).

## If nothing helped {#if-issue-still-persists}

If you were unable to issue a payment invoice using these recommendations, [create a request for technical support()]({{ link-console-support }}).
When creating the request, make sure to specify:


1. The ID of the billing account or of the cloud for which you need to get a payment invoice or closing documents.
   You can find this ID on the [page with billing account details]({{ link-console-support }}).

2. Detailed description of the task.
