# Configuring an {{ objstorage-name }} target endpoint

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can configure access to a {{ objstorage-full-name }} bucket.

## Settings {{ objstorage-full-name }} {#settings}

{% if audience != "internal" %}

* **Bucket**: The name of the [bucket](../../../../storage/concepts/bucket.md) to upload source data to.

* **Service account**: [Service account](../../../../iam/concepts/users/service-accounts.md) with the `storage.uploader` role{% if product == "yandex-cloud" %} that will be used to access [{{ yds-full-name }}](../../../../data-streams/){% endif %}.

{% else %}

* **Bucket**: Name of the bucket to upload source data to.

* **Service account**: Service account with the `storage.uploader` role{% if product == "yandex-cloud" %} that will be used to access [{{ yds-full-name }}](../../../../data-streams){% endif %}.

{% endif %}

* **Output format**: Format the data will be written to the bucket in (`JSON`, `CSV`, or `Raw`).

* **Compression format**: Compression of output data (`GZIP` or `UNCOMPRESSED`).

* **Folder name**: Name of the folder to store files in. Supports the data layout pattern by date, such as `2006/01/02/<folder name>`.

## Advanced settings {#additional-settings}

* **Buffer size**: Size of files the data will be split into.

* **Write interval**: Time after which the file will be written, regardless of its size.
