When creating a cluster, you can select the following disk types for data storage:

* **Network HDD storage** (`network-hdd`): Most cost-effective option for clusters that do not require high read/write performance.
* **Network SSD storage** (`network-ssd`): Balanced solution. Such disks are slower than local SSD storage, but, unlike local disks, they ensure data integrity in case {{ yandex-cloud }} hardware goes down.
* **Non-replicated SSD storage** (`network-ssd-nonreplicated`): Network SSD storage with enhanced performance but without redundancy.

  The storage size can only be increased in increments of 93 GB.


* **Local SSD storage** (`local-ssd`): Disks with the fastest performance.

  This disk type is only available for **Intel Broadwell** and **Intel Cascade Lake**. For a list of host classes and their respective platforms, see [{#T}](../../../managed-mongodb/concepts/instance-types.md).

  The storage size can only be increased in increments of 100 GB.

