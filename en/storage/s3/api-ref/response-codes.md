---
title: "Response and error codes. {{ objstorage-name }} API (S3)"
description: "Describes the response and error codes in the {{ objstorage-name }} API (S3). Successful response - if no errors are encountered, {{ objstorage-name }} responds with 2xx HTTP codes. The response code and body depend on the request and are discussed in the request descriptions. Response with an error - if an error occurs {{ objstorage-name }} responds with a message with the appropriate HTTP code and optional XML description. Error codes, and their meanings are detailed."
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
| ----- | ----- |
| `Code` | Error code.<br/><br/>A list of codes is given below. |
| `Message` | Error description in English. |
| `RequestId` | ID of the request that caused an error.<br/><br/>Same as the `X-Amz-Request-Id` header value. |
| `Resource` | The bucket or object that led to the error. |

### Error codes {#error_codes}

| HTTP | Error code | Description |
| ----- | ----- | ----- |
| 301 | `PermanentRedirect` | The specified bucket should always be accessed using the address returned in the response. |
| 307 | `Redirect` | The specified bucket should temporarily be accessed using the address returned in the response. |
| 307 | `TemporaryRedirect` | Redirect while the DNS is being updated. |
| 400 | `BadDigest` | The hash passed in the `Content-MD5` header doesn't match the one calculated on the {{ objstorage-name }} side. |
| 400 | `CredentialsNotSupported` | Credentials are not supported. |
| 400 | `EntityTooSmall` | The size of an uploaded object is smaller than the minimum allowed size. |
| 400 | `EntityTooLarge` | The size of an uploaded object is greater than the maximum allowed size. |
| 400 | `ExpiredToken` | The token provided is expired. |
| 400 | `IncompleteBody` | The size of the data sent is smaller than the size indicated in the `Content-Length` header. |
| 400 | `IncorrectNumberOfFilesInPostRequest` | The POST method only requires one file to be sent. |
| 400 | `InlineDataTooLarge` | The request data exceeds the maximum allowed size. |
| 400 | `InvalidDigest` | The hash passed in the Content-MD5 header isn't valid. |
| 400 | `InvalidArgument` | The argument is invalid. |
| 400 | `InvalidBucketName` | The name of the bucket is invalid. |
| 400 | `InvalidPart` | One or more parts of a multipart upload were not found. Make sure the list is correct. The missing parts may not have been uploaded. |
| 400 | `InvalidPartOrder` | The list of parts of a multipart upload is incorrect. The parts must be sorted by number in ascending order. |
| 400 | `InvalidRequest` | Use AWS4-HMAC-SHA256. |
| 400 | `InvalidRequest` | Attempt to exceed the maximum bucket size.<br/><br/>Error description in the response: "You have attempted to exceed the max size configured for the bucket." |
| 400 | `InvalidStorageClass` | The storage class is invalid. |
| 400 | `InvalidTargetBucketForLogging` | The bucket does not exist, or you are not the owner of the bucket, or the log delivery group does not have sufficient permissions. |
| 400 | `InvalidToken` | The token is malformed or otherwise invalid. |
| 400 | `InvalidURI` | Failed to parse the passed URI. |
| 400 | `KeyTooLongError` | The key is too long. |
| 400 | `MalformedACLError` | The provided XML document is malformed or doesn't match the schema. |
| 400 | `MalformedPOSTRequest` | The body of the request isn't in `multipart/form-data` format. |
| 400 | `MalformedXML` | The provided XML document is malformed or doesn't match the schema. |
| 400 | `MaxMessageLengthExceeded` | The maximum allowed request length is exceeded. |
| 400 | `MaxPostPreDataLengthExceededError` | The HTTP message header exceed the allowed length. |
| 400 | `MetadataTooLarge` | The metadata headers exceed the allowed size. |
| 400 | `MissingRequestBodyError` | The request body is empty.<br/><br/>Occurs when sending an empty XML document. |
| 400 | `MissingSecurityHeader` | The required header is missing. |
| 400 | `NoLoggingStatusForKey` | There is no logging status for the key. |
| 400 | `RequestIsNotMultiPartContent` | The request must contain `multipart/form-data` type data. |
| 400 | `RequestTimeout` | A read/write timeout. |
| 400 | `TokenRefreshRequired` | Refresh your token. |
| 400 | `TooManyBuckets` | Exceeded the bucket number limit. |
| 400 | `UnexpectedContent` | The request shouldn't contain content. |
| 400 | `UnresolvableGrantByEmailAddress` | The email address provided doesn't match any recorded account. |
| 400 | `UserKeyMustBeSpecified` | The request must contain the header specified in the error description. |
| 403 | `AccessDenied` | Access is denied. |
| 403 | `AccountProblem` | There is a problem with the account that prevents the operation from completing successfully.<br/><br/>Contact Yandex.Cloud support. |
| 403 | `InvalidAccessKeyId` | Unknown key. |
| 403 | `InvalidObjectState` | The request cannot be executed for the current state of the object. |
| 403 | `InvalidPayer` | Access to the object is blocked. |
| 403 | `InvalidSecurity` | The provided secret keys are not valid. |
| 403 | `NotSignedUp` | Use of {{ objstorage-name }} isn't allowed for this account. |
| 403 | `RequestTimeTooSkewed` | The difference between the request sending time and the time on the server is too big. |
| 403 | `SignatureDoesNotMatch` | The provided request signature doesn't match the one calculated by {{ objstorage-name }}. |
| 404 | `NoSuchBucket` | The specified bucket does not exist. |
| 404 | `NoSuchKey` | The specified key does not exist. |
| 404 | `NoSuchUpload` | The specified multipart upload does not exist.<br/><br/>This error occurs in the following cases:<br/>- An Invalid upload ID is specified.<br/>- Upload is aborted.<br/>- Upload is complete. |
| 405 | `MethodNotAllowed` | The HTTP method is not allowed for the specified resource. |
| 409 | `BucketAlreadyExists` | A bucket with the same name already exists. Choose a different name. |
| 409 | `BucketNotEmpty` | The bucket you are trying to delete is not empty. |
| 409 | `InvalidBucketState` | The request cannot be executed for the current state of the bucket. |
| 409 | `OperationAborted` | Conflicting conditional operations. |
| 411 | `MissingContentLength` | Add `Content-Length` to the headers. |
| 412 | `Precondition Failed` | One of the conditions specified in the request is not met. |
| 416 | `InvalidRange` | Invalid range in the `Range` header. |
| 429 | `TooManyRequests` | Too many requests to {{ objstorage-name }}. Reduce the request rate. |
| 500 | `InternalError` | Internal error in {{ objstorage-name }}. Repeat the request. |
| 501 | `NotImplemented` | The passed header is not handled by {{ objstorage-name }}. |
| 503 | `ServiceUnavailable` | {{ objstorage-name }} is not available.<br/>Reduce your request rate. |
| 503 | `SlowDown` | Reduce your request rate. |

