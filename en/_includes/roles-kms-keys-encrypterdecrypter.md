#### kms.keys.encrypterDecrypter {#kms-keys-encrypterdecrypter}

The key user role `kms.keys.encrypterDecrypter` includes the following permissions:

* Getting information on keys and versions.
* [Encrypt](../kms/operations/symmetric-encryption.md#encryption) and [decrypt](../kms/operations/symmetric-encryption.md#decryption) data.

{% include [roles-editor-includes-permissions](iam/roles-editor-includes-permissions.md) %}

You can now assign this role to an [organization](../organization/), [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../resource-manager/concepts/resources-hierarchy.md#folder), or [key](../kms/concepts/key).

A {{ kms-short-name }} administrator can grant a role (the `kms.admin` role).

For more information on using roles in {{ kms-name }}, read [{#T}](../kms/security/index.md).