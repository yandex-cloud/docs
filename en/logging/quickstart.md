# Getting started with {{ cloud-logging-name }}

In this tutorial, you'll add records to a [log group](./concepts/log-group.md) and then view them.

## Getting started {#before-you-begin}

To get started in {{ yandex-cloud }}:
1. Log in to the [management console]({{ link-console-main }}). If you do not yet have an account, go to the management console and follow the instructions.
1. On the [**Billing**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have any folder, [create one](../resource-manager/operations/folder/create.md).

## Add records to a log group

{% include [write-logs](../_includes/logging/write-logs.md) %}

## View the records

{% include [read-logs](../_includes/logging/read-logs.md) %}
