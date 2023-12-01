
When creating a cluster, you can select the following disk types for data storage:

* **Network SSD storage** (`network-ssd`): Balanced solution. Such disks are slower than local SSD storage, but, unlike local disks, they ensure data integrity in case {{ yandex-cloud }} hardware goes down.
* **Non-replicated SSD storage** (`network-ssd-nonreplicated`): Network SSD storage with enhanced performance but without redundancy.

  This disk type is only available for **Intel Cascade Lake** and **Intel Ice Lake**. For a list of host classes and their respective platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

  The storage size can only be increased in 93 GB increments.

* **Local SSD storage** (`local-ssd`): Disks with the fastest performance.

   The size of such a storage can be increased:
   * For **Intel Broadwell** and **Intel Cascade Lake**: Only in 100 GB increments.
   * For **Intel Ice Lake**: In {{ local-ssd-v3-step }} increments only.

   For a list of host classes and their respective platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

