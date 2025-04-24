# Response status codes

In response to a request, {{ speechkit-name }} returns a message containing the request code and processing status. If there is an error processing the request, the message will also include its possible cause.

When analyzing the models' responses in your app, go by request code and status. Error messages contain useful information but may change after you update the service.

gRPC | REST | Status               | Reason                          | Solution
 --- | ---- | -------------------- | -------------------------------- |---
0    | 200  | `OK`                 | Operation completed               | —
3    | 400  | `INVALID_ARGUMENT`   | Invalid request              | Check the request format. The URI or query parameters may be incorrect.
4    | 504  | `DEADLINE_EXCEEDED`  | Request timed out | Network issues between the client and server. Try again or [contact support](../../support/overview.md).
7    | 403  | `PERMISSION_DENIED`  | Not enough permissions                | Make sure the [service account](../../speechkit/security/index.md) you are using to send your request has the required [roles](../../iam/concepts/users/service-accounts.md).
8    | 429  | `RESOURCE_EXHAUSTED` | [Quota](../../speechkit/concepts/limits.md) exceeded | Depending on your quota, wait or contact support to increase your quota.
12   | 501  | `UNIMPLEMENTED`      | Service-side problem      | Contact support.
13   | 500  | `INTERNAL`           | Internal service error        | Contact support.
14   | 503  | `UNAVAILABLE`        | Service unavailable                | Try again or contact support.
16   | 401  | `UNAUTHENTICATED`    | Authorization error               | Check that you are using the correct account, [API key](../../iam/concepts/authorization/api-key.md), and [IAM token](../../iam/concepts/authorization/iam-token.md), and that the token has not expired.

