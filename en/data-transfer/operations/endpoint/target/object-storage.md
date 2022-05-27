# Target endpoint parameters {{ objstorage-name }}

When [creating](../index.md#create) or [updating](../index.md#update) an endpoint, you can configure access to a {{ objstorage-full-name }} bucket:

## {{ objstorage-full-name }} settings {#settings}


* **Bucket**: The name of the [bucket](../../../../storage/concepts/bucket.md) that data from the source will be loaded to.

* **SA Account**: A [service account](../../../../iam/concepts/users/service-accounts.md) with the `storage.uploader` role that you will access [{{ yds-full-name }}](../../../../data-streams/).

* **Output format**: The format that data will be written to the bucket in: `JSON` or `CSV`.

* **Data layout pattern**: The path to the folder in the bucket where data will be saved.

* **File size**: Split data into files of the specified size.

* **Sending interval**: The interval for sending data to the bucket, in seconds.

* **Compression format**: Compression of output data: `GZIP` or `UNCOMPRESSED` (disabled).
