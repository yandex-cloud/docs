When creating a cluster, you can select the following disk types for storage:

* **Network HDDs** (`network-hdd`): Most cost-effective option for clusters with low requirements for read and write performance.
* **Network SSDs** (`network-ssd`): Compromise solution: slower than local SSDs, network SSDs ensure data integrity in the event of {{ yandex-cloud }} hardware failure.
* **Non-replicated SSDs** (`network-ssd-nonreplicated`): Network disks with higher performance, achieved by eliminating redundancy.

  The size of this type of storage can only be increased in 93 GB increments.


* **Ultra high-speed network SSDs with three replicas** (`network-ssd-io-m3`): Network disks that deliver performance equivalent to non-replicated SSDs, while maintaining full data redundancy.

  The size of these disks can only be increased in 93 GB increments.

* **Local SSDs** (`local-ssd`): Disks with the highest possible performance.

  The size of such a storage can be increased as follows:
  * For **Intel Broadwell** and **Intel Cascade Lake**: Only in 100 GB increments.
  * For **Intel Ice Lake**: Only in {{ local-ssd-v3-step }} increments.

  {% include [zone-d-disk-restrictions](../ru-central1-d-local-ssd.md) %} 


{% include [available-storage](../available-storage.md) %}
