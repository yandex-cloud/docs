When creating a cluster, you can select the following disk types for storage:

* **Network HDDs** (`network-hdd`): Most cost-effective choice for clusters with low requirements for read and write performance.
* **Network SSDs** (`network-ssd`): Balanced compromise between speed and reliability. While slower than local SSDs, network SSDs ensure data integrity in the event of {{ yandex-cloud }} hardware failure.
* **Non-replicated SSD** (`network-ssd-nonreplicated`): Network disks with higher performance, achieved by eliminating redundancy.

  The size of these disks can only be increased in 93 GB increments.


* **Ultra high-speed network SSDs with three replicas** (`network-ssd-io-m3`): Deliver performance equivalent to non-replicated SSDs, while maintaining full data redundancy.

  The size of these disks can only be increased in 93 GB increments.


* **Local SSDs** (`local-ssd`): Deliver the highest possible disk performance.

  The storage size can be increased as follows:
  * For **Intel Broadwell** and **Intel Cascade Lake**: Only in 100 GB increments.
  * For **Intel Ice Lake**: Only in {{ local-ssd-v3-step }} increments.

  {% include [zone-d-disk-restrictions](../ru-central1-d-local-ssd.md) %}

{% include [available-storage](../available-storage.md) %}
