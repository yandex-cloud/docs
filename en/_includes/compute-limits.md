## Quotas {#compute-quotas}

### Quotas for instances and instance groups {#vm-quotas}

#|
|| Type of limit | Value ||
|| Number of [virtual machines](../compute/concepts/vm.md) per [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud) 
`compute.instances.count` | 12 ||
|| Total virtual memory across all VMs and number of available slots in [reserved instance pools](../compute/concepts/reserved-pools.md) per cloud 
`compute.instanceMemory.size` | 128 GB ||
|| Number of [instance groups](../compute/concepts/instance-groups/index.md) per cloud 
`compute.instanceGroups.count` | 10 ||
|| Maximum number of [VM placement groups](../compute/concepts/placement-groups.md) per cloud 
`compute.placementGroups.count` | 2 ||
|| Maximum number of VMs per partition in a VM placement group with the [partition placement](../compute/concepts/placement-groups.md#partition) strategy | 100 ||
|| Maximum number of [security groups](../vpc/concepts/security-groups.md) per [network interface](../compute/concepts/network.md)

{% note warning %}

You can increase this quota only upon agreement with your account manager.

{% endnote %}

| 5 ||
|#


### vCPU quotas {#vcpu-quotas}

#|
|| Type of limit | Value ||
|| Total number of [vCPUs](../compute/concepts/performance-levels.md) across all VMs and number of available slots in reserved instance pools per cloud 
`compute.instanceCores.count` | 32 ||
|| Total number of {{ highfreq-ice-lake }} vCPUs across all VMs and number of available slots in reserved instance pools per cloud 
`compute.instanceHighFreqCores.count` | 0 ||
|#


### GPU quotas {#gpu-quotas}

#|
|| Type of limit | Value ||
|| Total number of NVIDIA® Tesla® V100 [GPUs](../compute/concepts/gpus.md) across all VMs and number of available slots in reserved instance pools per cloud 
`compute.instanceGpus.count` | 0 ||
|| Total number of {{ a100-epyc }} GPUs across all VMs and number of available slots in reserved instance pools per cloud 
`compute.instanceA100Gpus.count` | 0 ||
|| Total number of GPUs for AMD EPYC™ 9474F with Gen2 across all VMs and number of available slots in reserved instance pools per cloud
`compute.instanceV3IGpus.count` | 0 ||
|| Total number of {{ t4-ice-lake }} GPUs across all VMs and number of available slots in reserved instance pools per cloud 
`compute.instanceT4Gpus.count` | 0 ||
|| Total number of {{ t4-ice-lake }} GPUs across all VMs and number of available slots in reserved instance pools per on cloud in the `{{ region-id }}-d` availability zone
`compute.instanceT4Gpus.count.ru-central1-d` | 0 ||
|| Total number of {{ t4i-ice-lake }} GPUs across all VMs and number of available slots in reserved instance pools per cloud 
`compute.instanceT4IGpus.count` | 0 ||
|#


### Disk quotas {#disk-quotas}

#|
|| Type of limit | Value ||
|| Total number of [disks](../compute/concepts/disk.md) per cloud 
`compute.disks.count` | 32 ||
|| Total [HDD storage](../compute/concepts/disk.md#disks-types) capacity per cloud 
`compute.hddDisks.size` | 500 GB ||
|| Total SSD storage capacity per cloud 
`compute.ssdDisks.size` | 200 GB ||
|| Total non-replicated SSD storage capacity per cloud 
`compute.ssdNonReplicatedDisks.size` | 558 GB ||
|| Total capacity of ultra high-speed network SSD storages with three replicas per cloud 
`compute.ssdIOM3Disks.size` | 186 GB ||
|| Number of [non-replicated disk placement groups](../compute/concepts/disk-placement-group.md) per cloud 
`compute.diskPlacementGroups.count` | 5 ||
|#


### File storage quotas {#fs-quotas}

#|
|| Type of limit | Value ||
|| Total number of [file storages](../compute/concepts/filesystem.md) per cloud^1^ 
`compute.filesystems.count` | 100 ||
|| Total [HDD](../compute/concepts/filesystem.md#types) file storage size per cloud^1^ 
`compute.hddFilesystems.size` | 512 GB ||
|| Total SSD file storage size per cloud^1^ 
`compute.ssdFilesystems.size` | 512 GB ||
|#


### Image quotas {#image-quotas}

#|
|| Type of limit | Value ||
|| Number of [images](../compute/concepts/image.md) per cloud 
`compute.images.count` | 32 ||
|| Total volume of images per cloud 
`compute.images.size` | 1,024 GB ||
|| Number of [images optimized for deployment](../compute/concepts/image.md#images-optimized-for-deployment) per cloud^1^ 
`compute.diskPools.count` | 0 ||
|#

{% note info %}

When deploying optimized images, the quotas for the number of images per cloud and the total volume of images per cloud also apply. If you need to, send a request to [support]({{ link-console-support }}) to increase these quotas.

{% endnote %}


### Snapshot quotas {#snapshot-quotas}

#|
|| Type of limit | Value ||
|| Total number of [disk snapshots](../compute/concepts/snapshot.md) per cloud 
`compute.snapshots.count` | 32 ||
|| Total storage capacity of all disk snapshots per cloud 
`compute.snapshots.size` | 400 GB ||
|| Number of [disk snapshot schedules](../compute/concepts/snapshot-schedule.md) per cloud 
`compute.snapshotSchedules.count` | 32 ||
|#


### Dedicated host quotas {#dedicated-host-quotas}

#|
|| Type of limit | Value ||
|| Number of [dedicated hosts](../compute/concepts/dedicated-host.md) per dedicated host group^1^ 
`compute.dedicatedHosts.count` | 0 ||
|| Number of dedicated host groups per cloud 
`compute.hostGroups.count` | 6 ||
|#


### Other quotas {#compute-other-quotas}

#|
|| Type of limit | Value ||
|| Number of concurrent [operations](../api-design-guide/concepts/operation.md) per [folder](../resource-manager/concepts/resources-hierarchy.md#folder) | 15 ||
|| Number of [reserved instance pools](../compute/concepts/reserved-pools.md) per cloud^1^
`compute.reservedInstancePools.count` | 0 ||
|#

^1^ To increase [quotas]({{ link-console-quotas }}) for file storages, deployment-optimized images, dedicated hosts, or reserved instance pools, contact [support]({{ link-console-support }}).

## Limits {#compute-limits}

### VM limits {#compute-limits-vm}

Limits per VM depend on the VM [platform](../compute/concepts/vm-platforms.md):

{% list tabs group=platforms %}

- Intel Broadwell {#broadwell}

  Type of limit | Value
  --- | ---
  Maximum number of vCPUs per VM | 32
  Maximum virtual memory per VM | Without GPU: 256 GB<br>With GPU: 384 GB
  Maximum number of disks and file storages connected to a single VM^2^ | Less than or equal to 18 vCPUs: 8<br>From 18 vCPUs: 16^3^
  Maximum number of GPUs connected to a single VM | 4
  Maximum number of [VM network interfaces](../compute/concepts/network.md) | 8^3^
  Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | 5

- Intel Cascade Lake {#cascade}

  Type of limit | Value
  --- | ---
  Maximum number of vCPUs per VM | Without GPU: 80<br>With GPU: 64
  Maximum virtual memory per VM | Without GPU: 1,280 GB<br>With GPU: 384 GB
  Maximum number of disks and file storages connected to a single VM^2^ | Less than or equal to 20 vCPUs: 8<br>From 20 vCPUs: 16^3^
  Maximum number of GPUs connected to a single VM | 8
  Maximum number of [VM network interfaces](../compute/concepts/network.md) | 8^3^
  Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | 5

- Intel Ice Lake {#ice}

  Type of limit | Value
  --- | ---
  Maximum number of vCPUs per VM | 96
  Maximum virtual memory per VM | 640 GB
  Maximum number of disks and file storages connected to a single VM^2^ | Less than or equal to 32 vCPUs: 8<br>More than> 32 vCPUs: 16^3^
  Maximum number of [VM network interfaces](../compute/concepts/network.md) | 8^3^
  Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | 5

- Intel Ice Lake (Compute Optimized) {#optimized}

  Type of limit | Value
  --- | ---
  Maximum number of vCPUs per VM | 56
  Maximum virtual memory per VM | 448 GB
  Maximum number of disks and file storages connected to a single VM^2^ | Less than or equal to 32 vCPUs: 8<br>More than> 32 vCPUs: 16^3^
  Maximum number of [VM network interfaces](../compute/concepts/network.md) | 8^3^
  Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | 5

{% endlist %}

^2^ Including the boot disk.

^3^ At startup, you can connect no more than 14 devices to a VM, including the boot disk and network card. You should connect other devices when your VM is already running. Please note that if you restart a VM with more than 14 devices connected, it will not be able to boot.

### VM limits on disk operations {#compute-limits-vm-disks}

{% list tabs group=disks %}

- Network SSD {#net-ssd}

  Type of limit | Value
  --- | ---
  Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 3,500
  Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 45 MB/s

- Network HDD {#net-hdd}

  Type of limit | Value
  --- | ---
  Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 3,500
  Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 45 MB/s

- Non-replicated SSD {#non-replicated-ssd}

  Type of limit | Value
  --- | ---
  Total number of non-replicated SSDs per placement group | 8
  Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 10,000
  Maximum^4^ IOPS per VM | 100,000
  Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 100 MB/s
  Maximum^5^ bandwidth per VM | 1 GB/s

- Ultra high-speed network storage with three replicas (SSD) {#high-perf-ssd}

  Type of limit | Value
  --- | ---
  Maximum^4^ [IOPS](../compute/concepts/storage-read-write.md) per vCPU | 10,000
  Maximum^4^ IOPS per VM | 100,000
  Maximum^5^ [bandwidth](../compute/concepts/storage-read-write.md) per vCPU | 100 MB/s
  Maximum^5^ bandwidth per VM | 1 GB/s

{% endlist %}

### Disk and file storage limits {#compute-limits-disks}

{% list tabs group=disks %}

- Network SSD {#net-ssd}

  Type of limit | Value
  --- | ---
  Maximum disk size | 256 TB
  [Allocation unit](../compute/concepts/storage-read-write.md) size | 32 GB
  Maximum^4^ IOPS for writes per disk | 40,000
  Maximum^4^ IOPS for writes per allocation unit | 1,000
  Maximum^5^ bandwidth for writes per disk | 450 MB/s
  Maximum^5^ bandwidth for writes per allocation unit | 15 MB/s
  Maximum^4^ IOPS for reads per disk | 20,000
  Maximum^4^ IOPS for reads per allocation unit | 1,000
  Maximum^5^ bandwidth for reads per disk | 450 MB/s
  Maximum^5^ bandwidth for reads per allocation unit | 15 MB/s

- Network HDD {#net-hdd}

  Type of limit | Value
  --- | ---
  Maximum disk size | 256 TB
  [Allocation unit](../compute/concepts/storage-read-write.md) size | 256 GB
  Maximum^4^ IOPS for writes per disk | 11,000
  Maximum^4^ IOPS for writes per allocation unit | 300
  Maximum^5^ bandwidth for writes per disk | 240 MB/s
  Maximum^5^ bandwidth for writes per allocation unit | 30 MB/s
  Maximum^4^ IOPS for reads per disk | 2,000
  Maximum^4^ IOPS for reads per allocation unit | 300
  Maximum^5^ bandwidth for reads per disk | 240 MB/s
  Maximum^5^ bandwidth for reads per allocation unit | 30 MB/s

- Non-replicated SSD {#non-replicated-ssd}

  Type of limit | Value
  --- | ---
  Minimum non-replicated disk size | 93 GB
  [Allocation unit](../compute/concepts/storage-read-write.md) size | 93 GB
  Maximum^4^ IOPS for writes per disk | 75,000
  Maximum^4^ IOPS for writes per allocation unit | 5,600
  Maximum^5^ bandwidth for writes per disk | 1 GB/s
  Maximum^5^ bandwidth for writes per allocation unit | 82 MB/s
  Maximum^4^ IOPS for reads per disk | 75,000
  Maximum^4^ IOPS for reads per allocation unit | 28,000
  Maximum^5^ bandwidth for reads per disk | 1 GB/s
  Maximum^5^ bandwidth for reads per allocation unit | 110 MB/s

- Ultra high-speed network storage with three replicas (SSD) {#high-perf-ssd}

  Type of limit | Value
  --- | ---
  Minimum capacity of ultra high-speed network storage with three replicas (SSD) | 93 GB
  [Allocation unit](../compute/concepts/storage-read-write.md) size | 93 GB
  Maximum^4^ IOPS for writes per disk | 40,000
  Maximum^4^ IOPS for writes per allocation unit | 5,600
  Maximum^5^ bandwidth for writes per disk | 1 GB/s
  Maximum^5^ bandwidth for writes per allocation unit | 82 MB/s
  Maximum^4^ IOPS for reads per disk | 75,000
  Maximum^4^ IOPS for reads per allocation unit | 28,000
  Maximum^5^ bandwidth for reads per disk | 1 GB/s
  Maximum^5^ bandwidth for reads per allocation unit | 110 MB/s

{% endlist %}

{% list tabs group=storages %}

- SSD storage {#ssd}

  Type of limit | Value
  --- | ---
  Maximum storage size | 8 TB
  Allocation unit size | 32 GB
  Maximum number of files in storage | 1,000,000
  Maximum size of file in storage | 300 GB

- HDD storage {#hdd}

  Type of limit | Value
  --- | ---
  Maximum storage size | 8 TB
  Allocation unit size | 256 GB
  Maximum number of files in storage | 1,000,000
  Maximum size of file in storage | 300 GB

{% endlist %}

Read and write operations utilize the same disk resource. The more read operations you do, the fewer write operations you can do, and vice versa. For more information, see [{#T}](../compute/concepts/storage-read-write.md).

^4^ For maximum IOPS, we recommend keeping your read and write operations close to the disk block size (4 KB by default).

^5^ For maximum bandwidth, we recommend 4 MB reads and writes.

### Limits of disk snapshot schedules {#compute-limits-snapshot-schedule}

Type of limit | Value
--- | ---
Number of disks added to a schedule | 1,000
Number of schedules a disk is added to | 1,000

### Other limits {#compute-other-limits}

Type of limit | Value
--- | ---
Time to complete processes when stopping a VM^6^ | 30 seconds

^6^ When a VM stops, the hypervisor sends a shutdown signal to the VM operating system. The OS has 30 seconds to gracefully terminate all running processes to avoid data loss. After this time elapses, the VM will be forcibly terminated.