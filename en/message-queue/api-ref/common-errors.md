---
title: Potential errors when using the {{ message-queue-full-name }} API
description: In this tutorial, you will learn about the potential errors when using the {{ message-queue-name }} API.
---

# Common errors

| HTTP | Error code | Description |
----- | ----- | -----
| 400 | `AccessDeniedException` | Insufficient permissions to perform the action. |
| 400 | `IncompleteSignature` | The request signature does not conform to AWS standards. |
| 500 | `InternalFailure` | Unknown error. |
| 400 | `InvalidAction` | The `Action` parameter value is unknown. |
| 403 | `InvalidClientTokenId` | Invalid service account key. |
| 400 | `InvalidParameterCombination` | Simultaneous use of two incompatible parameters. |
| 400 | `InvalidParameterValue` | The parameter value is incorrect or outside of the allowed range. |
| 400 | `InvalidQueryParameter` | A nonexistent parameter is used. |
| 404 | `MalformedQueryString` | The query string contains a syntax error. |
| 400 | `MissingAction` | The request is missing an `Action`. |
| 403 | `MissingAuthenticationToken` | The service account key ID is missing. |
| 400 | `MissingParameter` | A parameter required for performing the action is missing. |
| 400 | `OptInRequired` | The service account key ID requires a subscription to the service. |
| 400 | `RequestExpired` | The service received a request more than 15 minutes later than the request timestamp, or more than 15 minutes after the request expired, or the request timestamp is more than 15 minutes ahead of the service time. |
| 503 | `ServiceUnavailable` | The service is not available. |
| 403 | `ThrottlingException` | The request was rejected due to the throttle limit. |
| 400 | `ValidationError` | Values of a sent request failed validation. |
