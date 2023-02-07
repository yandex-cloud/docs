# Configuring an {{ objstorage-name }} target endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can configure access to a {{ objstorage-full-name }} bucket.

## Settings {{ objstorage-full-name }} {#settings}

{% if audience != "internal" %}

* **Bucket**: The name of the [bucket](../../../../storage/concepts/bucket.md) to upload source data to.

* **Service account**: The [service account](../../../../iam/concepts/users/service-accounts.md) with the `storage.uploader` role{% if product == "yandex-cloud" %} that will be used to access [{{ yds-full-name }}](../../../../data-streams/){% endif %}.

{% else %}

* **Bucket**: The name of the bucket to upload source data to.

* **Service account**: The service account with the `storage.uploader` role{% if product == "yandex-cloud" %} that will be used to access [{{ yds-full-name }}](../../../../data-streams){% endif %}.

{% endif %}

* **Serialization format**: The format that data will be written to the bucket in (`JSON`, `CSV`, or `Raw`).

* **Encoding format**: Compression of output data (`GZIP` or `UNCOMPRESSED`).

* **Folder name**: The name of the folder to store files. Supports the data layout pattern by date, such as `2006/01/02/<folder name>`.

## Advanced settings {#additional-settings}

* **Buffer size**: The size of files that data will be split into.

* **Flush interval**: The time after which the file will be written, regardless of its size.
