#### How can I fix the no permission error when connecting a service account to the cluster? {#attach-service-account}

Error message:

```text
ERROR: rpc error: code = PermissionDenied desc = you do not have permission to access the requested service account or service account does not exist
```

This error occurs if you link a service account to a cluster while creating or modifying it.

To fix this error, [assign](../iam/operations/roles/grant.md) your {{ yandex-cloud }} account the [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user) role or higher.
