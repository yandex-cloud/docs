When creating a cluster, you can choose between the following storage types:

* HDD network storage (`network-hdd`): The cheapest option for clusters with relaxed read/write performance requirements.
* SSD network storage (`network-ssd`): A middle-ground solution. It's slower than local SSD storage, but unlike local disks, it ensures data integrity if {{ yandex-cloud }} hardware goes down.
* Non-replicated SSD storage (`network-ssd-nonreplicated`): SSD network storage with enhanced performance that is implemented by eliminating redundancy.

  The storage size can only be increased in increments of 93 GB.

* Local SSD storage (`local-ssd`): The fastest disks.

  The storage size can only be increased in increments of 100 GB.
