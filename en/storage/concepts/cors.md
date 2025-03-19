# CORS in {{ objstorage-name }}

{{ objstorage-full-name }} supports [cross-domain requests](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing) to bucket objects.

To manage a CORS configuration for each bucket, you can use:

- {{ yandex-cloud }} [management console](../operations/buckets/cors.md)
- [Amazon S3-compatible HTTP API](../s3/index.md)

    This way, you can manage CORS configurations using [tools](../tools/index.md) that support the Amazon S3 HTTP API.

To manage your CORS configuration via an Amazon S3-compatible HTTP API, define [it in XML format](../s3/api-ref/cors/xml-config.md). Different tools may require different configuration formats. You can find an example for the AWS CLI in [{#T}](../operations/buckets/cors.md).
