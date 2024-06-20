# Error codes

If a server malfunctions or request is invalid, the response will contain an error code with a message.


| gRPC code | HTTP code | Error | Solution |
|---|---|---|---|
| 7 | 403 | Not enough permissions | Make sure that the account you are using to submit your request has the required roles and there is a match between the account and the token. |
| 8 | 429 | [Quota](../concepts/limits.md) exceeded | Depending on your quota, wait or contact support to increase your quota |
