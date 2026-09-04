## Quotas {#compute-quotas}

### Quotas for instances and instance groups {#vm-quotas}

#|
|| Type of limit | Value ||
|| Number of [virtual machines](../compute/concepts/vm.md) per [cloud](../resource-manager/concepts/resources-hierarchy.md#cloud)
`compute.instances.count` | 12 ||
|| Total VM RAM per cloud^1^
`compute.instanceMemory.size` | 128 GB ||
|| Number of [instance groups](../compute/concepts/instance-groups/index.md) per cloud
`compute.instanceGroups.count` | 10 ||
|| Number of [placement groups](../compute/concepts/placement-groups.md) per cloud
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
|| Number of [vCPUs](../compute/concepts/performance-levels.md) for instances per cloud^1^
`compute.instanceCores.count` | 32 ||
|| Number of vCPUs for Compute Optimized instances per cloud^1^
`compute.instanceHighFreqCores.count` | 0 ||
|#


### GPU quotas {#gpu-quotas}

#|
|| Type of limit | Value ||
|| Number of NVIDIA® Tesla® V100 [GPUs](../compute/concepts/gpus.md) per cloud^1^
`compute.instanceGpus.count` | 0 ||
|| Number of NVIDIA® Ampere® A100 GPUs per cloud^1^
`compute.instanceA100Gpus.count` | 0 ||
|| Number of GPUs powered by AMD EPYC™ 9474F with Gen2 per cloud^1^
`compute.instanceV3IGpus.count` | 0 ||
|| Number of NVIDIA® Tesla® T4 GPUs per cloud^1^
`compute.instanceT4Gpus.count` | 0 ||
|| Number of NVIDIA® Tesla® T4 GPUs per cloud in the `{{ region-id }}-d` availability zone^1^
`compute.instanceT4Gpus.count.ru-central1-d` | 0 ||
|| Number of GPUs powered by {{ t4i-ice-lake }} per cloud^1^
`compute.instanceT4IGpus.count` | 0 ||
|#


### Disk quotas {#disk-quotas}

#|
|| Type of limit | Value ||
|| Number of [disks](../compute/concepts/disk.md) per cloud
`compute.disks.count` | 32 ||
|| Total [HDD](../compute/concepts/disk.md#disks-types) capacity per cloud
`compute.hddDisks.size` | 500 GB ||
|| Total SSD capacity per cloud
`compute.ssdDisks.size` | 200 GB ||
|| Total size of non-replicated SSDs per cloud
`compute.ssdNonReplicatedDisks.size` | 558 GB ||
|| Total size of high-performance SSDs per cloud
`compute.ssdIOM3Disks.size` | 186 GB ||
|| Number of [disk placement groups](../compute/concepts/disk-placement-group.md) per cloud
`compute.diskPlacementGroups.count` | 5 ||
|#


### File storage quotas {#fs-quotas}

#|
|| Type of limit | Value ||
|| Number of [network file storages](../compute/concepts/filesystem.md) per cloud
`compute.filesystems.count` | 100 ||
|| Total network file storage HDD capacity per cloud
`compute.hddFilesystems.size` | 512 GB ||
|| Total network file storage SSD capacity per cloud
`compute.ssdFilesystems.size` | 512 GB ||
|#


### Image quotas {#image-quotas}

#|
|| Type of limit | Value ||
|| Number of [images](../compute/concepts/image.md) per cloud
`compute.images.count` | 32 ||
|| Total size of images per cloud
`compute.images.size` | 1,024 GB ||
|| Number of [images optimized for deployment](../compute/concepts/image.md#images-optimized-for-deployment) per cloud^2^
`compute.diskPools.count` | 0 ||
|#

{% note info %}

When deploying optimized images, the quotas for the number of images per cloud and the total volume of images per cloud also apply. If you need to, send a request to [support]({{ link-console-support }}) to increase these quotas.

{% endnote %}


### Snapshot quotas {#snapshot-quotas}

#|
|| Type of limit | Value ||
|| Number of [disk snapshots](../compute/concepts/snapshot.md) per cloud
`compute.snapshots.count` | 32 ||
|| Total volume of disk snapshots per cloud
`compute.snapshots.size` | 400 GB ||
|| Number of [schedules for disk snapshots](../compute/concepts/snapshot-schedule.md) per cloud 
`compute.snapshotSchedules.count` | 32 ||
|#


### Dedicated host quotas {#dedicated-host-quotas}

#|
|| Type of limit | Value ||
|| Number of [dedicated hosts](../compute/concepts/dedicated-host.md) per cloud^2^
`compute.dedicatedHosts.count` | 0 ||
|| Number of dedicated host groups per cloud 
`compute.hostGroups.count` | 6 ||
|#


### Other quotas {#compute-other-quotas}

#|
|| Type of limit | Value ||
|| Number of concurrent [operations](../api-design-guide/concepts/operation.md) per [folder](../resource-manager/concepts/resources-hierarchy.md#folder) | 15 ||
|| Number of [reserved instance pools](../compute/concepts/reserved-pools.md) per cloud^2^
`compute.reservedInstancePools.count` | 1 ||
|#

^1^ This quota includes resources associated with vacant slots in [reserved instance pools](../compute/concepts/reserved-pools.md).

^2^ To increase [quotas]({{ link-console-quotas }}) for deployment-optimized images, dedicated hosts, or reserved instance pools, contact [support]({{ link-console-support }}).

## Limits {#compute-limits}

### VM limits {#compute-limits-vm}

Limits per VM depend on the VM [platform](../compute/concepts/vm-platforms.md):

{% list tabs group=platforms %}

- Intel Broadwell {#broadwell}

  #|
  || **Type of limit** | > | > | **Value** ||
  || Maximum number of vCPUs per VM | > | > | 32 ||
  || Maximum virtual memory per VM | > | Without GPU | 256 GB ||
  || ^ | > | With GPU | 384 GB ||
  || Maximum number of GPUs connected to a single VM | > | > | 4 ||
  || Maximum number of disks and file storages connected to a single VM^3^ | `PCI_TOPOLOGY_V1` [bus topology](../compute/concepts/hardware-generations.md#configurations). | Number of VCPUs <= 18 | 8 ||
  || ^ | ^ | Number of VCPUs > 18 | 16^4^ ||
  || ^ | `PCI_TOPOLOGY_V2` bus topology | Number of VCPUs <= 4 | 62 ||
  || ^ | ^ | Number of VCPUs >= 6 | 80 ||
  || Maximum number of [network interfaces](../compute/concepts/network.md) connected to a single VM | Bus topology
  `PCI_TOPOLOGY_V1` | > | 8^4^ ||
  || ^ | `PCI_TOPOLOGY_V2` bus topology | Number of VCPUs <= 4 | 20 ||
  || ^ | ^ | Number of VCPUs >= 6 | 32 ||
  || Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | > | > | 5 ||
  |#

- Intel Cascade Lake {#cascade}

  #|
  || **Type of limit** | > | > | **Value** ||
  || Maximum number of vCPUs per VM | > | Without GPU | 80 ||
  || ^ | > | With GPU | 64 ||
  || Maximum virtual memory per VM | > | Without GPU | 1,280 GB ||
  || ^ | > | With GPU | 384 GB ||
  || Maximum number of GPUs connected to a single VM | > | > | 8 ||
  || Maximum number of disks and file storages connected to a single VM^3^ | `PCI_TOPOLOGY_V1` [bus topology](../compute/concepts/hardware-generations.md#configurations). | Number of VCPUs <= 20 | 8 ||
  || ^ | ^ | Number of VCPUs > 20 | 16^4^ ||
  || ^ | `PCI_TOPOLOGY_V2` bus topology | Number of VCPUs <= 4 | 62 ||
  || ^ | ^ | Number of VCPUs >= 6 | 80 ||
  || Maximum number of [network interfaces](../compute/concepts/network.md) connected to a single VM | Bus topology
  `PCI_TOPOLOGY_V1` | > | 8^4^ ||
  || ^ | `PCI_TOPOLOGY_V2` bus topology | Number of VCPUs <= 4 | 20 ||
  || ^ | ^ | Number of VCPUs >= 6 | 32 ||
  || Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | > | > | 5 ||
  |#

- Intel Ice Lake {#ice}

  #|
  || **Type of limit** | > | > | **Value** ||
  || Maximum number of vCPUs per VM | > | > | 96 ||
  || Maximum virtual memory per VM | > | > | 640 GB ||
  || Maximum number of disks and file storages connected to a single VM^3^ | `PCI_TOPOLOGY_V1` [bus topology](../compute/concepts/hardware-generations.md#configurations). | Number of VCPUs <= 32 | 8 ||
  || ^ | ^ | Number of VCPUs > 32 | 16^4^ ||
  || ^ | `PCI_TOPOLOGY_V2` bus topology | Number of VCPUs <= 4 | 62 ||
  || ^ | ^ | Number of VCPUs >= 6 | 80 ||
  || Maximum number of [network interfaces](../compute/concepts/network.md) connected to a single VM | Bus topology
  `PCI_TOPOLOGY_V1` | > | 8^4^ ||
  || ^ | `PCI_TOPOLOGY_V2` bus topology | Number of VCPUs <= 4 | 20 ||
  || ^ | ^ | Number of VCPUs >= 6 | 32 ||
  || Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | > | > | 5 ||
  |#

- Intel Ice Lake (Compute Optimized) {#optimized}

  #|
  || **Type of limit** | > | > | **Value** ||
  || Maximum number of vCPUs per VM | > | > | 56 ||
  || Maximum virtual memory per VM | > | > | 448 GB ||
  || Maximum number of disks and file storages connected to a single VM^3^ | `PCI_TOPOLOGY_V1` [bus topology](../compute/concepts/hardware-generations.md#configurations). | Number of VCPUs <= 32 | 8 ||
  || ^ | ^ | Number of VCPUs > 32 | 16^4^ ||
  || ^ | `PCI_TOPOLOGY_V2` bus topology | Number of VCPUs <= 4 | 62 ||
  || ^ | ^ | Number of VCPUs >= 6 | 80 ||
  || Maximum number of [network interfaces](../compute/concepts/network.md) connected to a single VM | Bus topology
  `PCI_TOPOLOGY_V1` | > | 8^4^ ||
  || ^ | `PCI_TOPOLOGY_V2` bus topology | Number of VCPUs <= 4 | 20 ||
  || ^ | ^ | Number of VCPUs >= 6 | 32 ||
  || Maximum number of VMs per VM placement group with the [spread placement](../compute/concepts/placement-groups.md#spread) strategy | > | > | 5 ||
  |#

{% endlist %}

^3^ Including the boot disk.

^4^ At startup, you can connect no more than 14 devices to a VM, including the boot disk and network card. You should connect other devices when your VM is already running. Please note that if you restart a VM with more than 14 devices connected, it will not be able to boot.

{% include [warn-performance-many-devices](../compute/_includes_service/warn-performance-many-devices.md) %}

### VM limits related to disks {#compute-limits-vm-disks}

The values listed below are VM side limitations. They scale with the number of vCPUs: the row value is multiplied by the number of vCPUs to set the upper boundary of the total load on all disks attached to the VM. For example, for a VM with 4 vCPUs and a network SSD, the total maximum IOPS cannot exceed _4 × 3,500 = 14,000_.

The actual performance of an individual disk is also capped by its [own limits](#compute-limits-disks). The final value is determined as the minimum of the two: the VM limit and the disk limit.

{% note info %}

IOPS and bandwidth limits of an individual disk depend on the number of [allocation units](../compute/concepts/storage-read-write.md). For more information, see [{#T}](../compute/concepts/storage-read-write.md#performance).

{% endnote %}

{% list tabs group=disks %}

- Network SSD {#net-ssd}

  Type of limit | Value
  --- | ---
  Maximum^5^ [IOPS](../compute/concepts/storage-read-write.md) per VM vCPU | 3,500
  Maximum^6^ [bandwidth](../compute/concepts/storage-read-write.md) per VM vCPU | 45 MB/s

- Network HDD {#net-hdd}

  Type of limit  | Value
  --- | ---
  Maximum^5^ [IOPS](../compute/concepts/storage-read-write.md) per VM vCPU | 3,500
  Maximum^6^ [bandwidth](../compute/concepts/storage-read-write.md) per VM vCPU | 45 MB/s

- Non-replicated SSD {#non-replicated-ssd}

  Type of limit  | Value
  --- | ---
  Total number of non-replicated SSDs per placement group | 8
  Maximum^5^ [IOPS](../compute/concepts/storage-read-write.md) per VM vCPU | 10,000
  Maximum^5^ IOPS per VM | 100,000
  Maximum^6^ [bandwidth](../compute/concepts/storage-read-write.md) per VM vCPU | 100 MB/s
  Maximum^6^ bandwidth per VM | 1 GB/s

- Ultra high-speed network storage with three replicas (SSD) {#high-perf-ssd}

  Type of limit | Value
  --- | ---
  Maximum^5^ [IOPS](../compute/concepts/storage-read-write.md) per VM vCPU | 10,000
  Maximum^5^ IOPS per VM | 100,000
  Maximum^6^ [bandwidth](../compute/concepts/storage-read-write.md) per VM vCPU | 100 MB/s
  Maximum^6^ bandwidth per VM | 1 GB/s

{% endlist %}

### Disk and file storage limits {#compute-limits-disks}

{% list tabs group=disks %}

- Network SSD {#net-ssd}

  Type of limit | Value
  --- | ---
  Maximum disk size | 256 TB
  [Allocation unit](../compute/concepts/storage-read-write.md) size | 32 GB
  Maximum^5^ IOPS for writes per disk | 40,000
  Maximum^5^ IOPS for writes per allocation unit | 1,000
  Maximum^6^ bandwidth for writes per disk | 450 MB/s
  Maximum^6^ bandwidth for writes per allocation unit | 15 MB/s
  Maximum^5^ IOPS for reads per disk | 20,000
  Maximum^5^ IOPS for reads per allocation unit | 1,000
  Maximum^6^ bandwidth for reads per disk | 450 MB/s
  Maximum^6^ bandwidth for reads per allocation unit | 15 MB/s

- Network HDD {#net-hdd}

  Type of limit | Value
  --- | ---
  Maximum disk size | 256 TB
  [Allocation unit](../compute/concepts/storage-read-write.md) size | 256 GB
  Maximum^5^ IOPS for writes per disk | 11,000
  Maximum^5^ IOPS for writes per allocation unit | 300
  Maximum^6^ bandwidth for writes per disk | 240 MB/s
  Maximum^6^ bandwidth for writes per allocation unit | 30 MB/s
  Maximum^5^ IOPS for reads per disk | 2,000
  Maximum^5^ IOPS for reads per allocation unit | 300
  Maximum^6^ bandwidth for reads per disk | 240 MB/s
  Maximum^6^ bandwidth for reads per allocation unit | 30 MB/s

- Non-replicated SSD {#non-replicated-ssd}

  Type of limit | Value
  --- | ---
  Minimum non-replicated disk size | 93 GB
  [Allocation unit](../compute/concepts/storage-read-write.md) size | 93 GB
  Maximum^5^ IOPS for writes per disk | 75,000
  Maximum^5^ IOPS for writes per allocation unit | 5,600
  Maximum^6^ bandwidth for writes per disk | 1 GB/s
  Maximum^6^ bandwidth for writes per allocation unit | 82 MB/s
  Maximum^5^ IOPS for reads per disk | 75,000
  Maximum^5^ IOPS for reads per allocation unit | 28,000
  Maximum^6^ bandwidth for reads per disk | 1 GB/s
  Maximum^6^ bandwidth for reads per allocation unit | 110 MB/s

- Ultra high-speed network storage with three replicas (SSD) {#high-perf-ssd}

  Type of limit | Value
  --- | ---
  Minimum capacity of ultra high-speed network storage with three replicas (SSD) | 93 GB
  [Allocation unit](../compute/concepts/storage-read-write.md) size | 93 GB
  Maximum^5^ IOPS for writes per disk | 40,000
  Maximum^5^ IOPS for writes per allocation unit | 5,600
  Maximum^6^ bandwidth for writes per disk | 1 GB/s
  Maximum^6^ bandwidth for writes per allocation unit | 82 MB/s
  Maximum^5^ IOPS for reads per disk | 75,000
  Maximum^5^ IOPS for reads per allocation unit | 28,000
  Maximum^6^ bandwidth for reads per disk | 1 GB/s
  Maximum^6^ bandwidth for reads per allocation unit | 110 MB/s

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

^5^ For maximum IOPS, we recommend keeping your read and write operations close to the disk block size (4 KB by default).

^6^ For maximum bandwidth, we recommend 4 MB reads and writes.

### Limits of disk snapshot schedules {#compute-limits-snapshot-schedule}

Type of limit | Value
--- | ---
Number of disks added to a schedule | 1,000
Number of schedules a disk is added to | 1,000

### Other limits {#compute-other-limits}

Type of limit | Value
--- | ---
Time to complete processes when stopping a VM^7^ | 30 seconds

^7^ When a VM stops, the hypervisor sends a shutdown signal to the VM operating system. The OS has 30 seconds to gracefully terminate all running processes to avoid data loss. After this time elapses, the VM will be forcibly terminated.
