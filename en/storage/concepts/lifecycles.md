# Object lifecycles

{{ objstorage-name }} allows you to define the actions that are automatically applied to individual objects or object groups in a bucket at specific points in time.

Types of actions:

- Change object [storage class](storage-class.md) from `STANDARD` to `COLD`.
- Delete objects.
- Delete incomplete multipart uploads.

You can only configure object lifecycles for each individual bucket, not for a bucket group, folder, or cloud.

To manage object lifecycles, you can use:

- {{ yandex-cloud }} [management console](../operations/buckets/lifecycles.md)
- [Amazon S3-compatible HTTP API](../s3/index.md)

   This allows you to use [tools](../tools/index.md) with Amazon S3 HTTP API support to manage lifecycle configurations.

When managing lifecycles via an Amazon S3-compatible HTTP API, define the [configuration in XML format](../s3/api-ref/lifecycles/xml-config.md). Different tools may require different configuration formats; for an example of AWS CLI configuration, see [{#T}](../operations/buckets/lifecycles.md).

Changes are applied to lifecycles at 00:00 UTC, every 24 hours.

