A storage type is selected when creating a cluster:

* HDD network storage (`network-hdd`): The cheapest option. It's suitable for clusters with relaxed read/write performance requirements.
* Local SSD storage (`local-ssd`): The fastest disks. The size of local storage can be increased:
    * For Intel Broadwell and Intel Cascade Lake: Only in increments of 100 GB.
    * For Intel Ice Lake: Only in increments of {{ local-ssd-v3-step }}.
* SSD network storage (`network-ssd`): A middle-ground solution. It's slower than local SSD storage, but unlike local disks, it ensures data integrity if {{ yandex-cloud }} hardware goes down.
