# How to use the API

## Before you start {#preparations}

To use the API:

1. [Create a service account ](../operations/security/service-account.md).
1. [Get the necessary roles](../security/index.md).
1. [Get a static key](../operations/security/get-static-key.md). Static key authorization is required to access the HTTP API directly and is supported by the tools listed in the section [[!TITLE]](../instruments/index.md).

For a list of supported Amazon S3 HTTP API methods, see the [API reference](api-ref/index.md).

## General format of an API request

General request format:

```
{GET|HEAD|PUT|DELETE} {path} HTTP/1.1
Host: [!KEYREF s3-storage-host]
Content-Length: length
Date: date
Authorization: authorization string (AWS Signature Version 4)

Request_body
```

Read more about headers in the section [[!TITLE]](api-ref/common-request-headers.md). The set of headers depends on a particular request.

If you use the API directly (without the SDK or apps), you will need to generate the `Authorization` header yourself for authenticating requests. Find out how to do this in the Amazon S3 documentation, the section [Authenticating Requests (AWS Signature Version 4)](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html).

