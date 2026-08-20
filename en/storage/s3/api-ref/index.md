---
title: What S3 API methods can be used to manage {{ objstorage-full-name }}
description: In this article, you will learn what S3 API methods can be used to manage {{ objstorage-name }}.
---

# All services and methods

The {{ objstorage-name }} HTTP API provides the following services:

#|
|| **Service** | **Description** ||
|| [Bucket](bucket.md) | Manages buckets. ||
|| [Object](object.md) | Manages objects. ||
|| [Multipart upload](multipart.md) | Controls upload of large objects. ||
|| [Static Website Hosting](hosting.md) | Manages bucket configurations for static website hosting. ||
|| [CORS](cors.md) | Manages CORS configurations for buckets. ||
|| [Lifecycles](lifecycles.md) | Manages bucket object lifecycle configurations. ||
|| [ACL](acl.md) | Manages access control lists. ||
|| [Bucket Policy](policy.md) | Manages bucket access policies. ||
|#

## Supported methods {#operations-list}

### Bucket service {#bucket-service}

{% include [bucket-methods-table](../../../_includes/storage/s3-api-ref/bucket-methods-table.md) %}

### Object service {#object-service}

{% include [object-methods-table](../../../_includes/storage/s3-api-ref/object-methods-table.md) %}

### Multipart upload service {#multipart-upload-service}

{% include [multipart-methods-table](../../../_includes/storage/s3-api-ref/multipart-methods-table.md) %}

### Static Website Hosting service {#static-website-hosting-service}

{% include [hosting-methods-table](../../../_includes/storage/s3-api-ref/hosting-methods-table.md) %}

### CORS service {#cors-service}

{% include [cors-methods-table](../../../_includes/storage/s3-api-ref/cors-methods-table.md) %}

### Lifecycles service {#lifecycles-service}

{% include [lifecycles-methods-table](../../../_includes/storage/s3-api-ref/lifecycles-methods-table.md) %}

### ACL service {#acl-service}

{% include [acl-methods-table](../../../_includes/storage/s3-api-ref/acl-methods-table.md) %}

### Bucket Policy service {#bucket-policy}

{% include [policy-methods-table](../../../_includes/storage/s3-api-ref/policy-methods-table.md) %}

## Useful links {#see-also}

* [{#T}](../../s3/s3-api-quickstart.md)
* [{#T}](../../s3/index.md)
* [{#T}](../../tools/index.md)
* [Debugging requests using the AWS CLI](../signing-requests.md#debugging)
* [Example of sending a signed request using curl](../../api-ref/authentication.md#s3-api-example)
* [Code example for generating a signature](../../concepts/pre-signed-urls.md#code-examples)