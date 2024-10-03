---
title: How to configure an {{ objstorage-full-name }} source endpoint
description: Follow this guide to configure an {{ objstorage-full-name }} source endpoint.
---
# Transferring data from an {{ objstorage-full-name }} source endpoint

{{ data-transfer-full-name }} enables you to migrate data from {{ objstorage-full-name }} storage to {{ yandex-cloud }} managed databases and implement various data processing and transformation scenarios. To implement a transfer:

1. [Explore possible data transfer scenarios](#scenarios).
1. [Set up an endpoint source](#endpoint-settings) in {{ data-transfer-full-name }}.
1. [Set up one of the supported data targets](#supported-targets).
1. [Create](../../transfer.md#create) a transfer and [start](../../transfer.md#activate) it.
1. Perform required operations with the storage and [control the transfer](../../monitoring.md).
1. In case of any issues, [use ready-made solutions](../../../../data-transfer/troubleshooting/index.md) to resolve them.

## Scenarios for transferring data from {{ objstorage-name }} {#scenarios}

You can implement scenarios for data migration and delivery from the {{ objstorage-full-name }} storage to managed databases for further storage in the cloud, processing and loading into data marts for further visualization.

{% include [data-mart](../../../../_includes/data-transfer/scenario-captions/data-mart.md) %}

* [Loading data from {{ objstorage-name }} to {{ PG }}](../../../tutorials/object-storage-to-postgresql.md).
* [Loading data from {{ objstorage-name }} to {{ GP }}](../../../tutorials/object-storage-to-greenplum.md).
* [Loading data from {{ objstorage-name }} to {{ MY }}](../../../tutorials/objs-mmy-migration.md).
* [Loading data from {{ objstorage-name }} to {{ CH }}](../../../tutorials/object-storage-to-clickhouse.md).
* [Loading data from {{ objstorage-name }} to {{ ydb-short-name }}](../../../tutorials/object-storage-to-ydb.md).

For a detailed description of possible {{ data-transfer-full-name }} data transfer scenarios, see [Tutorials](../../../tutorials/index.md).

## Configuring the {{ objstorage-name }} source endpoint {#endpoint-settings}

{% include [note-preview](../../../../_includes/preview-pp.md) %}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, configure access to S3-compatible storage.

### Settings {#settings}

#### Bucket configuration parameters {#bucket-config}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.bucket.title }}**: Bucket name.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_access_key_id.title }}** and **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_secret_access_key.title }}**: [ID and contents of the AWS key](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys) used to access a private bucket.
* (Optional) **{{ ui-key.yc-data-transfer.data-transfer.endpoint.airbyte.s3_source.endpoint.airbyte.s3_source.S3Source.Provider.path_prefix.title }}**: Prefix for folders and files that may be used when performing a search within the bucket.
* (Optional) **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.endpoint.title }}**: Endpoint for an Amazon S3-compatible service. Leave this field empty to use Amazon.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.region.title }}**: Region to send requests.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.use_ssl.title }}**: Select this option if the remote server uses a secure SSL/TLS connection.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.verify_ssl_cert.title }}**: Allow self-signed certificates.

**{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.path_pattern.title }}**: Enter the path pattern. If the bucket only includes files, use the `**` value.

#### Event queue configuration {#event-queue-config}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.queue_name.title }}**: Name of the queue set up in the S3 bucket to get `s3:ObjectCreated` events.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.owner_id.title }}**: ID of the AWS account used to create the queue. Leave this field empty if the S3 bucket and queue were created by the same account.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_access_key_id.title }}**: ID of the AWS key used as part of the credentials to read from the SQS queue. Leave this field empty if the credentials used for the S3 bucket are applicable.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.aws_secret_access_key.title }}**: AWS secret used as part of the credentials to read from the SQS queue. Leave this field empty if the credentials used for the S3 bucket are applicable.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.endpoint.title }}**: Endpoint for an S3-compatible service. Leave this field empty to use AWS.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageEventSource.SQS.region.title }}**: AWS region to send requests. Leave this field empty if it matches the bucket region.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.use_ssl.title }}**: Select this option if the remote server uses a secure SSL/TLS connection.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ConnectionSettings.verify_ssl_cert.title }}**: Allow self-signed certificates.

#### Data format {#data-format}

{% list tabs %}

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.csv.title }}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.delimiter.title }}**: Delimiter character.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.quote_char.title }}**: Character used to mark the beginning and end of a string.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.escape_char.title }}**: Character used to escape special characters.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.encoding.title }}**: [Encoding](https://docs.python.org/3/library/codecs.html#standard-encodings).
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.double_quote.title }}**: Select this option to replace double quotes with single quotes.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.newlines_in_values.title }}**: Select this option if your text data values might include newline characters.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.block_size.title }}**: Maximum length of a file segment loaded into memory when reading data.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.advanced_settings.title }}**: Required CSV [ConvertOptions](https://arrow.apache.org/docs/python/generated/pyarrow.csv.ConvertOptions.html#pyarrow.csv.ConvertOptions) to edit, which are specified as a JSON-string.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Csv.additional_options.title }}**: Required CSV [ReadOptions](https://arrow.apache.org/docs/python/generated/pyarrow.csv.ReadOptions.html#pyarrow.csv.ReadOptions) to edit, which are specified as a JSON-string.

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.parquet.title }}

- {{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.jsonl.title }}

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Jsonl.newlines_in_values.title }}**: Allow using newline characters in JSON values. Enabling this parameter may affect performance. Leave this field empty to use the default value (`FALSE`).
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Jsonl.unexpected_field_behavior.title }}**: Method for handling JSON fields outside the `explicit_schema` (if specified). See [the PyArrow documentation](https://arrow.apache.org/docs/python/generated/pyarrow.json.ParseOptions.html).
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.ObjectStorageReaderFormat.Jsonl.block_size.title }}**: Size of file segments in bytes for concurrent processing in each file memory. When handling large amounts of data where the schema cannot be inferred, increasing this value should solve the problem. Setting the value too high may lead to OOM errors.

- proto

   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.proto_desc.title }}**: Upload a descriptor file.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.msg_package_type.title }}**: Specify the message packaging method:
      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoMessagePackageType.PROTOSEQ.title }}`: Delimited sequence of target messages.
      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoMessagePackageType.REPEATED.title }}`: Target message is specified in the `repeated` field of a single wrapper.
      * `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoMessagePackageType.SINGLE_MESSAGE.title }}`: Single target message.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.msg_name.title }}**: If the packaging type is `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoMessagePackageType.REPEATED.title }}`, specify the name of the message whose single `repeated` field contains the target message. Otherwise, specify the target message name.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.primary_keys.title }}**: List the fields to add to the result as primary keys.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigProto.included_fields.title }}**: List the message fields to transfer. If not specified, the output will include all the message fields.
   * **{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ProtoParser.null_keys_allowed.title }}**: Select this option to allow the `null` value in key columns.

{% endlist %}

#### Dataset {#dataset}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.SchemaTableFilterEntry.schema.title }}**: Specify the schema of an auxiliary table that will be used for the connection.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.SchemaTableFilterEntry.table.title }}**: Specify the name of an auxiliary table that will be used for the connection.
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageResultTable.add_system_cols.title }}**: Adds the `__file_name` and `__row_index` system columns to the result table schema. `__file_name` matches the name of the source S3 object. `__row_index` matches the count of rows populated with data in the S3 object.

   {% note warning %}

   Disabling this option may negatively affect data targets that require a primary key, provided that the result schema may become mandatory in such cases.

   {% endnote %}

**{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSource.result_schema.title }}**: Specify a JSON schema in `{"<column>": "<data_type>"}` format or list the fields for the schema of the resulting table. If you select `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageDataSchema.infer.title }}`, the schema will be inferred automatically.

Additionally, you can specify how to process rows that did not pass a type check: continue the transfer, repeat the attempt to define the type, abort the transfer.

## Configuring the data target {#supported-targets}

Configure one of the supported data targets:

* [{{ PG }}](../target/postgresql.md)​
* [{{ MY }}](../target/mysql.md)​
* [{{ CH }}](../target/clickhouse.md)
* [{{ ydb-full-name }}](../target/yandex-database.md)
* [{{ GP }}](../target/greenplum.md)

For a complete list of supported sources and targets in {{ data-transfer-full-name }}, see [Available Transfers](../../../transfer-matrix.md).

After configuring the data source and target, [create and start the transfer](../../transfer.md#create).