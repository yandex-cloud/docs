---
title: Common errors when making requests to the {{ ydb-full-name }} API
description: See below what errors may occur when making API requests.
---

# Common errors

In case of an error, the corresponding HTTP response code and data in JSON format are returned:

```json
{
  "__type": "string",
  "message": "string"
}
```

| Parameter | Description |
----- | -----
| `__type` | Type of error.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z0-9_.-]+`<br/>**Required**: Yes |
| `message` | Error message.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**Possible values**: `[a-zA-Z0-9_.-]+`<br/>**Required**: Yes |

Sample response with an error message:

```http
HTTP/1.1 400 Bad Request
x-amzn-RequestId: <RequestId>
Content-Type: application/x-amz-json-1.1
Content-Length: <PayloadSizeBytes>
Date: <Date>
{
  "__type":"ResourceInUseException",
  "message":"Stream whatever under account 177492702984 already exists."
}
```

Errors that are common to all {{ yds-name }} methods:

| Error type | Error description | HTTP status code |
----- | ----- | -----
| `AccessDeniedException` | No permission to perform the requested operation. | 400 |
| `IncompleteSignature` | The request signature does not conform to the standards. | 400 |
| `InternalFailure` | Unknown internal error. | 500 |
| `InvalidAction` | Invalid method. Check if the method name is written correctly. | 400 |
| `InvalidClientTokenId` | X.509 certificate or access key not found. | 403 |
| `InvalidParameterCombination` | Parameters that can't be used simultaneously are specified. | 400 |
| `InvalidParameterValue` | Invalid parameter value. | 400 |
| `InvalidQueryParameter` | Invalid query string format. | 400 |
| `MalformedQueryString` | Syntax error in a query string. | 404 |
| `MissingAction` | Missing query method or required parameter. | 400 |
| `MissingAuthenticationToken` | The query must contain a valid access key ID or an X.509 certificate. | 403 |
| `MissingParameter` | Required parameter missing. | 400 |
| `NotAuthorized` | No permission to perform this action. | 400 |
| `OptInRequired` | The specified access key is not subscribed to this service. | 403 |
| `RequestExpired` | The request was received more than 15 minutes after the date specified in it, or more than 15 minutes after the request expired, or the specified date is 15 or more minutes ahead. | 400 |
| `ServiceUnavailable` | Temporary failure on the server side. | 503 |
| `ThrottlingException` | The request was denied due to request throttling. | 400 |
| `ValidationError` | Input data doesn't meet the restrictions. | 400 |
