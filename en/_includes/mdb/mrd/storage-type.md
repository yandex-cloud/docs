
When creating a cluster, you can choose between the following storage types:

* SSD network storage (`network-ssd`): A middle-ground solution. It's slower than local SSD storage, but unlike local disks, it ensures data integrity if {{ yandex-cloud }} hardware goes down.

* Non-replicated SSD storage (`network-ssd-nonreplicated`): SSD network storage with enhanced performance that is implemented by eliminating redundancy.

  This type of storage is only available for **Intel Cascade Lake** and **Intel Ice Lake**. For a list of host classes and their respective platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

  The storage size can only be increased in increments of 93 GB.

* Local SSD storage (`local-ssd`): The fastest disks.

  This type of storage is only available for **Intel Broadwell** and **Intel Cascade Lake**. For a list of host classes and their respective platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

  The storage size can only be increased in increments of 100 GB.

