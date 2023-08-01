When creating a cluster, you can select the following disk types for data storage:

* HDD network storage (`network-hdd`): The cheapest option for clusters with relaxed read/write performance requirements.
* SSD network storage (`network-ssd`): A middle-ground solution. It's slower than local SSD storage, but unlike local disks, it ensures data integrity if {{ yandex-cloud }} hardware goes down.
* Non-replicated SSD storage (`network-ssd-nonreplicated`): SSD network storage with enhanced performance that is implemented by eliminating redundancy.

  The storage size can only be increased in increments of 93 GB.

* Local SSD storage (`local-ssd`): Disks with the fastest performance.

  The size of such storage can be increased:
  * For **Intel Broadwell** and **Intel Cascade Lake**: Only in increments of 100 GB.
  * For **Intel Ice Lake**: Only in {{ local-ssd-v3-step }} increments.