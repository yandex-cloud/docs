#### How can I fix the no permission error when connecting a service account to the cluster? {#attach-service-account}

Error message:

```text
ERROR: rpc error: code = PermissionDenied desc = you do not have permission to access the requested service account or service account does not exist
```

The error occurs in the following cases:

* You are creating or modifying a cluster and linking it to a service account.
* You are restoring a cluster linked to a service account from its backup.

To fix this error, [assign](../iam/operations/roles/grant.md) your {{ yandex-cloud }} account the [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) role or higher.
