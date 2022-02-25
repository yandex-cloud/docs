---
sourcePath: en/ydb/overlay/quickstart/create-db.md
---
# Creating a database

Create a [database](../concepts/databases.md#database) using {{ ydb-full-name }} from the {{ yandex-cloud }} management console.

## Before you start {#before-you-begin}

To get started in {{ yandex-cloud }}:

1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
1. [On the billing page]({{ link-console-billing }}) make sure that you have enabled a [billing account](../../billing/concepts/billing-account.md) and that it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you don't have a folder, [create one](../../resource-manager/operations/folder/create.md).

## Create a database {#control-plane}

You can create a database in a Serverless configuration or with dedicated servers. For more information about differences in configurations, see [Serverless and Dedicated modes](../concepts/serverless_and_dedicated.md).

{% note info %}

For the Amazon DynamoDB-compatible mode, use a serverless database configuration.

{% endnote %}

{% include [create-db-via-console](../_includes/create-db-via-console.md) %}
