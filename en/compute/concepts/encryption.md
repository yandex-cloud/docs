---
title: Encryption in {{ compute-full-name }}
description: In this article, you will learn about {{ compute-name }} encryption options and the use of {{ kms-short-name }} user keys.
---

# Encryption in {{ compute-name }}


By default, all data on {{ compute-name }} [disks](../../compute/concepts/disk.md) is encrypted at the storage database level using a system key. This protects your data from being compromised in the event of a physical theft of disks from {{ yandex-cloud }} data centers. For more information, see [{#T}](../../security/standarts.md#sec-data).

We also recommend encrypting disks, [snapshots](snapshot.md), and [images](image.md) using custom {{ kms-full-name }} [symmetric keys](../../kms/concepts/key.md). This approach allows you to:
* Protect yourself against potential threats of isolation breach and data compromise at the virtual infrastructure level.
* Control and manage the encryption and lifecycle of {{ kms-short-name }} keys. See [{#T}](../../kms/operations/key.md).
* Improve data access control for your disk by requiring permissions for {{ kms-short-name }} keys. See [{#T}](../../kms/operations/key-access.md).
* Follow encryption and decryption operations performed using your {{ kms-short-name }} key with the help of {{ at-full-name }}. See [Key usage audit](../../kms/concepts/index.md#keys-audit).

You can encrypt the following types of disks:
* Network SSD (`network-ssd`)
* Network HDD (`network-hdd`)
* Non-replicated SSD (`network-ssd-nonreplicated`)
* Ultra high-speed network storage with three replicas (SSD) (`network-ssd-io-m3`)

For more details, see [Disk types](disk.md#disks-types).

{% include [encryption-disable-warning](../../_includes/compute/encryption-disable-warning.md) %}

In {{ compute-name }}, encryption is available from the [management console]({{ link-console-main }}), [CLI](../cli-ref/disk/create.md), and [API](../api-ref/Disk/create.md).

## Encryption options {#encryption-options}

The table below lists the methods you can use to create encrypted {{ compute-name }} resources and some features of {{ kms-short-name }} keys:

| **Target resource** | **Source resource** | **Key** | **Note** |
| --- | --- | --- | --- |
| Empty encrypted disk | —                      | Any       | See [{#T}](../operations/disk-create/empty.md). |
| Encrypted disk        | Unencrypted image  | Any       | See [{#T}](../operations/disk-create/from-image.md).</br>You can also use an image to</br>encrypt existing [disks](../operations/disk-control/disk-encrypt.md) and [snapshots](../operations/snapshot-control/snapshot-encrypt.md). |
| Encrypted disk        | Encrypted image    | Image key | See [{#T}](../operations/disk-create/from-image.md).</br>You can also use an encrypted</br>image to make a copy of</br>an encrypted disk. |
| Encrypted disk        | Unencrypted snapshot | Any       | See [{#T}](../operations/disk-create/from-snapshot.md). |
| Encrypted disk        | Encrypted snapshot   | Snapshot key | See [{#T}](../operations/disk-create/from-snapshot.md). |
| Encrypted image       | Encrypted disk     | Disk key  | See [{#T}](../operations/image-create/create-from-disk.md). |
| Encrypted snapshot      | Encrypted disk     | Disk key  | See [{#T}](../operations/disk-control/create-snapshot.md). |

## Using custom keys {#user-keys}

By using custom {{ kms-short-name }} keys for disk and snapshot encryption, you can achieve more granular control over access to encrypted data: create custom keys for specific users or tasks, timely deactivate or delete specific keys.

{% include [encryption-keys-note](../../_includes/compute/encryption-keys-note.md) %}

To use encryption in {{ compute-name }}, the user must have the `kms.keys.user` or `kms.admin` role for the key used for encryption. These [roles](../../kms/security/index.md#kms-admin) enable you to do the following:

* Create an encrypted disk.
* Create a VM with an encrypted disk.
* Attach an encrypted disk to an existing VM.
* Start and restart a VM with an encrypted disk.

For more information, see [Access management](../../kms/security/index.md).


### See also {#see-also}

* [Data encryption and key and secret management](../../security/standard/encryption.md)
* [{#T}](../operations/disk-control/disk-encrypt.md)
* [{#T}](../operations/image-control/encrypt.md)
* [{#T}](../operations/snapshot-control/snapshot-encrypt.md)

