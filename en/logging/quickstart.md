# Getting started with {{ cloud-logging-name }}

In this tutorial, you'll add records to a [log group](./concepts/log-group.md) and then view them.

## Getting started {#before-you-begin}

To get started in {{ yandex-cloud }}:
1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the on-screen instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../billing/concepts/billing-account.md) linked and its status is `ACTIVE` or `TRIAL_ACTIVE`. If you do not have a billing account yet, [create one](../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../resource-manager/operations/folder/create.md).

## Add records to the log group

{% include [write-logs](../_includes/logging/write-logs.md) %}

## View the records

{% include [read-logs](../_includes/logging/read-logs.md) %}
