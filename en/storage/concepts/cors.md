# CORS in {{ objstorage-name }}

{{ objstorage-full-name }} supports [cross-domain requests](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) to bucket objects.

To manage the CORS configuration for each bucket, you can use:

- The {{ yandex-cloud }} [management console](../operations/buckets/cors.md).
- [Amazon S3-compatible HTTP API](../s3/index.md).

   This way you can manage CORS configurations using [tools](../tools/index.md) that support Amazon S3 HTTP API.

When you manage CORS configurations via an Amazon S3-compatible HTTP API, define the [configuration in XML format](../s3/api-ref/cors/xml-config.md). Different tools may require different configuration formats, see the example for the AWS CLI in [{#T}](../operations/buckets/cors.md).
