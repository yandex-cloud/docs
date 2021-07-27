---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Object lifecycles

{{ objstorage-name }} lets you define the actions automatically applied to individual objects or groups of objects in the bucket at specified points in time.

Types of actions:

- Change the [storage class](storage-class.md) of objects.
- Delete objects.
- Deleting incomplete multipart uploads.

You can only configure object lifecycles for each individual bucket. You can't configure lifecycles for a bucket group, folder, or cloud.

To manage object lifecycles, you can use:

- [The {{ yandex-cloud }} management console](../operations/buckets/lifecycles.md).

- [An Amazon S3-compatible HTTP API](../s3/index.md).

    This way you can manage lifecycle configurations using [tools](../tools/index.md) that support Amazon S3 HTTP API.

When you manage lifecycles via the Amazon S3-compatible HTTP API, define the [configuration in XML format](../s3/api-ref/lifecycles/xml-config.md). Different tools may require different configuration formats, see the example for the AWS CLI in [{#T}](../operations/buckets/lifecycles.md).

