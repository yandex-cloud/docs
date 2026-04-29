The `iam.serviceAccounts.keyAdmin` role enables managing access keys for service accounts, including static, ephemeral, authorized, and API keys.

Users with this role can:
* View the list of service accounts' [static access keys](../../../iam/concepts/authorization/access-key.md) and info on them, as well as create, modify, and delete them.
* View the list of service accounts' [API keys](../../../iam/concepts/authorization/api-key.md) and info on them, as well as create, modify, and delete them.
* View info on service accounts' [authorized keys](../../../iam/concepts/authorization/key.md), as well as create, modify, and delete them.
* Create [ephemeral access keys](../../../iam/concepts/authorization/ephemeral-keys.md) for service accounts.

This role includes the `iam.serviceAccounts.accessKeyAdmin`, `iam.serviceAccounts.apiKeyAdmin`, and `iam.serviceAccounts.authorizedKeyAdmin` permissions.