# Responses

## Successful response {#success}

If there are no errors, Yandex [!KEYREF objstorage-name] returns HTTP code 200. The response body depends on the request and is given in the request descriptions.

## Error response {#error}

In case of an error, [!KEYREF objstorage-name] returns a message with the appropriate HTTP code and its additional description in XML format.

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
| `RequestId` | ID of the request that caused the error.<br/><br/>Equal to the value of the `x-amz-request-id` header. |
| `Resource` | The bucket or object the error occurred with. |

### Error codes {#error_codes}

| Code | Description | HTTP code |
| ----- | ----- | ----- |
| `AccessDenied` | Access is denied. | 403 Forbidden |
| `AccountProblem` | There is a problem with the account that prevents the operation from completing successfully.<br/><br/>Contact the Yandex.Cloud support service. | 403 Forbidden |
| `BadDigest` | The hash passed in the `Content-MD5` header does not match the one calculated on the [!KEYREF objstorage-name] side. | 400 Bad Request |
| `BucketAlreadyExists` | A bucket with the same name already exists. Choose a different name. | 409 Conflict |
| `BucketNotEmpty` | The bucket you are trying to delete is not empty. | 409 Conflict |
| `CredentialsNotSupported` | Credentials are not supported. | 400 Bad Request |
| `EntityTooSmall` | The size of an uploaded object is smaller than the minimum allowed. | 400 Bad Request |
| `EntityTooLarge` | The size of an uploaded object is greater than the maximum allowed. | 400 Bad Request |
| `ExpiredToken` | The provided token has expired. | 400 Bad Request |
| `IncompleteBody` | The size of the sent data is smaller than the size indicated in the `Content-Length` header. | 400 Bad Request |
| `IncorrectNumberOfFilesInPostRequest` | The POST method requires that only one file is sent. | 400 Bad Request |
| `InlineDataTooLarge` | Request data exceeds the maximum allowed size. | 400 Bad Request |
| `InternalError` | [!KEYREF objstorage-name] internal error. Repeat the request. | 500 Internal Server Error |
| `InvalidAccessKeyId` | Unknown key. | 403 Forbidden |
| `InvalidArgument` | Invalid argument. | 400 Bad Request |
| `InvalidBucketName` | Invalid bucket name. | 400 Bad Request |
| `InvalidBucketState` | The request cannot be executed for the current state of the bucket. | 409 Conflict |
| `InvalidDigest` | The hash passed in the Content-MD5 header is not valid. | 400 Bad Request |
| `InvalidObjectState` | The request cannot be executed for the current state of the object. | 403 Forbidden |
| `InvalidPart` | One or more parts of multipart upload not found. Check whether the list is correct. The missing parts may not have been uploaded. | 400 Bad Request |
| `InvalidPartOrder` | The list of multipart upload parts is incorrect. The parts must be sorted by number in ascending order. | 400 Bad Request |
| `InvalidPayer` | Access to the object is blocked. | 403 Forbidden |
| `InvalidRange` | Invalid range in the Range header. | 416 Requested Range Not Satisfiable |
| `InvalidRequest` | Use AWS4-HMAC-SHA256. | 400 Bad Request |
| `InvalidRequest` | Attempt to exceed the maximum bucket size.<br/><br/>Error description in the response:<br/><br/>``` You have attempted to exceed the max size configured for the bucket. ``` | 400 Bad Request |
| `InvalidSecurity` | The provided secret keys are not valid. | 403 Forbidden |
| `InvalidStorageClass` | Invalid storage class. | 400 Bad Request |
| `InvalidTargetBucketForLogging` | The bucket does not exist, or you are not the owner of the bucket, or the log delivery group does not have sufficient permissions. | 400 Bad Request |
| `InvalidToken` | The token is malformed or otherwise invalid. | 400 Bad Request |
| `InvalidURI` | Failed to parse the passed URI. | 400 Bad Request |
| `KeyTooLongError` | The key is too long. | 400 Bad Request |
| `MalformedACLError` | The provided XML document is malformed or does not conform to the schema. | 400 Bad Request |
| `MalformedPOSTRequest` | The body of the request does not match the `multipart/form-data` format. | 400 Bad Request |
| `MalformedXML` | The provided XML document is malformed or does not conform to the schema. | 400 Bad Request |
| `MaxMessageLengthExceeded` | The maximum allowed request length is exceeded. | 400 Bad Request |
| `MaxPostPreDataLengthExceededError` | The HTTP message header has exceeded the allowed length. | 400 Bad Request |
| `MetadataTooLarge` | The metadata headers exceeded the allowed size. | 400 Bad Request |
| `MethodNotAllowed` | The HTTP method is not allowed for the specified resource. | 405 Method Not Allowed |
| `MissingContentLength` | Add `Content-Length` to the headers. | 411 Length Required |
| `MissingRequestBodyError` | The request body is empty.<br/><br/>Occurs when sending an empty XML document. | 400 Bad Request |
| `MissingSecurityHeader` | The required header is missing. | 400 Bad Request |
| `NoLoggingStatusForKey` | There is no logging status for the key. | 400 Bad Request |
| `NoSuchBucket` | The specified bucket does not exist. | 404 Not Found |
| `NoSuchKey` | The specified key does not exist. | 404 Not Found |
| `NoSuchUpload` | The specified multipart upload does not exist.<br/><br/>This error occurs in the following cases:<br/>- Invalid upload ID is specified.<br/>- Upload is aborted.<br/>- Upload is complete. | 404 Not Found |
| `NotImplemented` | The passed header is not handled by [!KEYREF objstorage-name]. | 501 Not Implemented |
| `NotSignedUp` | Use of [!KEYREF objstorage-name] is not allowed for this account. | 403 Forbidden |
| `OperationAborted` | Conflicting conditional operations. | 409 Conflict |
| `PermanentRedirect` | The specified bucket should always be accessed using the address returned in the response. | 301 Moved Permanently |
| `Redirect` | The specified bucket should temporarily be accessed using the address returned in the response. | 307 Moved Temporarily |
| `RequestIsNotMultiPartContent` | The request must contain data of the `multipart/form-data` type. | 400 Bad Request |
| `RequestTimeout` | Read/write timeout. | 400 Bad Request |
| `RequestTimeTooSkewed` | The request sending time is too different from the server time. | 403 Forbidden |
| `SignatureDoesNotMatch` | The provided request signature does not match the one calculated by [!KEYREF objstorage-name]. | 403 Forbidden |
| `ServiceUnavailable` | [!KEYREF objstorage-name] is not available.<br/>Reduce your request rate. | 503 Service Unavailable |
| `SlowDown` | Reduce your request rate. | 503 Slow Down |
| `TemporaryRedirect` | Redirect while the DNS is being updated. | 307 Moved Temporarily |
| `TokenRefreshRequired` | Refresh your token. | 400 Bad Request |
| `TooManyBuckets` | Exceeded the bucket number limit. | 400 Bad Request |
| `UnexpectedContent` | The request must not contain this content. | 400 Bad Request |
| `UnresolvableGrantByEmailAddress` | The email address you provided does not match any recorded account. | 400 Bad Request |
| `UserKeyMustBeSpecified` | The request must contain the header specified in the error description. | 400 Bad Request |

