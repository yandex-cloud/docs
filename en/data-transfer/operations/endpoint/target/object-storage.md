# Configuring {{ objstorage-name }} target endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can configure access to a {{ objstorage-full-name }} bucket.

## Settings {{ objstorage-full-name }} {#settings}


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket.title }}**: Name of the [bucket](../../../../storage/concepts/bucket.md) to upload source data to.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.service_account_id.title }}**: The [service account](../../../../iam/concepts/users/service-accounts.md) with the `storage.uploader` role that will be used to access [{{ yds-full-name }}](../../../../data-streams/).


* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}**: Format the data will be written to the bucket in ( `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}`, `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_CSV.title }}`, or `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_RAW.title }}`).

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.any_as_string.title }}**: Conversion of complex values to strings for `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageSerializationFormatUI.OBJECT_STORAGE_SERIALIZATION_FORMAT_JSON.title }}` output format.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_encoding.title }}**: Compression of output data (`{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.GZIP.title }}` or `{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageCodecUI.UNCOMPRESSED.title }}`).

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageConnectionSettings.bucket_layout.title }}**: Name of the folder to store files in. Supports the data layout pattern by date, such as `2006/01/02/<folder name>`.

## Advanced settings {#additional-settings}

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.buffer_size.title }}**: Size of files the data will be split into.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageAdvancedSettings.buffer_interval.title }}**: Time after which the file will be written, regardless of its size.
