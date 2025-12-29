When creating a cluster, you can select the following disk types for data storage:

* **Network SSDs** (`network-ssd`): Compromise solution: slower than local SSDs, network SSDs ensure data integrity in the event of {{ yandex-cloud }} hardware failure.
* **Non-replicated SSDs** (`network-ssd-nonreplicated`): Network SSDs with higher performance achieved by eliminating redundancy.

  This disk type is only available for **Intel Cascade Lake** and **Intel Ice Lake**. For a list of host classes and associated platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

  You can only expand this type of storage in 93 GB increments.


* **Ultra high-speed network SSDs with three replicas** (`network-ssd-io-m3`): Network disks that deliver performance equivalent to non-replicated SSDs while ensuring redundancy.

  You can only increase the size of these disks in 93 GB increments.


* **Local SSDs** (`local-ssd`): The highest-performing disks.

  You can expand such a storage as follows:
  * For **Intel Broadwell** and **Intel Cascade Lake**: Only in 100 GB increments.
  * For **Intel Ice Lake** and **AMD Zen 4**: Only in {{ local-ssd-v3-step }} increments.

  For a list of host classes and associated platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

  {% include [zone-d-disk-restrictions](../ru-central1-d-local-ssd.md) %}

{% include [available-storage](../available-storage.md) %}