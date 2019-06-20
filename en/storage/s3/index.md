# How to use the API

## Before you start {#preparations}

To use the API:

{% include [storage-s3-http-api-preps](../_includes_service/storage-s3-http-api-preps.md) %}

Static key authorization is required to access the HTTP API directly and is supported by the tools listed in the section [#T](../instruments/index.md).

For a list of supported Amazon S3 HTTP API methods, see the [API reference](api-ref/index.md).

## General format of an API request

```
{GET|HEAD|PUT|DELETE} {path} HTTP/1.1
Host: {{ s3-storage-host }}
Content-Length: length
Date: date
Authorization: authorization string (AWS Signature Version 4)

Request_body
```

Read more about headers in the section [#T](api-ref/common-request-headers.md). The set of headers depends on a particular request.

If you use the API directly (without the SDK or apps), you will need to generate the `Authorization` header yourself for authenticating requests. Find out how to do this in the Amazon S3 documentation: [Authenticating Requests (AWS Signature Version 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html).

## CORS requests

Cross-domain requests are available for all API methods used for object management.

To check permissions, CORS sends the [options](api-ref/object/options.md) preflight request to a resource. {{ objstorage-name }} allows you to skip the preflight request when sending cross-domain requests to resources. In this case, your request's [headers](api-ref/object/options.md#request-headers) must be the same as those of the preflight request.

