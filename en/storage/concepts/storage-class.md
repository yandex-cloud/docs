# Storage class

[!KEYREF objstorage-full-name] allows you to store objects in standard and cold storage.

The standard storage is designed for storing frequently used objects.

The cold storage is designed for long-term storage of objects with rare read requests.

The storage class is specified when uploading each individual object. You can't set a storage class for an entire bucket, folder, or cloud. By default, [!KEYREF objstorage-name] saves objects to the standard storage.

Pricing differs for storing and accessing objects in standard storage and cold storage. For more information, see [[!TITLE]](../pricing.md).

## Storage class IDs

- Standard storage: `STANDARD`.

- Cold storage: `COLD`.

    For uploading objects to cold storage, you can also specify the `STANDARD_IA` and `NEARLINE` IDs. [!KEYREF objstorage-name] interprets them as `COLD`. Use any suitable ID when working with the [API compatible with Amazon S3](../s3/index.md) or the tools described in [[!TITLE]](../instruments/index.md).

