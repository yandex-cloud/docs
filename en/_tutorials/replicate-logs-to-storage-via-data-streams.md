# Replicating logs to {{ objstorage-name }} using {{ yds-name }}

With [{{ yds-full-name }}](../data-streams/), you can set up automatic replication of service and user application logs to [{{ objstorage-full-name }}](../storage/).

The solution works as described below:
1. Logs, for example, from a [VM instance](../compute/concepts/vm.md) are sent to a {{ cloud-logging-name }} [log group](../logging/concepts/log-group.md).
1. The log group settings specify the {{ yds-name }} [stream](../data-streams/concepts/glossary.md#stream-concepts) where the logs are transmitted automatically.
1. A {{ data-transfer-name }} [transfer](../data-transfer/concepts/#transfer) is set up to fetch data from the stream and save it to an {{ objstorage-name }} [bucket](../storage/concepts/bucket.md).

To set up log replication:

1. [Prepare your cloud](#before-you-begin).
1. [Configure the environment](#prepare-environment).
1. [Create a bucket](#create-bucket).
1. [Create a data stream](#create-stream).
1. [Connect the stream to the log group](#stream-log-connect).
1. [Create a transfer](#create-transfer).
1. [Test sending and receiving data](#check-ingestion).

If you no longer want to store logs, [delete the resources allocated to them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](./_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The cost of data storage support includes:

* Data stream maintenance fees (see [{{ yds-full-name }} pricing](../data-streams/pricing.md)).
* Fees for transmitting data between sources and targets (see [{{ data-transfer-full-name }} pricing](../data-transfer/pricing.md)).
* Data storage fees (see [{{ objstorage-full-name }} pricing](../storage/pricing.md)).

## Configure the environment {#prepare-environment}

1. [Create](../iam/operations/sa/create.md) a service account, for example, `logs-sa`, assigned the `editor` [role](../iam/concepts/access-control/roles.md#editor) for the folder.
1. [Set up](../logging/tutorials/) the transfer of logs to the log group. For example, you can [transfer](../logging/tutorials/vm-fluent-bit-logging.md) logs from a VM instance or [add](../logging/operations/write-logs.md) test records to the log group.

{% include [create-bucket](_tutorials_includes/create-bucket.md) %}

{% include [create-stream](_tutorials_includes/create-stream.md) %}

## Connect the stream to the log group {#stream-log-connect}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select **{{ cloud-logging-name }}**.
   1. Next to the log group where the logs are sent, click ![options](../_assets/options.svg) and select **Edit**.
   1. In the **Stream** field, select the `logs-stream` created before.
   1. Click **Save**.

{% endlist %}

{% include [create-transfer](_tutorials_includes/create-transfer.md) %}

{% include [check-ingestion](_tutorials_includes/check-ingestion.md) %}

## How to delete created resources {#clear-out}

To stop paying for the resources created:

1. [Delete the transfer](../data-transfer/operations/transfer.md#delete).
1. [Delete the endpoints](../data-transfer/operations/endpoint/#delete).
1. [Delete the data stream](../data-streams/operations/manage-streams.md#delete-data-stream).
1. [Delete objects from the bucket](../storage/operations/objects/delete.md).
1. [Delete the bucket](../storage/operations/buckets/delete.md).
