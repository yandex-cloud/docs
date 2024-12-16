---
title: How to encrypt a disk in {{ compute-full-name }}
description: Follow this guide to encrypt a disk.
---

# Encrypting a disk

1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
1. [Create](../image-create/create-from-disk.md) an image of the disk you want to encrypt.
1. Create an encrypted disk from the image:

    {% include [encryption-disk-from-image](../../../_includes/compute/encryption-disk-from-image.md) %}

1. [Delete](../image-control/delete.md) the image.
1. [Delete](../disk-control/delete.md) the unencrypted disk.

### See also {#see-also}


* [{#T}](../../concepts/encryption.md)
* [{#T}](../snapshot-control/snapshot-encrypt.md)
