---
title: Response and error codes. {{ objstorage-name }} API (S3)
description: 'In this article, you will find the error and response codes in the {{ objstorage-name }} API (S3). Successful response: If there are no errors, {{ objstorage-name }} returns 2xx HTTP codes. The response code and body are request-specific and given in request descriptions. Error response: If there is an error, {{ objstorage-name }} returns a message with the relevant HTTP code and its additional description in XML format. Below you can find the error codes and their description.'
---

# Responses

## Successful response {#success}

If there are no errors, {{ objstorage-name }} returns a 2xx HTTP code. The response code and body are request-specific and given in request descriptions.


## Error response {#error}

In case of an error, {{ objstorage-name }} returns a message with the relevant HTTP code and its additional description in XML format.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Error>
  <Code>NoSuchKey</Code>
  <Message>The resource you requested does not exist</Message>
  <Resource>/mybucket/myfoto.jpg</Resource>
  <RequestId>4442587FB7D0A2F9</RequestId>
</Error>
```

Tag | Description
----- | -----
`Code` | Error code.<br/><br/>A list of codes is given below.
`Message` | Error description in English.
`RequestId` | ID of request that caused the error.<br/><br/>Same as the `X-Amz-Request-Id` header value.
`Resource` | Bucket or object the error occurred with.


### Error codes {#error_codes}

#|
|| **HTTP** | **Error code** | **Description** ||
|| 301 | `PermanentRedirect` | The specified bucket should always be accessed using the address returned in the response. ||
|| 307 | `Redirect` | The specified bucket should temporarily be accessed using the address returned in the response. ||
|| 307 | `TemporaryRedirect` | Redirect while the DNS is being updated. ||
|| 400 | `BadDigest` | The hash provided in the `Content-MD5` header does not match the one calculated on the {{ objstorage-name }} side. ||
|| 400 | `CloudTotalAliveSizeQuotaExceed` | After uploading the object, the [quota](../../concepts/limits.md) will be exceeded. [Request a quota increase]({{ link-console-quotas }}) or delete the objects you do not need and then upload the object again. ||
|| 400 | `CredentialsNotSupported` | Credentials are not supported. ||
|| 400 | `EntityTooSmall` | The uploaded object is smaller than the [minimum allowed](../../concepts/limits.md#storage-limits) size. ||
|| 400 | `EntityTooLarge` | The uploaded object is larger than the [maximum allowed](../../concepts/limits.md#storage-limits) size. ||
|| 400 | `ExpiredToken` | The token has [expired](../../../iam/concepts/authorization/iam-token.md#lifetime). ||
|| 400 | `IncompleteBody` | The sent data size is smaller than stated in the `Content-Length` header. ||
|| 400 | `IncorrectNumberOfFilesInPostRequest` | The POST method requires exactly one file upload per request. ||
|| 400 | `InlineDataTooLarge` | The request data exceeds the maximum allowed size. ||
|| 400 | `InvalidDigest` | The hash provided in the `Content-MD5` header is invalid. ||
|| 400 | `InvalidArgument` | The argument is invalid. ||
|| 400 | `InvalidBucketName` | Invalid bucket [name](../../concepts/bucket.md#naming). ||
|| 400 | `InvalidPart` | One or more parts of a multipart upload were not found. Make sure the list is correct. The missing parts may not have been uploaded. ||
|| 400 | `InvalidPartOrder` | The list of parts of a multipart upload is incorrect. The parts must be sorted by number in ascending order. ||
|| 400 | `InvalidRequest` | Use `AWS4-HMAC-SHA256`. ||
|| 400 | `InvalidStorageClass` | Invalid [storage class](../../concepts/storage-class.md). ||
|| 400 | `BucketMaxSizeExceeded` | Attempt to exceed the maximum bucket size.<br/><br/>Error description in the response: "You have attempted to exceed the max size configured for the bucket." ||
|| 400 | `InvalidTargetBucketForLogging` | The bucket does not exist, or you are not the owner of the bucket, or the log delivery group does not have sufficient permissions.


||
|| 400 | `InvalidToken` | The [token](../../../iam/concepts/authorization/iam-token.md) is malformed or otherwise invalid. ||
|| 400 | `InvalidURI` | Failed to parse the provided URI. ||
|| 400 | `KeyTooLongError` | The [key](../../concepts/object.md#key) is too long. ||
|| 400 | `MalformedACLError` | The provided XML document is malformed or does not match the schema. ||
|| 400 | `MalformedPOSTRequest` | The request body does not match the `multipart/form-data` format. ||
|| 400 | `MalformedXML` | The provided XML document is malformed or does not match the schema. ||
|| 400 | `MaxMessageLengthExceeded` | The maximum allowed request length is exceeded. ||
|| 400 | `MaxPostPreDataLengthExceededError` | HTTP message header is [too large](../../concepts/limits.md#storage-limits). ||
|| 400 | `MetadataTooLarge` | Metadata headers are [too large](../../concepts/limits.md#storage-limits). ||
|| 400 | `MissingRequestBodyError` | Empty request body.<br/><br/>Occurs if sending an empty XML document. ||
|| 400 | `MissingSecurityHeader` | The required header is missing. ||
|| 400 | `NoLoggingStatusForKey` | The key has no [logging status](../../concepts/server-logs.md#key-format).


||
|| 400 | `RequestIsNotMultiPartContent` | The request must contain data of the `multipart/form-data` type. ||
|| 400 | `RequestTimeout` | Read/write timeout. ||
|| 400 | `TokenRefreshRequired` | Refresh the [token](../../../iam/concepts/authorization/iam-token.md). ||
|| 400 | `TooManyBuckets` | After creating the object, the [quota](../../concepts/limits.md) will be exceeded. [Request a quota increase]({{ link-console-quotas }}) or delete the buckets you do not need and then create the bucket again. ||
|| 400 | `UnexpectedContent` | There should be no content in the request. ||
|| 400 | `UnresolvableGrantByEmailAddress` | Unregistered email address. ||
|| 400 | `UserKeyMustBeSpecified` | The request must contain the header specified in the error description. ||
|| 403 | `AccessDenied` | Access is denied. ||
|| 403 | `AccountProblem` | Account problem preventing successful completion of the operation.<br/><br/>Contact {{ yandex-cloud }} support. ||
|| 403 | `InvalidAccessKeyId` | Unknown [key](../../../iam/concepts/authorization/access-key.md). ||
|| 403 | `InvalidObjectState` | The request cannot be executed for the current state of the object. ||
|| 403 | `InvalidPayer` | Access to the object is blocked. ||
|| 403 | `InvalidSecurity` | The provided [secret keys](../../../iam/concepts/authorization/access-key.md) are not valid. ||
|| 403 | `NotSignedUp` | This account is not allowed to use {{ objstorage-name }}. ||
|| 403 | `RequestTimeTooSkewed` | The difference between the request sending time and the time on the server is too big. ||
|| 403 | `SignatureDoesNotMatch` | The provided request signature does not match the one calculated by {{ objstorage-name }}. ||
|| 404 | `NoSuchBucket` | The specified bucket does not exist. ||
|| 404 | `NoSuchKey` | The specified key does not exist. ||
|| 404 | `NoSuchUpload` | The specified multipart upload does not exist.<br/><br/>This error occurs in the following cases:<br/>- Invalid upload ID is specified.<br/>- Upload is aborted.<br/>- Upload is complete. ||
|| 404 | `NoSuchTagSet` | The specified bucket has no [tags](../../concepts/tags.md) assigned. ||
|| 405 | `MethodNotAllowed` | The HTTP method is not allowed for the specified resource. ||
|| 409 | `BucketAlreadyExists` | A bucket of the same name already exists. Choose a different name. ||
|| 409 | `BucketNotEmpty` | The bucket you are trying to delete is not empty. [Delete](../../operations/objects/delete.md) the objects you uploaded to the bucket. ||
|| 409 | `InvalidBucketState` | The request cannot be executed for the current state of the bucket. ||
|| 409 | `OperationAborted` | Conflicting conditional operations. ||
|| 411 | `MissingContentLength` | Add `Content-Length` to the headers. ||
|| 412 | `Precondition Failed` | One of the conditions specified in the request is not satisfied. ||
|| 416 | `InvalidRange` | Invalid range in the `Range` header. ||
|| 429 | `TooManyRequests` | Too many requests to {{ objstorage-name }}. Reduce the request rate. ||
|| 500 | `InternalError` | Internal error in {{ objstorage-name }}. Repeat the request. ||
|| 501 | `NotImplemented` | The provided header is not processed by {{ objstorage-name }}. ||
|| 503 | `ServiceUnavailable` | {{ objstorage-name }} is not available.<br/>Reduce your request rate. ||
|| 503 | `SlowDown` | Reduce your request rate. ||
|#

{% include [the-s3-api-see-also-include](../../../_includes/storage/the-s3-api-see-also-include.md) %}
