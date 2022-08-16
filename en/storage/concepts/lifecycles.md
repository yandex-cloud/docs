# Object lifecycles

{{ objstorage-name }} lets you define the actions automatically applied to individual objects or groups of objects in the bucket at specified points in time.

Types of actions:

- Change the [storage class](storage-class.md) of objects.
- Delete objects.
- Deleting incomplete multipart uploads.

You can only configure object lifecycles for each individual bucket. You can't configure lifecycles for a bucket group, folder, or cloud.

To manage object lifecycles, you can use:

- The {{ yandex-cloud }} [management console](../operations/buckets/lifecycles.md).
- [Amazon S3-compatible HTTP API](../s3/index.md).

   This way you can manage lifecycle configurations using [tools](../tools/index.md) with Amazon S3 HTTP API support.

When managing lifecycles via the Amazon S3-compatible HTTP API, define the [configuration in XML format](../s3/api-ref/lifecycles/xml-config.md). Different tools may require different configuration formats, see the example for the AWS CLI in [{#T}](../operations/buckets/lifecycles.md).

Changes are applied to the lifecycles at 00:00 UTC every 24 hours.

