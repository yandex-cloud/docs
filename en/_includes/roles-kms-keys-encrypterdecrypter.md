### kms.keys.encrypterDecrypter {#kms-keys-encrypterdecrypter}

The key user role `kms.keys.encrypterDecrypter` includes the following permissions:

- Getting information on keys and versions.
- [Encryption and decryption](../kms/api-ref/SymmetricCrypto/).

{% include [roles-editor-includes-permissions](iam/roles-editor-includes-permissions.md) %}

You can now assign this role to a [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../resource-manager/concepts/resources-hierarchy.md#folder), and [key](../kms/concepts/key).

A {{ kms-short-name }} administrator (`kms.admin`) can grant this role.

For more information on using roles in {{ kms-name }}, read [{#T}](../kms/security/index.md).

