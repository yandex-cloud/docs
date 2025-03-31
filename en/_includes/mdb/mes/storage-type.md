When creating a cluster, you can select the following disk types for data storage:

* **Network HDDs** (`network-hdd`): Most cost-effective option for clusters that do not require high read/write performance.
* **Network SSDs** (`network-ssd`): Balanced solution. Such disks are slower than local SSD storage, but, unlike local disks, they ensure data integrity if {{ yandex-cloud }} hardware fails.
* **Non-replicated SSDs** (`network-ssd-nonreplicated`): Network SSDs with enhanced performance achieved by eliminating redundancy.

  The storage size can only be increased in 93 GB increments.

* **Local SSDs** (`local-ssd`): Disks with the best performance.

  The size of such a storage can be increased:
  * For **Intel Cascade Lake**: Only in 100 GB increments.
  * For **Intel Ice Lake**: In {{ local-ssd-v3-step }} increments only.

  {% include [zone-d-disk-restrictions](../ru-central1-d-local-ssd.md) %}
