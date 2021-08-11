---
title: "GPU and vGPU - Graphics Accelerators"
description: "GPU is a graphics processor unit that handles certain types of data much more efficiently than vCPU can be used for complex calculations. Compute Cloud provides graphics accelerators (GPU) and virtual graphics accelerators (vGPU) as part of the graphics card."
keywords:
  - gpu
  - graphics processor
  - graphics cards 
  - графический процессор
  - графические карты
  - видео карты
---

# Graphics accelerators (GPUs and vGPUs)

{{ compute-short-name }} provides graphics accelerators (GPUs) and virtual graphics accelerators (vGPUs) as part of graphics cards. GPUs outperform vCPUs in processing certain types of data and can be used for complex computing.

{{ compute-short-name }} uses [NVIDIA® Tesla® V100]{% if region =="int" %}(https://www.nvidia.com/en-us/data-center/v100/){% else %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %} GPUs with 32 GB HBM2 (High Bandwidth Memory).

{% note warning %}

Unlike vGPUs, GPUs run in [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster) mode, which doesn't use the operating system's graphics drivers.

{% endnote %}

By default, the cloud has a zero [quota](../concepts/limits.md#quotas) for creating virtual machines with GPUs and vGPUs. To change the quota, contact [technical support]({{ link-console-support }}).

## Graphics accelerators (GPUs)

The NVIDIA® Tesla® V100 graphics card contains 5120 CUDA® cores that perform [high-performance computing]{% if region =="int" %}(https://www.nvidia.com/en-us/high-performance-computing/){% else %}(https://www.nvidia.com/ru-ru/high-performance-computing/){% endif %} (HPC), and 640 Tensor cores for deep learning (DL) tasks.

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

For more information about organizational and technical limits for VMs, see [Quotas and limits](../concepts/limits.md).

### OS images {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}

## Virtual graphics accelerators (vGPUs) {#vgpu}

{{ compute-short-name }} lets you virtualize graphics accelerators (GPUs). Virtual GPUs are created based on [NVIDIA® vGPU]{% if region =="int" %}(https://www.nvidia.com/en-us/data-center/virtual-solutions/){% else %}(https://www.nvidia.com/ru-ru/data-center/virtualization/){% endif %} technology.

NVIDIA® vGPU software lets you use cards with GPUs for both graphics and computing tasks on vGPUs. This requires the appropriate [licenses](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf).

To use vGPU technology, you need:

* A VM running on the [platform](vm-platforms.md) `vgpu-standard-v1` with one of the following images:
  * [Ubuntu 18.04 lts vGPU]{% if region =="int" %}(https://cloud.yandex.com/marketplace/products/f2e8k6h1vu1rc360rr0h){% else %}(https://cloud.yandex.ru/marketplace/products/f2e8k6h1vu1rc360rr0h){% endif %}.
  * [Windows Server 2019 Datacenter vGPU]{% if region =="int" %}(https://cloud.yandex.com/marketplace/products/f2ent6cnb49sf5n9s1u2){% else %}(https://cloud.yandex.ru/marketplace/products/f2ent6cnb49sf5n9s1u2){% endif %}.
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

* [{#T}](../operations/vm-create/create-vm-with-gpu.md).
* Learn how to [add a GPU to an existing VM](../operations/vm-control/vm-update-resources.md#add-gpu).
* Learn how to [change the number of GPUs](../operations/vm-control/vm-update-resources.md#update-gpu).

