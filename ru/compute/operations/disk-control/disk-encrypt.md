# Зашифровать диск

1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
1. [Создайте](../image-create/create-from-disk.md) образ из диска, который вы хотите зашифровать.
1. Создайте зашифрованный диск из образа:

    {% include [encryption-disk-from-image](../../../_includes/compute/encryption-disk-from-image.md) %}

1. [Удалите](../image-control/delete.md) образ.
1. [Удалите](../disk-control/delete.md) незашифрованный диск.

### См. также

* [{#T}](../../concepts/encryption.md)
* [{#T}](../snapshot-control/snapshot-encrypt.md)
