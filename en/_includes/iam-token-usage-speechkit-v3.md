Specify the received IAM token when accessing {{ yandex-cloud }} resources via the API. Pass the following parameters in the request:
* Specify the [IAM token](../iam/concepts/authorization/iam-token.md) in the `Authorization` header.
* Specify the [folder ID](../resource-manager/operations/folder/get-id.md) in the `x-folder-id` parameter.

```
Authorization: Bearer <IAM token>
x-folder-id <folder ID>
```
