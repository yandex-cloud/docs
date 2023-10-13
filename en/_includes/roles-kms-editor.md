#### kms.editor {#kms-editor}

The `kms.editor` role includes the following permissions:

* Get a list of keys in a folder.
* [Create](../kms/operations/key.md#create) and [update](../kms/operations/key.md#update) keys.
* Symmetrically [encrypt](../kms/operations/symmetric-encryption.md#encryption) and [decrypt](../kms/operations/symmetric-encryption.md#decryption) data.
* Create asymmetric encryption and signature keys.
* Sign data with a private signature key.
* Decrypt data with a private encryption key.
* Get a public part of an encryption and signature key.
* [Rotate a key](../kms/operations/key.md#rotate).

You can now assign this role to an [organization](../organization/), [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud), [folder](../resource-manager/concepts/resources-hierarchy.md#folder), or [key](../kms/concepts/key).

This role can be granted by a {{ kms-short-name }} administrator (`kms.admin`).

For more information on using roles in {{ kms-name }}, read [{#T}](../kms/security/index.md).