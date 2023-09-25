# Зашифровать снимок

1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
1. [Создайте](../image-create/create-from-snapshot.md) образ из снимка.
1. Создайте зашифрованный диск из образа:

    {% include [encryption-disk-from-image](../../../_includes/compute/encryption-disk-from-image.md) %}

1. [Создайте](../disk-control/create-snapshot.md) снимок из зашифрованного диска, созданного ранее.
1. [Удалите](../disk-control/delete.md) зашифрованный диск.
1. [Удалите](../image-control/delete.md) образ.
1. [Удалите](delete.md) исходный снимок.


### См. также

* [{#T}](../../concepts/encryption.md)
* [{#T}](../disk-control/disk-encrypt.md)
