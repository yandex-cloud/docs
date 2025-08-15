---
title: Common {{ yds-full-name }} API request errors
description: Learn what errors may occur in API requests.
---

# Common errors

If an error occurs, the API returns a relevant HTTP status code and error details in JSON format:

```json
{
  "__type": "string",
  "message": "string"
}
```

Parameter | Description
----- | -----
`__type` | Error type.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z0-9_.-]+`<br/>**Required**: Yes
`message` | Error message.<br/><br/>**Type**: String<br/>**Size**: `1`-`128` characters.<br/>**The possible values are**: `[a-zA-Z0-9_.-]+`<br/>**Required**: Yes

Error response example:

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

Errors common to all {{ yds-name }} methods:

Error type | Error description | HTTP status code
----- | ----- | -----
`AccessDeniedException` | Access denied for this operation. | 400
`IncompleteSignature` | Invalid request signature format. | 400
`InternalFailure` | Unknown internal error. | 500
`InvalidAction` | Invalid method. Make sure you have spelled the method name correctly. | 400
`InvalidClientTokenId` | X.509 certificate or access key not found. | 403
`InvalidParameterCombination` | You have specified parameters that cannot be used together. | 400
`InvalidParameterValue` | Invalid parameter value. | 400
`InvalidQueryParameter` | Invalid query string format. | 400
`MalformedQueryString` | Query string syntax error. | 404
`MissingAction` | Missing method or required parameter in request. | 400
`MissingAuthenticationToken` | The request must include a valid access key ID or X.509 certificate. | 403
`MissingParameter` | Required parameter missing. | 400
`NotAuthorized` | No permission to perform this action. | 400
`OptInRequired` | The specified access key is not subscribed to this service. | 403
`RequestExpired` | The request was received more than 15 minutes after its timestamp, or more than 15 minutes after it is expired, or the request timestamp is more than 15 minutes in the future. | 400
`ServiceUnavailable` | Temporary server failure. | 503
`ThrottlingException` | The request was throttled. | 400
`ValidationError` | Input data does not pass validation. | 400
