---
title: "Response and error codes. {{ objstorage-name }} API (S3)"
description: "Here you will find the error and response codes in the {{ objstorage-name }} API (S3). Successful response: If there are no errors, {{ objstorage-name }} returns 2xx HTTP codes. The response code and body depend on the request and are given in the request descriptions. Error response: In the event of an error, {{ objstorage-name }} returns a message with the appropriate HTTP code and its additional description in XML format. The error codes and their meaning are described in detail."
---

# Responses

## Successful response {#success}

If there are no errors, {{ objstorage-name }} returns a 2xx HTTP code. The response code and body depend on the request and are given in the request descriptions.


## Error response {#error}

In case of an error, {{ objstorage-name }} returns a message with the appropriate HTTP code and its additional description in XML format.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Error>
  <Code>NoSuchKey</Code>
  <Message>The resource you requested does not exist</Message>
  <Resource>/mybucket/myfoto.jpg</Resource>
  <RequestId>4442587FB7D0A2F9</RequestId>
</Error>
```

| Tag | Description |
----- | -----
| `Code` | Error code.<br/><br/>A list of codes is given below. |
| `Message` | Error description in English. |
| `RequestId` | ID of the request that caused an error.<br/><br/>Same as the `X-Amz-Request-Id` header value. |
| `Resource` | The bucket or object that led to the error. |


### Error codes {#error_codes}

#|
|| **HTTP** | **Error code** | **Description** ||
|| 301 | `PermanentRedirect` | The specified bucket should always be accessed using the address specified in the response. ||
|| 307 | `Redirect` | The specified bucket should be temporarily accessed using the address specified in the response. ||
|| 307 | `TemporaryRedirect` | Redirect while the DNS is being updated. ||
|| 400 | `BadDigest` | The hash provided in the `Content-MD5` header does not match the hash calculated on {{ objstorage-name }} side. ||
|| 400 | `CloudTotalAliveSizeQuotaExceed` | After uploading the object, the [quota](../../concepts/limits.md) will be exceeded. [Request a quota increase]({{ link-console-quotas }}) or delete unnecessary objects and then upload the object again. ||
|| 400 | `CredentialsNotSupported` | Credentials are not supported. ||
|| 400 | `EntityTooSmall` | The uploaded object is smaller than the minimum allowed size. ||
|| 400 | `EntityTooLarge` | The uploaded object is larger than the maximum allowed size. ||
|| 400 | `ExpiredToken` | The provided token is expired. ||
|| 400 | `IncompleteBody` | The size of the sent data is smaller than specified in the `Content-Length` header. ||
|| 400 | `IncorrectNumberOfFilesInPostRequest` | The POST method requires only one file to be sent. ||
|| 400 | `InlineDataTooLarge` | The request data exceeds the maximum allowed size. ||
|| 400 | `InvalidDigest` | The hash provided in the Content-MD5 header is invalid. ||
|| 400 | `InvalidArgument` | Invalid argument. ||
|| 400 | `InvalidBucketName` | Invalid bucket name. ||
|| 400 | `InvalidPart` | One or more parts of a multipart upload are not found. Make sure the list is correct. The missing parts may not have been uploaded. ||
|| 400 | `InvalidPartOrder` | The list of parts of a multipart upload is incorrect. The parts must be sorted by number in ascending order. ||
|| 400 | `InvalidRequest` | Use AWS4-HMAC-SHA256. ||
|| 400 | `InvalidRequest` | Attempt to exceed the maximum bucket size.<br/><br/>Error description in the response: "You have attempted to exceed the max size configured for the bucket." ||
|| 400 | `InvalidStorageClass` | Invalid storage class. ||
|| 400 | `InvalidTargetBucketForLogging` | The bucket does not exist, or you are not the bucket owner, or the log delivery group does not have sufficient permissions.


||
|| 400 | `InvalidToken` | The token is malformed or otherwise invalid. ||
|| 400 | `InvalidURI` | Failed to parse the provided URI. ||
|| 400 | `KeyTooLongError` | The key is too long. ||
|| 400 | `MalformedACLError` | The provided XML document is malformed or does not match the schema. ||
|| 400 | `MalformedPOSTRequest` | The body of the request does not match the `multipart/form-data` format. ||
|| 400 | `MalformedXML` | The provided XML document is malformed or does not match the schema. ||
|| 400 | `MaxMessageLengthExceeded` | The maximum allowed request length is exceeded. ||
|| 400 | `MaxPostPreDataLengthExceededError` | The HTTP message header exceeded the allowed size. ||
|| 400 | `MetadataTooLarge` | The metadata headers exceed the allowed size. ||
|| 400 | `MissingRequestBodyError` | The request body is empty.<br/><br/>Occurs when sending an empty XML document. ||
|| 400 | `MissingSecurityHeader` | The required header is missing. ||
|| 400 | `NoLoggingStatusForKey` | Key logging status is missing.


||
|| 400 | `RequestIsNotMultiPartContent` | The request must contain `multipart/form-data` type data. ||
|| 400 | `RequestTimeout` | Read/write timeout. ||
|| 400 | `TokenRefreshRequired` | Refresh the token. ||
|| 400 | `TooManyBuckets` | After creating the object, the [quota](../../concepts/limits.md) will be exceeded. [Request a quota increase]({{ link-console-quotas }}) or delete unnecessary buckets and then create the bucket again. ||
|| 400 | `UnexpectedContent` | There should be no content in the request. ||
|| 400 | `UnresolvableGrantByEmailAddress` | Unregistered email. ||
|| 400 | `UserKeyMustBeSpecified` | The request must contain the header specified in the error description. ||
|| 403 | `AccessDenied` | Access denied. ||
|| 403 | `AccountProblem` | Account problem preventing successful completion of the operation.<br/><br/>Contact the {{ yandex-cloud }} support service. ||
|| 403 | `InvalidAccessKeyId` | Unknown key. ||
|| 403 | `InvalidObjectState` | The request cannot be run for the current state of the object. ||
|| 403 | `InvalidPayer` | Access to the object is blocked. ||
|| 403 | `InvalidSecurity` | The provided secret keys are invalid. ||
|| 403 | `NotSignedUp` | Use of {{ objstorage-name }} is not allowed for this account. ||
|| 403 | `RequestTimeTooSkewed` | The difference between request send time and server time is too great. ||
|| 403 | `SignatureDoesNotMatch` | The provided request signature does not match the one calculated by {{ objstorage-name }}. ||
|| 404 | `NoSuchBucket` | The specified bucket does not exist. ||
|| 404 | `NoSuchKey` | The specified key does not exist. ||
|| 404 | `NoSuchUpload` | The specified multipart upload does not exist.<br/><br/>The error occurs in the following cases:<br/> Invalid upload ID is specified.<br/>Upload is aborted.<br/>Upload is complete. ||
|| 404 | `NoSuchTagSet` | The specified bucket has no labels assigned. ||
|| 405 | `MethodNotAllowed` | The HTTP method is not allowed for the specified resource. ||
|| 409 | `BucketAlreadyExists` | A bucket with the same name already exists. Choose a different name. ||
|| 409 | `BucketNotEmpty` | The bucket you are deleting is not empty. ||
|| 409 | `InvalidBucketState` | The request cannot be run for the current state of the bucket. ||
|| 409 | `OperationAborted` | Conflicting conditional operations. ||
|| 411 | `MissingContentLength` | Add `Content-Length` to headers. ||
|| 412 | `Precondition Failed` | One of the conditions specified in the request is not met. ||
|| 416 | `InvalidRange` | Invalid range in the `Range` header. ||
|| 429 | `TooManyRequests` | Too many requests to {{ objstorage-name }}. Reduce the request rate. ||
|| 500 | `InternalError` | {{ objstorage-name }} internal error. Repeat the request. ||
|| 501 | `NotImplemented` | The provided header is not processed by {{ objstorage-name }}. ||
|| 503 | `ServiceUnavailable` | {{ objstorage-name }} is not available.<br/>Reduce your request rate.
|| 503 | `SlowDown` | Reduce your request rate. ||
|#