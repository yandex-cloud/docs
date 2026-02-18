---
title: Error codes {{ foundation-models-name }}
description: In response to any request, {{ foundation-models-name }} models return a message containing a request processing code and status. If there is an error processing the request, the message will also include its possible cause.
---

# Error codes

In response to any request, {{ foundation-models-name }} models return a message containing a request processing code and status. If there is an error processing the request, the message will also include its possible cause.

When processing model responses in your app, refer to the request code and status. Error messages contain useful information, but may change with model updates.

| gRPC | REST | Status | Cause | Solution |
|---|---|---|---|---|
| 0 | 200 | `OK` | Operation completed | — |
| 3 | 400 | `INVALID_ARGUMENT` | Invalid request | Check the request format. You may have provided an incorrect model URI, exceeded prompt length, set an invalid parameter value, or failed to comply with the {{ yandexart-name }} ethical guidelines. <br/> For example, to resolve the `invalid model_uri`, `Failed to parse model URI` errors, check that you have entered the correct model URI and specified the folder ID. <br/> An error of the `Specified folder ID does not match with service account` type means the folder ID is incorrect or the service account sending the request does not have access to the specified folder. Check which account you are sending the request from. |
| 4 | 504 | `DEADLINE_EXCEEDED` | Request timed out | There is a network issue between the client and the server, or the response timeout has been exceeded. Try sending your request again. In {{ ml-sdk-name }}, use the `config.run(timeout)` [method](../sdk-ref/sync/chat/completions.md#yandex_ai_studio_sdk._chat.completions.model.ChatModel) to increase the timeout. If the issue persists, contact [support](../../support/overview.md). |
| 7 | 403 | `PERMISSION_DENIED` | Not enough permissions | Check that: <ul><li>[Service account](../../iam/concepts/users/service-accounts.md) you are using to send your request has the required [roles](../security/index.md).</li><li>You can access the model, if access is provided upon request.</li><li>Your billing account is linked to the cloud and the cloud’s status is not `CREATING`.</li></ul> |
| 8 | 429 | `RESOURCE_EXHAUSTED` | [Quota](../concepts/limits.md) exceeded | Depending on your quota, wait or contact support to increase your quota. When requesting a quota increase, specify the model, working mode, and the name of the quota to increase. Our support team may request additional information. |
| 12 | 501 | `UNIMPLEMENTED` | Service-side issue | Contact support. |
| 13 | 500 | `INTERNAL` | Internal service error | Contact support. |
| 14 | 503 | `UNAVAILABLE` | Service unavailable | Try again or contact support. |
| 16 | 401 | `UNAUTHENTICATED` | Authorization error | Check that you are using the correct account, [API key](../../iam/concepts/authorization/api-key.md), and [IAM token](../../iam/concepts/authorization/iam-token.md), and that the token has not expired. Error messages may contain information about the error. For example, `Unknown api key` indicates the API key or its scope is incorrect, and `The apikey has expired`, the API key has expired. |