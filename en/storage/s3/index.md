---
title: "How do I use the S3 API? {{ objstorage-name }}"
description: "In this article, you will learn how to get started with the API, what an {{ objstorage-name }} API request is, and how to use cross-domain requests."
keywords:
  - s3
  - s3 storage
  - s3 api
  - api
  - s3 api object storage
  - object storage
  - api s3
---

# How to use the S3 API

## Getting started {#before-you-start}

To use the API:

{% include [aws-tools-prepare](../../_includes/aws-tools/aws-tools-prepare.md) %}

To access the HTTP API directly, you need static key authentication, which is supported by the tools listed in [{#T}](../tools/index.md).

For a list of supported Amazon S3 HTTP API methods, see the [API reference](api-ref/index.md).

## General API request format {#common-request-form}

General {{ objstorage-name }} API request format:

```
{GET|HEAD|PUT|DELETE} /<bucket_name>/<object_key> HTTP/2
Host: {{ s3-storage-host }}
Content-Length: length
Date: date
Authorization: authorization string (AWS Signature Version 4)

Request_body
```

The request contains an HTTP method, bucket name, and [object key](../concepts/object.md).

The bucket name can be specified as part of the host name. In this case, the request will look like this:

```
{GET|HEAD|PUT|DELETE} /<object_key>} HTTP/2
Host: <bucket_name>.{{ s3-storage-host }}
...
```

The set of headers depends on the specific request and is described in the documentation for the corresponding request.

If you use the API directly (without an SDK or apps), you need to generate the `Authorization` header yourself for authenticating requests. Find out how to do this in the Amazon S3 documentation: [Authenticating Requests (AWS Signature Version 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html).

### Request URL {#request-url}

URLs can take one of the following forms:

- `https://{{ s3-storage-host }}/<bucket_name>/<object_key>?<query parameters>`
- `http://<bucket_name>.{{ s3-storage-host }}/<object_key>?<query parameters>`

The URL contains the bucket name, object key, and query parameters. See an example of possible query parameters in the [Get object method description](api-ref/object/get.md).

{% include [storage-dotnet-host](../_includes_service/storage-dotnet-host.md) %}

## CORS requests {#cors-requests}

[Cross-domain requests](../concepts/cors.md) are available for all API methods used for object management.

To check permissions, CORS sends the [options](api-ref/object/options.md) preflight request to a resource. {{ objstorage-name }} allows you to skip the preflight request when sending cross-domain requests to resources. In this case, your request's [headers](api-ref/object/options.md#request-headers) must be the same as those of the preflight request.
