---
title: Transferring data to a {{ objstorage-full-name }} target endpoint
description: In this tutorial, you will learn how to set up an {{ objstorage-name }} target endpoint.
---

# Transferring data to a {{ objstorage-full-name }} target endpoint

{{ data-transfer-full-name }} enables you to migrate data to the {{ objstorage-full-name }} storage and implement various data transfer, processing, and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Configure one of the supported data sources](#supported-sources).
1. [Configure the target endpoint](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the storage and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](../../../../data-transfer/troubleshooting/index.md) to resolve them.

## Scenarios for transferring data to {{ objstorage-full-name }} {#scenarios}

1. {% include [queue](../../../../_includes/data-transfer/scenario-captions/queue.md) %}
    
    * [Delivering data from {{ DS }} to {{ objstorage-name }}](../../../tutorials/yds-to-objstorage.md).   

1. {% include [data-mart](../../../../_includes/data-transfer/scenario-captions/storage.md) %}
    
    * [Loading data from {{ MY }} to {{ objstorage-name }}](../../../tutorials/mmy-objs-migration.md).
    * [Loading data from {{ PG }} to {{ objstorage-name }}](../../../tutorials/mpg-to-objstorage.md).
    * [Loading data from {{ OS }} to {{ objstorage-name }}](../../../tutorials/opensearch-to-object-storage.md).
    * [Loading data from {{ ydb-name }} to {{ objstorage-name }}](../../../tutorials/ydb-to-object-storage.md).

For a detailed description of possible {{ data-transfer-full-name }} scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the data source {#supported-sources}

Configure one of the supported data sources:

* [{{ PG }}](../source/postgresql.md)
* [{{ MY }}](../source/mysql.md)
* [{{ MG }}](../source/mongodb.md)
* [{{ KF }}](../source/kafka.md)
* [{{ AB }}](../../../transfer-matrix.md#airbyte)
* [{{ DS }}](../source/data-streams.md)
* [Oracle](../source/oracle.md)
* [{{ ydb-name }}](../source/ydb.md)
* [{{ OS }}](../source/opensearch.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available transfers](../../../transfer-matrix.md).

{% note warning %}

{{ objstorage-name }} only supports inserting new data but not updating it. If there is a data update going on in the source, it should not be used to supply data to {{ objstorage-name }}; otherwise, the transfer will fail with an [error](#update-not-supported).

{% endnote %}

## Configuring the {{ objstorage-name }} target endpoint {#endpoint-settings}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can define:

* [Connection settings](#bucket-config) for an {{ objstorage-full-name }} bucket or custom S3-compatible storage.
* [Additional parameters](#additional-settings).

### Connection settings {#bucket-config}

{% list tabs group=bucket %}

- {{ objstorage-full-name }} bucket {#obj-storage}

    
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}**: Name of the [bucket](../../../../storage/concepts/bucket.md) to upload source data to.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}**: [Service account](../../../../iam/concepts/users/service-accounts.md) with the `storage.uploader` role {{ data-transfer-name }} will use to connect to the bucket.


- Custom S3-compatible storage {#s3-storage}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}**: Name of the bucket to upload source data to.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.region.title }}**: Region where user data is stored.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.endpoint.title }}**: Endpoint for an Amazon S3-compatible service.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_access_key_id.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_secret_access_key.title }}**: [ID and contents of the AWS key](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) for access to the bucket.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.use_ssl.title }}**: Select this option if the remote server uses a secure SSL/TLS connection.
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.verify_ssl_cert.title }}**: Deny self-signed certificates.

{% endlist %}

If the new endpoint and the {{ objstorage-name }} bucket reside in different folders, then when configuring the connection, you must select manual setup and specify the following values:

  * `ru-central1` region.
  * {{ s3-storage-host }} endpoint.
  * Enable both settings related to SSL usage.

### Additional settings {#additional-settings}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1Endpoint.path_prefix.title }}**: The path in the bucket used for data export.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1SerializerConfig.title }}**: Format in which the data will be written to the bucket: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`, or `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_PARQUET.title }}`. For more information, see [{#T}](../../../concepts/serializer.md#serializer-s3).

    {% list tabs group=bucket-data-format %}

    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }} {#json}

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1SerializerConfig.compression_codec.title }}**: Output data compression algorithm: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}` or `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED.title }}`.
  
    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }} {#csv}

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1SerializerConfig.compression_codec.title }}**: Output data compression algorithm: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}` or `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED.title }}`.

    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_PARQUET.title }} {#parquet}

         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1SerializerConfig.Parquet.column_compression_codec.title }}**: Compression algorithm of data parts: `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageParquetCompressionCodecUI.SNAPPY.title }}`, or `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageParquetCompressionCodecUI.ZSTD.title }}`.
  
         * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.Parquet.row_group.title }}**: Parameters for splitting data into groups. You can specify the maximum number of rows in a group or the maximum group size in bytes. If you use these settings together, a new group will be created when at least one of the limits is exceeded.

    {% endlist %}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1AdvancedWriterSettings.title }}**: Additional settings for writing output files:

    {% list tabs group=writer-settings %}

    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1WriterSettings.SnapshotWriter.title }} {#snapshot}

      *  **Maximum number of records per file**: If left empty, the data will be written to a single file.
      *  **Maximum number of bytes per file**: If left empty, the data will be written to a single file.

    - {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageV1WriterSettings.ReplicationWriter.title }} {#replication}

      * **Rotation interval**: Value in seconds after which a new file will be written. The timestamp data is taken from the parameters of the received messages. The default value is one hour.

    {% endlist %}

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).

## Troubleshooting data transfer issues {#troubleshooting}

For the full list of recommendations, see [Troubleshooting](../../../troubleshooting/index.md).

{% include [update-not-supported](../../../../_includes/data-transfer/troubles/object-storage/update-not-supported.md) %}
