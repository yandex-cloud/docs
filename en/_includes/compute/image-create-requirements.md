For boot disk images, the following requirements apply:

{% include [image-create-requirements-sub1](./image-create-requirements-sub1.md) %}

* Depending on the [hardware generation](../../compute/concepts/hardware-generations.md) that will be assigned to the new image, the boot disk requires different partition table formats:

    * `Gen 1.1` and `Gen 1.2`: Use [MBR](https://en.wikipedia.org/wiki/Master_boot_record) partitioning for the boot disk.
    * `Gen 2`: Use [GPT](https://en.wikipedia.org/wiki/GUID_Partition_Table) partitioning for the boot disk.

{% include [image-create-requirements-sub2](./image-create-requirements-sub2.md) %}
