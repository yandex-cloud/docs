# Encrypting a snapshot

1. {% include [encryption-preparations](../../../_includes/compute/encryption-preparations.md) %}
1. [Create](../image-create/create-from-snapshot.md) an image from the snapshot.
1. Create an encrypted disk from the image: 

   {% include [encryption-disk-from-image](../../../_includes/compute/encryption-disk-from-image.md) %}

1. [Create](../disk-control/create-snapshot.md) a snapshot from the encrypted disk created earlier.
1. [Delete](../disk-control/delete.md) the encrypted disk.
1. [Delete](../image-control/delete.md) the image.
1. [Delete](delete.md) the source snapshot.


### See also

* [{#T}](../../concepts/encryption.md)
* [{#T}](../disk-control/disk-encrypt.md)
