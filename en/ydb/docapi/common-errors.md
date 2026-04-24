---
title: Common errors when using the Document API in {{ ydb-full-name }}
description: This page describes the list of errors that are common to all the Document API methods.
sourcePath: overlay/docapi/api-ref/common-errors.md
---
# Common errors when using the Document API

Here are the errors that are common to all the Document API methods:

Error code | Error description | HTTP status code
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
`MissingAction` | Missing a method or required parameter in the request. | 400
`MissingAuthenticationToken` | The request must include a valid access key ID or X.509 certificate. | 403
`MissingParameter` | Required parameter missing. | 400
`NotAuthorized` | No permission to perform this action. | 400
`OptInRequired` | The specified access key is not subscribed to this service. | 403
`RequestExpired` | The request was received more than 15 minutes after its timestamp, or more than 15 minutes after it is expired, or the request timestamp is more than 15 minutes into the future. | 400
`ServiceUnavailable` | Temporary server-side failure. | 503
`ThrottlingException` | The request was throttled. | 400
`ValidationError` | Input data does not pass validation. | 400
