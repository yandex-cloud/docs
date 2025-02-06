---
title: Graphics accelerators (GPUs)
description: GPU (Graphics Processing Unit) is a graphics processor that outperforms vCPU for certain types of data. It can be used for complex computing. {{ compute-name }} provides graphics accelerators (GPUs) as part of graphics cards.
---

# Graphics processing units (GPUs)


{{ compute-name }} provides graphics accelerators (GPUs) for different VM [configurations](#config). GPUs outperform CPUs for certain types of data and can be used for complex computing. For even more performance and convenience, you can use automatic allocation of resources in [{{ ml-platform-full-name }}](../../datasphere/concepts/index.md).

The following GPUs are available in {{ compute-name }}:
* [NVIDIA® Tesla® V100](https://www.nvidia.com/en-gb/data-center/tesla-v100/) with 32 GB HBM2 (High Bandwidth Memory).
* [NVIDIA® Ampere® A100](https://www.nvidia.com/en-us/data-center/a100/) with 80 GB HBM2.
* [NVIDIA® Tesla® T4](https://www.nvidia.com/en-us/data-center/tesla-t4/) with 16 GB GDDR6.

{% note warning %}

GPUs run in [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster) mode, which does not use the operating system's graphics drivers.

{% endnote %}

{% include [gpu-zero-quota](../../_includes/compute/gpu-zero-quota.md) %}

## Graphics accelerators (GPUs) {#gpu}

Graphics accelerators are suitable for machine learning (ML), artificial intelligence (AI), and 3D rendering tasks.

You can manage GPUs and RAM directly from your VM.


### NVIDIA® Tesla® V100 {#tesla-v100}

The NVIDIA® Tesla® V100 graphics card contains 5120 CUDA® cores for [high-performance computing](https://www.nvidia.com/en-us/high-performance-computing/) (HPC), and 640 Tensor cores for deep learning (DL) tasks.


### NVIDIA® Ampere® A100 {#a100}

The NVIDIA® A100 GPU based on the [Ampere®](https://www.nvidia.com/en-us/data-center/ampere-architecture/) microarchitecture uses third-generation Tensor Cores and offers 80 GB HBM2 memory with up to 2 TB/s bandwidth.


### NVIDIA® Tesla® T4 {#tesla-t4}

NVIDIA® Tesla® T4 based on the [Turing™](https://images.nvidia.com/aem-dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf) architecture uses Turing tensor cores and RT cores and offers 16 GB of GDDR6 memory with [300 GB/s bandwidth](https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/tesla-t4/t4-tensor-core-datasheet-951643.pdf).

### T4i {#t4i}

T4i GPU uses Tensor Cores and offers 24 GB GDDR6 memory with up to 300 GB/s bandwidth.

### VM configurations {#config}

The computing resources may have the following configurations:


* {{ v100-broadwell }} (`gpu-standard-v1`):

  Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB
  --- | --- | --- | ---
  1 | 32 | 8 | 96
  2 | 64 | 16 | 192
  4 | 128 | 32 | 384

* {{ v100-cascade-lake }} (`gpu-standard-v2`):

  Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB
  --- | --- | --- | ---
  1 | 32 | 8 | 48
  2 | 64 | 16 | 96
  4 | 128 | 32 | 192
  8 | 256 | 64 | 384


* {{ a100-epyc }} (`gpu-standard-v3`):

  Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB
  --- | --- | --- | ---
  1 | 80 | 28 | 119
  2 | 160 | 56 | 238
  4 | 320 | 112 | 476
  8 | 640 | 224 | 952

* AMD EPYC™ 9474F with Gen2 (`gpu-standard-v3i`):

  Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB
  --- | --- | --- | ---
  2 | 160 | 36 | 288
  4 | 320 | 72 | 576
  8 | 640 | 180 | 1440
  
* {{ t4-ice-lake }} (`standard-v3-t4`):

  
  Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB
  --- | --- | --- | ---
  1 | 16 | 4 | 16
  1 | 16 | 8 | 32
  1 | 16 | 16 | 64
  1 | 16 | 32 | 128


* {{ t4i-ice-lake }} (`standard-v3-t4i`):

  Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB
  --- | --- | --- | ---
  1 | 24 | 4 | 16
  1 | 24 | 8 | 32
  1 | 24 | 16 | 64
  1 | 24 | 32 | 128

VM GPUs are provided in full. For example, if a configuration has four GPUs specified, your VM will have four full-featured GPU devices.


{% include [gpu-zones](../../_includes/compute/gpu-zones.md) %}


For more information about organizational and technical limitations for VMs, see [Quotas and limits](../concepts/limits.md).

For information about the cost of VMs with GPUs, see [{#T}](../pricing.md#prices-instance-resources).

### OS images {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}


## GPU clusters {#gpu-clusters}

You can group several VMs into a cluster. This will allow you to accelerate distributed training tasks that require higher computing capacity than individual VMs can provide. Make sure the cluster is created in the same availability zone as its VMs. The cluster VMs are interconnected through InfiniBand, a secure high-speed network. 

You can add VMs from different folders, networks, and subnets to your cluster. For the cluster VMs to interact properly, we recommend using a [security group](../../vpc/concepts/security-groups.md) that allows unlimited traffic within the group. The default security group meets this requirement. If you edited the default security group, add a group with unlimited internal traffic.

Maximum cluster size for AMD EPYC™ 9474F with Gen2 is 20 VMs with 8 GPU, 80 GB VRAM, 180 vCPU, 1,440 GB RAM configuration. The actual maximum cluster size is limited by the technical availability of the resources.


#### See also {#see-also}

* [{#T}](../operations/vm-create/create-vm-with-gpu.md)
* [Adding a GPU to an existing VM](../operations/vm-control/vm-update-resources.md#add-gpu)
* [Changing the number of GPUs](../operations/vm-control/vm-update-resources.md#update-gpu)
