# Object lifecycles

{{ objstorage-name }} allows you to define the actions that are automatically applied to individual objects or object groups in a bucket at specific points in time.

Types of actions:

* Change the [storage class](storage-class.md) of objects or their non-current [versions](versioning.md) to a "colder" one.
* Delete objects or their non-current versions.
* Delete incomplete multipart uploads.

Filters for grouping objects:

* Object key prefix.
* Minimum or maximum object size: Using the [S3 API](../s3/index.md) or [tools](../tools/index.md) that support it.

If you are using the S3 API, specify a lifecycle configuration in [XML format](../s3/api-ref/lifecycles/xml-config.md). For various tools with S3 API support, other configuration formats may be required. The AWS CLI, for example, uses JSON format.

You can only configure object lifecycles for each individual bucket, not for a bucket group, folder, or cloud.

Changes are applied to lifecycles at 00:00 UTC, every 24 hours.

#### See also {#see-also}

* [{#T}](../operations/buckets/lifecycles.md)
