# Storage in {{ dataproc-name }}

{{ dataproc-name }} enables you to use network storage drives to store subclusters. Network storage drives are based on network blocks, which are virtual disks in the {{ yandex-cloud }} infrastructure.

When creating a cluster, you can choose between the following storage types:

* HDD network storage (`network-hdd`): The cheapest option for clusters with relaxed read/write performance requirements.
* SSD network storage (`network-ssd`): A middle-ground solution. It's slower than non-replicated SSD storage, but unlike non-replicated SSD disks, it ensures data integrity if {{ yandex-cloud }} hardware goes down.
* Non-replicated SSD storage (`network-ssd-nonreplicated`): SSD network storage with enhanced performance that is implemented by eliminating redundancy.

   The storage size can only be increased in increments of 93 GB.

   For more information about this disk type, see the [{{ compute-full-name }} documentation](../../compute/concepts/disk.md#nr-disks).

## Specifics of non-replicated SSD storage {#network-nrd-storage-features}

Non-replicated SSD storage doesn't provide fault tolerance: if a disk fails, the data is permanently lost.
