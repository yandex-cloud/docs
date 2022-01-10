A storage type is selected when creating a cluster:

* Standard network storage (`network-hdd`): The most affordable option. It's suitable for clusters with relaxed read/write performance requirements.
* Fast local storage (`local-ssd`): The fastest disks. The size of local storage can be increased:
    * For Intel Broadwell and Intel Cascade Lake: Only in increments of 100 GB.
    * For Intel Ice Lake: Only in increments of {{ local-ssd-v3-step }}.
* Fast network storage (`network-ssd`): A middle-ground solution. It's slower than local storage, but unlike local disks, it ensures data integrity if {{ yandex-cloud }} hardware goes down.

