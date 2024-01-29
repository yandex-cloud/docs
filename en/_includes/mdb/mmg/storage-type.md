When creating a cluster, you can select the following disk types for data storage:

* **Network HDD storage** (`network-hdd`): Most cost-effective option for clusters that do not require high read/write performance.
* **Network SSD storage** (`network-ssd`): Balanced solution. Such disks are slower than local SSD storage, but, unlike local disks, they ensure data integrity in case {{ yandex-cloud }} hardware goes down.
* **Non-replicated SSD storage** (`network-ssd-nonreplicated`): Network SSD storage with enhanced performance but without redundancy.

  The storage size can only be increased in 93 GB increments.


* **Local SSDs** (`local-ssd`): Disks with the fastest performance.

   The size of such a storage can be increased:
   * For **Intel Broadwell** and **Intel Cascade Lake**: Only in 100 GB increments.
   * For **Intel Ice Lake**: In {{ local-ssd-v3-step }} increments only.

   For a list of host classes and their respective platforms, see [{#T}](../../../managed-mongodb/concepts/instance-types.md).

   {% include [zone-d-disk-restrictions](../ru-central1-d-local-ssd.md) %}

