#### kms.keys.encrypter {#kms-keys-encrypter}

The key user role `kms.keys.encrypter` includes the following permissions:

* Getting information on keys and versions.
* [Encrypting](../kms/operations/symmetric-encryption.md#encryption) data.

{% include [roles-crypt-includes-permissions](iam/roles-crypt-includes-permissions.md) %}

You can now assign this role to an [organization](../organization/), [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../resource-manager/concepts/resources-hierarchy.md#folder), or [key](../kms/concepts/key).

A {{ kms-short-name }} administrator can grant a role (the `kms.admin` role).

For more information on using roles in {{ kms-name }}, read [{#T}](../kms/security/index.md).