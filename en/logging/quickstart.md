# Getting started with {{ cloud-logging-name }}

In this tutorial, you'll add records to a [log group](./concepts/log-group.md) and then view them.

## Before you begin {#before-you-begin}

To get started in {{ yandex-cloud }}:
1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../resource-manager/operations/folder/create.md).

## Add records to a log group

{% include [write-logs](../_includes/logging/write-logs.md) %}

## View the records

{% include [read-logs](../_includes/logging/read-logs.md) %}
