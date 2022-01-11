When creating a cluster, you can choose between the following storage types:

* Standard network storage (`network-hdd`): The cheapest option for clusters with relaxed read/write performance requirements.
* Fast network storage (`network-ssd`): A middle-ground solution. It's slower than local storage, but unlike local disks, it ensures data integrity if {{ yandex-cloud }} hardware goes down.
* Non-replicated network storage (`network-ssd-nonreplicated`): Network storage with enhanced performance that is implemented by eliminating redundancy. The storage size can only be increased in increments of 93 GB.
* Fast local storage (`local-ssd`): The fastest disks. The size of local storage can be increased:
    * For Intel Broadwell and Intel Cascade Lake: Only in increments of 100 GB.
    * For Intel Ice Lake: Only in increments of {{ local-ssd-v3-step }}.

