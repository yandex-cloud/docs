When creating a cluster, you can select the following disk types for data storage:

* **Network HDD storage** (`network-hdd`): Most cost-effective option for clusters that do not require high read/write performance.
* **Network SSD storage** (`network-ssd`): Balanced solution. Such disks are slower than local SSD storage, but, unlike local disks, they ensure data integrity in case {{ yandex-cloud }} hardware goes down.
* **Non-replicated SSD storage** (`network-ssd-nonreplicated`): Network SSD storage with enhanced performance but without redundancy.

   The storage size can only be increased in increments of 93 GB.

* **Local SSD storage** (`local-ssd`): Disks with the fastest performance.

  The size of this kind of storage can be increased:
    * For **Intel Broadwell** and **Intel Cascade Lake**: Only in increments of 100 GB.
    * For **Intel Ice Lake**: Only in increments of {{ local-ssd-v3-step }}.
