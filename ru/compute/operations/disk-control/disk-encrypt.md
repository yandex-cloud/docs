---
title: Как зашифровать диск в {{ compute-full-name }}
description: Следуя данной инструкции, вы сможете зашифровать диск.
---

# Зашифровать диск

1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
1. [Создайте](../image-create/create-from-disk.md) образ из диска, который вы хотите зашифровать.
1. Создайте зашифрованный диск из образа:

    {% include [encryption-disk-from-image](../../../_includes/compute/encryption-disk-from-image.md) %}

1. [Удалите](../image-control/delete.md) образ.
1. [Удалите](../disk-control/delete.md) незашифрованный диск.

### См. также {#see-also}


* [{#T}](../../concepts/encryption.md)
* [{#T}](../snapshot-control/snapshot-encrypt.md)
