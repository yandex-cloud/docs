### Encryption of disks and virtual machine snapshots is used {#managed-vm-kms}

#|
|| **kind** | **severity** | **ID** ||
|| manual | medium | crypto.managed-vm-kms ||
|#

#### Description

{% note warning "**Manual check**" %}

This rule requires manual verification of disk encryption settings.

{% endnote %}

By default, all data on Yandex Compute Cloud disks is encrypted at the storage database level using a system key. This protects your data from being compromised in the event of a physical theft of disks from Yandex Cloud data centers.

We also recommend encrypting disks and [disk snapshots](https://yandex.cloud/en/docs/compute/concepts/snapshot) using [Yandex Key Management Service custom symmetric keys](https://yandex.cloud/en/docs/kms/concepts/key). This approach allows you to:

* Protect against the potential threats of data isolation breach and compromise at the virtual infrastructure level.

* Control the encryption and lifecycle of KMS keys, as well as manage them. For more information, see [Key management](https://yandex.cloud/en/docs/kms/operations/key).

* Improve access control to the data on your disk by setting permissions for KMS keys. For more information, see [Configuring access permissions for a symmetric encryption key](https://yandex.cloud/en/docs/kms/operations/key-access).

* Use Yandex Audit Trails to track encryption and decryption operations performed using your KMS key. For more information, see [Key usage audit](https://yandex.cloud/en/docs/kms/concepts/#keys-audit).

You can encrypt the following types of disks:

* Network SSD (`network-ssd`)
* Network HDD (`network-hdd`)
* Non-replicated SSD (`network-ssd-nonreplicated`)
* Ultra-fast network storage with three replicas (SSD) (`network-ssd-io-m3`)

#### Guides and solutions

* [Encrypt the disk of your Yandex Compute Cloud VM](https://yandex.cloud/en/docs/compute/operations/disk-control/disk-encrypt)
