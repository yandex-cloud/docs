# Storage class

{{ objstorage-full-name }} allows you to store objects in standard and cold storage.

Standard storage is designed for storing frequently used objects.

Cold storage is designed for long-term storage of objects with rare read requests.

The storage class is optionally specified when uploading each individual object. If it is not specified, {{ objstorage-name }} uses the default storage class. You can set the default storage class for each bucket separately. You can't set the default storage class for all buckets in a folder or cloud. Setting the default storage class might be useful if the tool you are using does not allow you to set the storage class when uploading objects. You must use the management console to configure the default storage class. The default storage class for buckets created using other tools is Standard.

Pricing differs for storing and accessing objects in standard storage and cold storage. For more information, see [{#T}](../pricing.md).

## Storage class IDs

- Standard storage: `STANDARD`.

- Cold storage: `COLD`.

    For uploading objects to cold storage, you can also specify the `STANDARD_IA` and `NEARLINE` IDs. {{ objstorage-name }} interprets them as `COLD`. Use any suitable ID when working with the [API compatible with Amazon S3](../s3/index.md) or the tools described in [{#T}](../instruments/index.md).

