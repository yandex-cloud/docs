#### kms.editor {#kms-editor}

The `kms.editor` role includes the following permissions:

* Get a list of keys in a folder.
* [Create](../kms/operations/key.md#create) and [update](../kms/operations/key.md#update) a key.
* [Encrypt](../kms/operations/encryption.md#encryption) and [decrypt](../kms/operations/encryption.md#decryption) data.
* [Rotate a key](../kms/operations/key.md#rotate).

You can now assign this role to an [organization](../organization/), [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../resource-manager/concepts/resources-hierarchy.md#folder), or [key](../kms/concepts/key).

A {{ kms-short-name }} administrator can grant a role (the `kms.admin` role).

For more information on using roles in {{ kms-name }}, read [{#T}](../kms/security/index.md).