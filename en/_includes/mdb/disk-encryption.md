When creating or restoring a cluster from a backup, you can encrypt the storage disk with a [custom KMS key](../../kms/concepts/key.md). To encrypt a disk of an already created cluster, disable encryption, or encrypt a disk with a different key, create a backup of the cluster and restore it with the new settings.

{% note warning %}

Encryption is not available for local disks (`local-hdd` and `local-ssd`).

{% endnote %}

{% include [encryption-role](../compute/encryption-role.md) %}

If you deactivate the key used to encrypt a disk, access to the data will be suspended until you reactivate the key.

{% note alert %}

If you delete the key used to encrypt a disk or its [version](../../kms/concepts/version.md), you will irrevocably lose access to your data. For more information, see [this {{ kms-name }} article](../../kms/concepts/version.md#version-distruct).

{% endnote %}
