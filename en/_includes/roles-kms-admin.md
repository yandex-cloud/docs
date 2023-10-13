#### kms.admin {#kms-admin}

The key administrator role `kms.admin` includes the following permissions:

* Get a list of keys in a folder.
* [Create](../kms/operations/key.md#create) and [update](../kms/operations/key.md#update) a key.
* [Encrypt](../kms/operations/symmetric-encryption.md#encryption) and [decrypt](../kms/operations/symmetric-encryption.md#decryption) data.
* [Rotate a key](../kms/operations/key.md#rotate) and [change the primary version](../kms/operations/version.md#make-primary).
* [Delete encryption keys](../kms/operations/key.md#delete) and signatures, [delete versions](../kms/operations/version.md#delete).
* Cancel key deletion.
* Update a key status (active/inactive).
* [Grant a role](../iam/operations/roles/grant.md), [revoke a role](../iam/operations/roles/revoke.md), and view roles granted for the key.

These permissions are also part of the `admin` and `resource-manager.clouds.owner` roles.

You can now assign this role to an [organization](../organization/), [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../resource-manager/concepts/resources-hierarchy.md#folder), or [key](../kms/concepts/key).
