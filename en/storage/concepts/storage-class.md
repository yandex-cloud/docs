# Storage class

{{ objstorage-name }} lets you store objects in both *standard* and *cold* storages:

- Standard storage is designed for storing frequently used objects.
- Cold storage is designed for long-term storage of objects with rare read requests.

The storage class is optionally specified when uploading each individual object.

Pricing differs for storing and accessing objects in standard and cold storage. For more information, see [{#T}](../pricing.md).

## Default storage for a bucket {#default-storage-class}

If you don't specify the storage class on object upload, the object is saved to the default storage for the bucket.

You can set the default storage when creating a bucket in the management console. Afterwards, you can also change this setting for each bucket in the management console. You can't set or change the default storage with other tools. For buckets created outside of the management console, the default storage is set. You can't set the default storage for all buckets in a folder or cloud at once.

Setting default storage is useful if the tool you use doesn't let you set the object storage class.

## Storage class IDs {#storage-class-identifiers}

- Standard storage: `STANDARD`.

- Cold storage: `COLD`.

    To upload objects to cold storage, you can also specify the `STANDARD_IA` and `NEARLINE` IDs. {{ objstorage-name }} interprets them as `COLD`. Use any ID you like when working with an [Amazon S3- compatible API](../s3/index.md) or the tools described in [{#T}](../instruments/index.md).

