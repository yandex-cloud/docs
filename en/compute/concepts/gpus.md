---
title: "Graphics accelerators (GPUs)"
description: "GPU (Graphics Processing Unit) is a graphics processor that outperforms vCPU in processing certain types of data. It can be used for complex computing. Compute Cloud provides graphics accelerators (GPUs) as part of graphics cards."
---

# Graphics accelerators (GPUs)

{{ compute-name }} provides graphics accelerators (GPUs) in different VM [configurations](#config). GPUs outperform CPUs in processing certain types of data and can be used for complex computing.

The following GPUs are available in {{ compute-name }}:
{% if product == "yandex-cloud" %}* [NVIDIA® Tesla® V100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/v100/){% endif %} with 32 GB HBM2 (High Bandwidth Memory). {% endif %}
* [NVIDIA® Ampere® A100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/a100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/a100/){% endif %} with 80 GB HBM2.
{% if product == "yandex-cloud" %}* [NVIDIA® Tesla® T4]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-t4/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/tesla-t4/){% endif %} with 16 GB GDDR6. {% endif %}

{% if product == "yandex-cloud" %}

{% note warning %}

GPUs run in [TCC](https://docs.nvidia.com/nsight-visual-studio-edition/reference/index.html#tesla-compute-cluster) mode, which doesn't use the operating system's graphics drivers.

{% endnote %}

{% endif %}

By default, the cloud has a zero [quota](../concepts/limits.md#compute-quotas) for creating VMs with GPUs. To change the [quota]({{ link-console-quotas }}), contact [technical support]({{ link-console-support }}).

{% if product == "yandex-cloud" %}

VMs with GPUs can't be created in `{{ region-id }}-c`. For more information, see [{#T}](../../overview/concepts/ru-central1-c-deprecation.md).

{% endif %}

{% if product == "cloud-il" %}

{% include [gpu-zones-il](../../_includes/compute/gpu-zones-il.md) %}

{% endif %}

## Graphics accelerators (GPUs){#gpu}

Graphics accelerators are suitable for machine learning (ML), artificial intelligence (AI), and 3D rendering tasks.

You can control a GPU and RAM directly from your VM.

{% if product == "yandex-cloud" %}

### NVIDIA® Tesla® V100 {#tesla-v100}

The NVIDIA® Tesla® V100 GPU contains 5120 CUDA® cores for [high-performance computing]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/high-performance-computing/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/high-performance-computing/){% endif %} (HPC) and 640 Tensor cores for deep learning (DL) tasks.

{% endif %}

### NVIDIA® Ampere® A100 {#a100}

The NVIDIA® A100 GPU based on the [Ampere®]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/ampere-architecture/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/ampere-architecture/){% endif %} microarchitecture uses third-generation Tensor Cores and delivers 80 GB HBM2 memory with up to 2 TB/s bandwidth.

{% if product == "yandex-cloud" %}

### NVIDIA® Tesla® T4 {#tesla-t4}

NVIDIA® Tesla® T4 on the [Turing™](https://images.nvidia.com/aem-dam/en-zz/Solutions/design-visualization/technologies/turing-architecture/NVIDIA-Turing-Architecture-Whitepaper.pdf) architecture uses Turing tensor cores as well as the RT cores and provides 16 GB of GDDR6 memory with a [throughput of 300 GB/s](https://www.nvidia.com/content/dam/en-zz/Solutions/Data-Center/tesla-t4/t4-tensor-core-datasheet-951643.pdf).

{% endif %}

### VM configurations {#config}

Available configurations of computing resources:

{% if product == "yandex-cloud" %}

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

{% endif %}

* {{ a100-epyc }} (`gpu-standard-v3`):

   | Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB |
   --- | --- | --- | ---
   | 1 | 80 | 28 | 119 |
   | 2 | 160 | 56 | 238 |
   | 4 | 320 | 112 | 476 |
   | 8 | 640 | 224 | 952 |

{% if product == "yandex-cloud" %}

* {{ t4-ice-lake }} (`gpu-standard-v3-t4`):

   | Number of GPUs | VRAM, GB | Number of vCPUs | RAM, GB |
   --- | --- | --- | ---
   | 1 | 16 | 4 | 16 |
   | 1 | 16 | 8 | 32 |
   | 1 | 16 | 16 | 64 |
   | 1 | 16 | 32 | 128 |

GPUs in VMs are provided in full. For example, if a configuration has 4 GPUs specified, your VM will have 4 full-featured GPU devices.

{% include [gpu-zones](../../_includes/compute/gpu-zones.md) %}

{% endif %}

For more information about organizational and technical limits for VMs, see [Quotas and limits](../concepts/limits.md).

### OS images {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}

## See also {#see-also}

* [{#T}](../operations/vm-create/create-vm-with-gpu.md).
* Learn how to [add a GPU to an existing VM](../operations/vm-control/vm-update-resources.md#add-gpu).
* Learn how to [change the number of GPUs](../operations/vm-control/vm-update-resources.md#update-gpu).