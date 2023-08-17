
When creating a cluster, you can choose between the following storage types:

* **Network SSD storage** (`network-ssd`): Balanced solution. Such disks are slower than local SSD storage, but, unlike local disks, they ensure data integrity in case {{ yandex-cloud }} hardware goes down.
* **Non-replicated SSD storage** (`network-ssd-nonreplicated`): Network SSD storage with enhanced performance but without redundancy.

  This disk type is only available for **Intel Cascade Lake** and **Intel Ice Lake**. For a list of host classes and their respective platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

  The storage size can only be increased in increments of 93 GB.

* **Local SSD storage** (`local-ssd`): Disks with the fastest performance.

  This disk type is only available for **Intel Broadwell** and **Intel Cascade Lake**. For a list of host classes and their respective platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

  The storage size can only be increased in increments of 100 GB.

