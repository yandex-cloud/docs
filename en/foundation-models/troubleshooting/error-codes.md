---
title: Error codes {{ foundation-models-name }}
description: In response to any request, {{ foundation-models-name }} models return a message containing a request processing code and status. If there is an error processing a request, the message will also include its possible cause.
---

# Error codes

In response to any request, {{ foundation-models-name }} models return a message containing a request processing code and status. If there is an error processing the request, the message will also include its possible cause.

When analyzing the models' responses in your app, go by request code and status. Error messages contain useful information, but may change after model updates.

| gRPC | REST | Status | Reason | Solution |
|---|---|---|---|---|
| 0 | 200 | `OK` | Operation completed | — |
| 3 | 400 | `INVALID_ARGUMENT` | Invalid request | Check the request format. You may have specified an incorrect model URI, exceeded the prompt length, set an invalid parameter value, or failed to comply with {{ yandexart-name }} ethical guidelines. |
| 4 | 504 | `DEADLINE_EXCEEDED` | Request timed out | Network issues between the client and server. Try again or [contact support](../../support/overview.md). |
| 7 | 403 | `PERMISSION_DENIED` | Not enough permissions | Make sure that the [service account](../../iam/concepts/users/service-accounts.md) you are using to send your request has the required [roles](../security/index.md). If access to the model you selected is provided upon request, make sure you have obtained it. When accessing a model fine-tuned in {{ ml-platform-name }}, [add](../../datasphere/operations/projects/add-user.md) the account to the member list of the project that stores the fine-tuned model. |
| 8 | 429 | `RESOURCE_EXHAUSTED` | [Quota](../concepts/limits.md) exceeded | Depending on your quota, wait or contact support to increase your quota. When requesting a quota increase, specify the model, working mode, and the name of the quota to increase. Our support team may request additional information. |
| 12 | 501 | `UNIMPLEMENTED` | Service-side problem | Contact support. |
| 13 | 500 | `INTERNAL` | Internal service error | Contact support. |
| 14 | 503 | `UNAVAILABLE` | Service unavailable | Try again or contact support. |
| 16 | 401 | `UNAUTHENTICATED` | Authorization error | Check that you are using the correct account, [API key](../../iam/concepts/authorization/api-key.md), and [IAM token](../../iam/concepts/authorization/iam-token.md), and that the token has not expired. |