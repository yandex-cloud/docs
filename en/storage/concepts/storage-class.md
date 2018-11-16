# Storage class

Yandex [!KEYREF objstorage-name] allows you to store objects in both cold and standard storage.

The cold storage is designed for long-term storage of objects with rare read requests.

The standard storage is designed for storing frequently used objects.

The storage class is specified when uploading each individual object. You can't set a storage class for an entire bucket, folder, or cloud. By default, [!KEYREF objstorage-name] saves objects to the standard storage.

Pricing differs for storing and accessing objects in standard storage and cold storage. For more information, see [[!TITLE]](../pricing.md).

You can specify the storage class when uploading an object via the HTTP API compatible with Amazon S3.

