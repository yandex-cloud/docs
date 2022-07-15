---
title: "GPU and vGPU - Graphics Accelerators"
description: "GPU is a graphics processor unit that handles certain types of data much more efficiently than vCPU can be used for complex calculations. Compute Cloud provides graphics accelerators (GPU) and virtual graphics accelerators (vGPU) as part of the graphics card."
---

# GPU and vGPU graphics accelerators

{{ compute-name }} provides graphics accelerators (GPUs) and virtual graphics accelerators (vGPUs) as part of graphics cards. GPUs outperform vCPUs in processing certain types of data and can be used for complex computing.

The following GPUs are available in {{ compute-name }}:
* [NVIDIA® Tesla® V100](https://www.nvidia.com/en-us/data-center/v100/) with 32 GB HBM2 (High Bandwidth Memory). 
* [NVIDIA® Ampere® A100](https://www.nvidia.com/en-us/data-center/a100/) with 80 GB HBM2.
* [NVIDIA® Tesla® T4](https://www.nvidia.com/en-us/data-center/tesla-t4/) with 16 GB GDDR6. 


{% note warning %}

Unlike vGPUs, GPUs run in [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster) mode, which doesn't use the operating system's graphics drivers.

{% endnote %}


By default, the cloud has a zero [quota](../concepts/limits.md#compute-quotas) for creating virtual machines with GPUs and vGPUs. To change the [quota]({{ link-console-quotas }}), contact [technical support]({{ link-console-support }}).


VMs with GPUs and vGPUs can't be created in `ru-central1-c`. For more information, see [{#T}](../../overview/concepts/ru-central1-c-deprecation.md).


## Graphics accelerators (GPUs){#gpu}

Graphics accelerators are suitable for machine learning (ML), artificial intelligence (AI), and 3D rendering tasks.

You can control a GPU and RAM directly from your VM.


### NVIDIA® Tesla® V100 {#tesla-v100}

The NVIDIA® Tesla® V100 GPU contains 5120 CUDA® cores for [high-performance computing](https://www.nvidia.com/en-us/high-performance-computing/) (HPC) and 640 Tensor cores for deep learning (DL) tasks.


### NVIDIA® Ampere® A100 {#a100}

The NVIDIA® A100 GPU based on the [Ampere®](https://www.nvidia.com/en-us/data-center/ampere-architecture/) microarchitecture uses third-generation Tensor Cores and delivers 80 GB HBM2 memory with up to 2 TB/s bandwidth.


### NVIDIA® Tesla® T4 {#tesla-t4}

NVIDIA® Tesla® T4 on the [Turing™](https://images.nvidia.com/aem-dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf) architecture uses Turing tensor cores as well as the RT cores and provides 16 GB of GDDR6 memory with a [throughput of 300 GB/s](https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/tesla-t4/t4-tensor-core-datasheet-951643.pdf).


### VM configurations {#config}

Available configurations of computing resources:


* {{ v100-broadwell }} (`gpu-standard-v1`):

   | Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB |
   --- | --- | --- | ---
   | 1 | 32 | 8 | 96 |
   | 2 | 64 | 16 | 192 |
   | 4 | 128 | 32 | 384 |

* {{ v100-cascade-lake }} (`gpu-standard-v2`):

   | Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB |
   --- | --- | --- | ---
   | 1 | 32 | 8 | 48 |
   | 2 | 64 | 16 | 96 |
   | 4 | 128 | 32 | 192 |
   | 8 | 256 | 64 | 384 |


* {{ a100-epyc }} (`gpu-standard-v3`):

   | Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB |
   --- | --- | --- | ---
   | 1 | 80 | 28 | 119 |
   | 2 | 160 | 56 | 238 |
   | 4 | 320 | 112 | 476 |
   | 8 | 640 | 224 | 952 |


* {{ t4-ice-lake }} (`gpu-standard-v3-t4`):

   | Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB |
   --- | --- | --- | ---
   | 1 | 16 | 32 | 128 |

{% include [gpu-zones](../../_includes/compute/gpu-zones.md) %}


For more information about organizational and technical limits for VMs, see [Quotas and limits](../concepts/limits.md).

### OS images {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}


## Virtual graphics accelerators (vGPUs) {#vgpu}

{% include [vgpu-to-standard](../../_includes/compute/vgpu-to-standard.md) %}

{{ compute-name }} lets you virtualize graphics accelerators (GPUs). Virtualization of machines with GPUs are created based on [NVIDIA® vGPU](https://www.nvidia.com/en-us/data-center/virtual-solutions/) technology.

NVIDIA® vGPU software lets you use cards with GPUs for both graphics and computing tasks on vGPUs. For this, you'll need the appropriate [licenses](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf).

To use vGPU technology, you need:
* VMs on the `gpu-standard-v1` [platform](vm-platforms.md) with one of the following images:
   * [Ubuntu 18.04 LTS vGPU](/marketplace/products/f2e8k6h1vu1rc360rr0h).
   * [Windows Server 2019 Datacenter vGPU](/marketplace/products/f2ent6cnb49sf5n9s1u2).
* [NVIDIA® RTX vWS](https://www.nvidia.com/en-us/design-visualization/virtual-workstation/) license to use [NVIDIA® vGPU](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf) technology.
* [NVIDIA® vGPU Software License Server](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html).

To work with the license, you can:
* Use your current license server.

   The current license server must be available over the network from VMs with vGPUs.
* Create a VM with the NVIDIA® vGPU Software License Server in {{ yandex-cloud }}.

   For information about how to install and configure the license server, see the [NVIDIA documentation](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html#installing-nvidia-grid-license-server).

### Configurations of VMs with vGPUs {#config-vgpu}

VMs with vGPUs can use the following configuration on {{ v100-broadwell }} 8G (`vgpu-standard-v1`):

| Number of vGPUs | Number of vCPUs | RAM, GB | GPU RAM, GB |
--- | --- | --- | ---
| 1 | 4 | 12 | 8 |

## GPU vs. vGPU comparison

{% include [gpu-vs-vgpu](../../_includes/compute/gpu-comparation.md) %}


## See also {#see-also}

* [{#T}](../operations/vm-create/create-vm-with-gpu.md).
* Learn how to [add a GPU to an existing VM](../operations/vm-control/vm-update-resources.md#add-gpu).
* Learn how to [change the number of GPUs](../operations/vm-control/vm-update-resources.md#update-gpu).