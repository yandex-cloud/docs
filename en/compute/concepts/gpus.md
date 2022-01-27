---
title: "GPU and vGPU - Graphics Accelerators"
description: "GPU is a graphics processor unit that handles certain types of data much more efficiently than vCPU can be used for complex calculations. Compute Cloud provides graphics accelerators (GPU) and virtual graphics accelerators (vGPU) as part of the graphics card."
---

# Graphics accelerators (GPUs and vGPUs)

{{ compute-short-name }} provides graphics accelerators (GPUs) and virtual graphics accelerators (vGPUs) as part of graphics cards. GPUs outperform vCPUs in processing certain types of data and can be used for complex computing.

The following GPUs are available in {{ compute-short-name }}:

* [NVIDIA® Tesla® V100]{% if region =="int" %}(https://www.nvidia.com/en-us/data-center/v100/){% else %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %} with 32 GB HBM2 (High Bandwidth Memory).
* [NVIDIA® Ampere® A100]{% if region =="int" %}(https://www.nvidia.com/en-us/data-center/a100/){% else %}(https://www.nvidia.com/ru-ru/data-center/a100/){% endif %} with 80 GB HBM2.

{% note warning %}

Unlike vGPUs, GPUs run in [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster) mode, which doesn't use the operating system's graphics drivers.

{% endnote %}

By default, the cloud has a zero [quota](../concepts/limits.md#quotas) for creating virtual machines with GPUs and vGPUs. To change the quota, contact [technical support]({{ link-console-support }}).

## Graphics accelerators (GPUs){#gpu}

Graphics accelerators are suitable for machine learning (ML), artificial intelligence (AI), and 3D rendering tasks.

You can control a GPU and RAM directly from your VM.

### NVIDIA® Tesla® V100{#tesla-v100}

The NVIDIA® Tesla® V100 GPU contains 5120 CUDA® cores for [high-performance computing]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/high-performance-computing/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/high-performance-computing/){% endif %}, and 640 Tensor Cores for deep learning (DL) tasks.

### NVIDIA® Ampere® A100 {#a100}

The NVIDIA® A100 GPU based on the {% if region =="int" %}[Ampere®](https://www.nvidia.com/en-us/data-center/ampere-architecture/){% else %}[Ampere®](https://www.nvidia.com/ru-ru/data-center/ampere-architecture/){% endif %} microarchitecture uses third-generation Tensor Cores and delivers 80 GB HBM2 memory with up to 2 TB/s bandwidth.

### VM configurations {#config}

Available configurations of computing resources:

* {{ v100-broadwell }} (`gpu-standard-v1`):

  Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB
  --- |  ---  |  ---  | ---
  1   |  32   |  8    | 96
  2   |  64   |  16   | 192
  4   |  128  |  32   | 384

* {{ v100-cascade-lake }} (`gpu-standard-v2`):

  Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB
  --- |  ---  |  ---  | ---
  1   |  32   |  8    | 48
  2   |  64   |  16   | 96
  4   |  128  |  32   | 192
  8   |  256  |  64   | 384

* {{ a100-epyc }} (`gpu-standard-v3`):

  Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB
  --- | --- | --- | ---
  1   | 80  | 28  | 119
  2   | 160 | 56  | 238
  4   | 320 | 112 | 476
  8   | 640 | 224 | 952

{% include [gpu-zones](../../_includes/compute/gpu-zones.md) %}

For more information about organizational and technical limits for VMs, see [Quotas and limits](../concepts/limits.md).

### OS images {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}

## Virtual graphics accelerators (vGPUs) {#vgpu}

{{ compute-short-name }} lets you virtualize graphics accelerators (GPUs). Virtual GPUs are created based on [NVIDIA® vGPU]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/virtualization/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/virtual-solutions/){% endif %} technology.

NVIDIA® vGPU software lets you use cards with GPUs for both graphics and computing tasks on vGPUs. This requires the appropriate [licenses](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf).

To use vGPU technology, you need:

* A VM running on the [platform](vm-platforms.md) `vgpu-standard-v1` with one of the following images:
  * [Ubuntu 18.04 LTS vGPU]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/f2e8k6h1vu1rc360rr0h){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/marketplace/products/f2e8k6h1vu1rc360rr0h){% endif %}.
  * [Windows Server 2019 Datacenter vGPU]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/f2ent6cnb49sf5n9s1u2){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/marketplace/products/f2ent6cnb49sf5n9s1u2){% endif %}.
* The [NVIDIA® RTX vWS]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/design-visualization/virtual-workstation/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/design-visualization/virtual-workstation/){% endif %} license to use [NVIDIA® vGPU](https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/solutions/resources/documents1/Virtual-GPU-Packaging-and-Licensing-Guide.pdf) technology.
* [NVIDIA® vGPU Software License Server](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html).

To work with the license, you can:

* Use your current license server.
The current license server must be available over the network from VMs with vGPUs.
* Create a VM with the NVIDIA® vGPU Software License Server in {{ yandex-cloud }}.
For information about how to install and configure the license server, see the [NVIDIA documentation](https://docs.nvidia.com/grid/ls/latest/grid-license-server-user-guide/index.html#installing-nvidia-grid-license-server).

### Configurations of VMs with vGPUs {#config-vgpu}

VMs with vGPUs can use the following configuration on {{ v100-broadwell }} 8G (`vgpu-standard-v1`):

Number of vGPUs | Number of vCPUs | RAM, GB | GPU RAM, GB
--- | --- | --- | ---
1 | 4 | 12 | 8

## GPU vs. vGPU comparison

{% include [gpu-vs-vgpu](../../_includes/compute/gpu-comparation.md) %}

## See also {#see-also}

* [{#T}](../operations/vm-create/create-vm-with-gpu.md).
* Learn how to [add a GPU to an existing VM](../operations/vm-control/vm-update-resources.md#add-gpu).
* Learn how to [change the number of GPUs](../operations/vm-control/vm-update-resources.md#update-gpu).
