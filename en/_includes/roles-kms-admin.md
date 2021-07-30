### kms.admin {#kms-admin}

The key administrator role `kms.admin` includes the following permissions:

- Get a list of keys in a folder.
- [Create](../kms/operations/key.md#create) and [update](../kms/operations/key.md#update) a key.
- [Rotate a key](../kms/operations/key.md#rotate) and [change the primary version](../kms/operations/version.md#make-primary).
- [Destroy a key](../kms/operations/key.md#delete) and [version](../kms/operations/version.md#delete).
- [Grant a role]( ../iam/operations/roles/grant.md), [revoke a role]( ../iam/operations/roles/revoke.md), and view roles granted for a resource

These permissions are also part of the `admin` and `resource-manager.clouds.owner` roles.

You can now assign this role to a [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../resource-manager/concepts/resources-hierarchy.md#folder), and [key](../kms/concepts/key).

A cloud owner (`resource-manager.clouds.owner` role) and an administrator (`admin` role) can grant this role.

