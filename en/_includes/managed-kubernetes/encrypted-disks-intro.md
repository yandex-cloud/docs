{{ managed-k8s-name }} supports the use of {{ compute-name }} disks [encrypted](../../compute/concepts/encryption.md) with custom {{ kms-full-name }} [symmetric keys](../../kms/concepts/key.md) for persistent volumes.

{% note info %}

To use encrypted disks, the [cloud service account](../../managed-kubernetes/concepts/index.md#service-accounts) assigned to your {{ managed-k8s-name }} cluster must have the `kms.keys.encrypterDecrypter` [role](../../kms/security/index.md#kms-keys-encrypterDecrypter) for the key or folder.

{% endnote %}