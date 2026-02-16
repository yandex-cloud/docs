The `lockbox.admin` role enables managing secrets, their versions, and access to them, as well as viewing secret contents.

Users with this role can:
* View info on [access permissions](../../iam/concepts/access-control/index.md) assigned to secrets and modify such permissions.
* View info on [secrets](../../lockbox/concepts/secret.md#secret), including secret contents.
* Create, activate, deactivate, and delete secrets.
* Modify secret [version](../../lockbox/concepts/secret.md#version) metadata, create and delete secret versions, as well as change current secret versions, schedule deleting a secret version, or cancel a scheduled deletion.
* View information on the relevant [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
* View details on Yandex Lockbox [quotas](../../lockbox/concepts/limits.md#quotas).

This role includes the `lockbox.editor` and `lockbox.payloadViewer` permissions.