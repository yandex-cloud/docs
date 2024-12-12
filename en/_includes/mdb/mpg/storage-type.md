When creating a cluster, you can select the following disk types for data storage:

* **Network HDD storage** (`network-hdd`): Most cost-effective option for clusters that do not require high read/write performance.
* **Network SSD storage** (`network-ssd`): Balanced solution. Such disks are slower than local SSD storage, but, unlike local disks, they ensure data integrity if {{ yandex-cloud }} hardware fails.
* **Non-replicated SSD** (`network-ssd-nonreplicated`): Network disks with enhanced performance achieved by eliminating redundancy.

  You can increase the size of such disks only in increments of 93 GB.


* **Ultra high-speed network SSDs with three replicas** (`network-ssd-io-m3`): Network disks with the same performance characteristics as non-replicated ones. This disk type provides redundancy.

  You can increase the size of such disks only in increments of 93 GB.

  Access to high-performance SSDs is available on request. Contact [support]({{ link-console-support }}) or your account manager.


* **Local SSDs** (`local-ssd`): Disks with the best performance.

  The size of such a storage can be increased:
  * For **Intel Broadwell** and **Intel Cascade Lake**: Only in increments of 100 GB.
  * For **Intel Ice Lake**: In {{ local-ssd-v3-step }} increments only.

  {% include [zone-d-disk-restrictions](../ru-central1-d-local-ssd.md) %}

