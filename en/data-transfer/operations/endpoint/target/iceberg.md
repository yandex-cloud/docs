---
title: How to set up a {{ IBRG }} target endpoint in {{ data-transfer-full-name }}
description: In this tutorial, you will learn how to set up a {{ IBRG }} target endpoint in {{ data-transfer-full-name }}.
---

# Transferring data to a {{ IBRG }} target endpoint


{{ data-transfer-full-name }} enables you to migrate data to {{ IBRG }} tables in a {{ metastore-full-name }} cluster and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform the required operations with the tables and [see how the transfer is going](../../monitoring.md).

## Scenarios for transferring data to {{ IBRG }} {#scenarios}

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ CH }}](../source/clickhouse.md)
* [{{ GP }}](../source/greenplum.md)
* [{{ MG }}](../source/mongodb.md)
* [{{ MY }}](../source/mysql.md)
* [{{ PG }}](../source/postgresql.md)
* [{{ ES }}](../source/elasticsearch.md)
* [{{ objstorage-full-name }}](../source/object-storage.md)
* [Oracle](../source/oracle.md)
* [{{ ydb-name }}](../source/ydb.md)
* [{{ ytsaurus-name }}](../source/yt.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

## Configuring the {{ IBRG }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [Settings for connecting to a {{ metastore-name }} cluster](#managed-service).
* [Configuration settings](#bucket-config) for an {{ objstorage-full-name }} bucket or custom S3-compatible storage.
* [Additional parameters](#additional-settings).

### {{ metastore-name }} cluster {#managed-service}


{% note warning %}

To create or edit an endpoint of a managed database, you will need the [`{{ roles.metastore.viewer }}`](../../../../metadata-hub/security/metastore-roles.md#managed-metastore-viewer) role or the primitive [`viewer`](../../../../iam/roles-reference.md#viewer) role for the folder the cluster of this managed database resides in.

{% endnote %}


Connection with the cluster specified in {{ yandex-cloud }}.

{% list tabs group=instructions %}

- Management console {#console}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergTarget.mdb_cluster_id.title }}**: ID of the cluster whose folder is used for {{ IBRG }} tables.

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergTarget.security_group_ids.title }}**: Select the cloud network to host the endpoint and security groups for network traffic. This will allow you to apply the specified security group rules to the VMs and clusters in the selected network without changing their settings. For more information, see [{#T}](../../../concepts/network.md).

      Make sure the selected security groups are [configured](../../../../metadata-hub/operations/metastore/configure-security-group.md).


{% endlist %}

### Bucket configurations {#bucket-config}

{% list tabs group=instructions %}

- {{ objstorage-full-name }} bucket {#obj-storage}

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergObjectStorageConnectionSettings.bucket.title }}**: Name of the [bucket](../../../../storage/concepts/bucket.md) to upload source data to.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergObjectStorageConnectionSettings.service_account_id.title }}**: Select or create a [service account](../../../../iam/concepts/users/service-accounts.md) with the `storage.uploader` role that {{ data-transfer-name }} will use to connect to the bucket.


- Custom S3-compatible storage {#s3-storage}

    * (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.endpoint.title }}**: Endpoint for an Amazon S3-compatible service. Leave this field empty to use Amazon.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.region.title }}**: Region to send requests.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.bucket.title }}**: Bucket name.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.access_key_id.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergManualConnectionSettings.secret_access_key.title }}**: [ID and contents of the AWS key](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) used to access a private bucket.

{% endlist %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergTarget.prefix.title }}**: Path prefix for writing objects to the bucket. This is optional.

### Additional settings {#additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergTarget.cleanup_policy.title }}**: Select a way to clean up data in the target database before the transfer:

     * `{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergCleanupPolicy.ICEBERG_CLEANUP_POLICY_DISABLED.title }}`: Use the existing tables to write new data.

     * `{{ ui-key.yc-data-transfer.data-transfer.console.form.iceberg.console.form.iceberg.IcebergCleanupPolicy.ICEBERG_CLEANUP_POLICY_DROP.title }}`: Remove all tables involved in the transfer.

       Use this option to always transfer the latest version of the table schema to the target database from the source whenever the transfer is activated.

{% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).
