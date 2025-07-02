{% note warning %}

To run the scan, make sure the service account is [assigned](../../iam/operations/sa/assign-role-for-sa.md) the `storage.viewer` [role](../../storage/security/index.md#storage-viewer) for all buckets you want to scan. If the buckets are [encrypted](../../storage/concepts/encryption.md), your service account also needs the `kms.keys.decrypter` [role](../../kms/security/index.md#kms-keys-decrypter) for the relevant {{ kms-full-name }} [encryption keys](../../kms/concepts/key.md).

{% endnote %}