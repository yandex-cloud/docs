---
title: "GPU and vGPU - Graphics Accelerators"
description: "GPU is a graphics processor unit that handles certain types of data much more efficiently than vCPU can be used for complex calculations. Compute Cloud provides graphics accelerators (GPU) and virtual graphics accelerators (vGPU) as part of the graphics card."

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---


# Graphics accelerators (GPUs and vGPUs)

{{ compute-short-name }} provides graphics accelerators (GPUs) and virtual graphics accelerators (vGPUs) as part of graphics cards. GPUs outperform vCPUs in processing certain types of data and can be used for complex computing.

{{ compute-short-name }} uses [NVIDIA® Tesla® V100](https://www.nvidia.com/en-us/data-center/v100/) GPUs with 32 GB HBM2 (High Bandwidth Memory).

{% note warning %}

Unlike vGPUs, GPUs run in [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster) mode, which doesn't use the operating system's graphics drivers.

{% endnote %}

## Graphics accelerators (GPUs)

The NVIDIA® Tesla® V100 graphics card contains 5120 CUDA® cores that perform [high-performance computing](https://www.nvidia.com/en-us/high-performance-computing/) (HPC), and 640 Tensor cores for deep learning (DL) tasks.

Graphics accelerators are also suitable for machine learning (ML), artificial intelligence (AI), and 3D rendering tasks.

You can control a GPU and RAM directly from your VM.

### VM configurations {#config}

Available configurations of computing resources:

* Intel Broadwell with NVIDIA® Tesla® V100 (`gpu-standard-v1`):

  | Number of GPUs | Number of vCPUs | RAM, GB |
  | --- | --- | --- |
  | 1 | 8 | 96 |
  | 2 | 16 | 192 |
  | 4 | 32 | 384 |

* Intel Cascade Lake with NVIDIA® Tesla® V100 (`gpu-standard-v2`):

  | Number of GPUs | Number of vCPUs | RAM, GB |
  | --- | --- | --- |
  | 1 | 8 | 48 |
  | 2 | 16 | 96 |
  | 4 | 32 | 192 |
  | 8 | 64 | 384 |

For more information about VM organizational and technical limits, see [Quotas and limits](../concepts/limits.md).

### OS images {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}

## Virtual graphics accelerators (vGPUs) {#vgpu}

{{ compute-short-name }} lets you virtualize graphics accelerators (GPUs). Virtual GPUs are created based on [NVIDIA® vGPU](https://www.nvidia.com/en-us/data-center/virtual-solutions/) technology.

NVIDIA® vGPU software lets you use cards with GPUs for both graphics and computing tasks on vGPUs. This requires the appropriate [licenses](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf).

To use vGPU technology, you need:

* A VM running on the [platform](vm-platforms.md) `vgpu-standard-v1` with one of the following images:
  * [Ubuntu 18.04 lts vGPU](https://cloud.yandex.com/marketplace/products/f2e8k6h1vu1rc360rr0h).
  * [Windows Server 2019 Datacenter vGPU](https://cloud.yandex.com/marketplace/products/f2ent6cnb49sf5n9s1u2).
* License to use [NVIDIA® vGPU](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf) technology.
* [NVIDIA® vGPU Software License Server](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html).

To work with the license, you can:

* Use your current license server.
The current license server must be available over the network from VMs with vGPUs.
* Create a VM with the NVIDIA® vGPU Software License Server in {{ yandex-cloud }}.
For information about how to install and configure the license server, see the [NVIDIA documentation](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html#installing-nvidia-grid-license-server).

### Configurations of VMs with vGPUs {#config-vgpu}

VMs with vGPUs can use the following configuration on Intel Broadwell with NVIDIA® vGPU Tesla® V100 8G (`vgpu-standard-v1`):

  | Number of vGPUs | Number of vCPUs | RAM, GB | GPU RAM, GB |
  | --- | --- | --- | --- |
  | 1 | 4 | 12 | 8 |

## GPU vs. vGPU comparison

{% include [gpu-vs-vgpu](../../_includes/compute/gpu-comparation.md) %}

## See also {#see-also}

* [Create a VM with a GPU](../operations/vm-create/create-vm-with-gpu.md).
* Learn how to [add a GPU to an existing VM](../operations/vm-control/vm-update-resources.md#add-gpu).
* Learn how to [change the number of GPUs](../operations/vm-control/vm-update-resources.md#update-gpu).

