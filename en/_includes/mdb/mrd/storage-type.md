When creating a cluster, you can select the following disk types for data storage:

* **Network SSDs** (`network-ssd`): Balanced solution. Such disks are slower than local SSD storage, but, unlike local disks, they ensure data integrity if {{ yandex-cloud }} hardware fails.
* **Non-replicated SSDs** (`network-ssd-nonreplicated`): Network SSDs with enhanced performance achieved by eliminating redundancy.

  This disk type is only available for **Intel Cascade Lake** and **Intel Ice Lake**. For a list of host classes and their respective platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

  The storage size can only be increased in 93 GB increments.


* **Ultra high-speed network SSDs with three replicas** (`network-ssd-io-m3`): Network disks with the same performance characteristics as non-replicated ones. This disk type provides redundancy.

  Such disks can be increased in size only in 93 GB increments.


* **Local SSDs** (`local-ssd`): Disks with the best performance.

  The size of such a storage can be increased:
  * For **Intel Broadwell** and **Intel Cascade Lake**: Only in 100 GB increments.
  * For **Intel Ice Lake**: In {{ local-ssd-v3-step }} increments only.

  For a list of host classes and their respective platforms, see [{#T}](../../../managed-redis/concepts/instance-types.md).

  {% include [zone-d-disk-restrictions](../ru-central1-d-local-ssd.md) %}

{% include [available-storage](../available-storage.md) %}