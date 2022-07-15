# Platforms

{{ compute-full-name }} provides various types of physical processors. Choosing a platform guarantees the type of physical processor in the data center and determines the set of valid vCPU and RAM configurations. You can also add a graphics accelerator (GPU) to a VM. You must choose a platform when creating each VM.

## Standard platforms {#standard-platforms}

| Platform | Processor | Max number of cores (vCPUs)</br> per VM | CPU base</br>clock rate (GHz) |
--- | --- | --- | ---
| {% if product == "yandex-cloud" %}Intel Broadwell</br>(`standard-v1`) | [Intel® Xeon® Processor E5-2660 v4]{% if lang == "ru" %}(https://ark.intel.com/ru/products/91772/Intel-Xeon-Processor-E5-2660-v4-35M-Cache-2_00-GHz){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html){% endif %} | 32 | 2.00 |
| Intel Cascade Lake</br>(`standard-v2`) | [Intel Xeon Gold 6230]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html){% endif %} | 80 | 2.10{% endif %} |
| Intel Ice Lake</br>(`standard-v3`) | [Intel Xeon Gold 6338]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html){% endif %} | 96 | 2.00 |

## Platforms with GPUs {#gpu-platforms}

| Platform | Graphics</br> accelerator | Processor | Characteristics |
--- | --- | --- | ---
| {% if product == "yandex-cloud" %}Intel Broadwell with</br>NVIDIA® Tesla® V100</br>(`gpu-standard-v1`) | [NVIDIA® Tesla® V100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/v100/){% endif %} | [Intel Xeon</br>Processor E5-2660 v4]{% if lang == "ru" %}(https://ark.intel.com/ru/products/91772/Intel-Xeon-Processor-E5-2660-v4-35M-Cache-2_00-GHz){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html){% endif %} | **Maximum number of GPUs per VM**: 4 </br> **Number of vCPUs per GPU**: 8 </br> **RAM per GPU**: 96 GB |
| Intel Cascade Lake</br>with NVIDIA® Tesla® V100</br>(`gpu-standard-v2`) | [NVIDIA® Tesla® V100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/v100/){% endif %} | [Intel Xeon Gold 6230]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html){% endif %} | **Max number of GPUs per VM**: 8 </br> **Number of vCPUs per GPU**: 8 </br> **RAM per GPU**: 48 GB |
| Intel Ice Lake with</br>NVIDIA® Tesla® T4</br>(`standard-v3-t4`) | [NVIDIA® Tesla® T4]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-t4//){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/tesla-t4//){% endif %} | [Intel Xeon Gold 6338]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html){% endif %} | **Max number of GPUs per VM**: 1 </br> **Number of vCPUs per GPU**: 32 </br> **RAM per GPU**: 128 GB{% endif %} |
| AMD EPYC™</br>with NVIDIA® Ampere® A100</br>(`gpu-standard-v3`) | [NVIDIA® Ampere® A100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/a100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/a100/){% endif %} | [AMD EPYC™ 7702]{% if lang == "ru" %}(https://www.amd.com/ru/products/cpu/amd-epyc-7702){% endif %}{% if lang == "en" %}(https://www.amd.com/en/products/cpu/amd-epyc-7702){% endif %} | **Max number of GPUs per VM**: 8 </br> **Number of vCPUs per GPU**: 28 </br> **RAM per GPU**: 119 GB |


{% if product == "yandex-cloud" %}

## Platforms with vGPUs {#vgpu-platforms}

{% include [vgpu-to-standard](../../_includes/compute/vgpu-to-standard.md) %}

| Platform | Graphics</br>accelerator | Processor | Characteristics |
--- | --- | --- | ---
| Intel Broadwell with</br>NVIDIA® vGPU Tesla® V100 8G</br>(`vgpu-standard-v1`) | [NVIDIA® Tesla® V100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/tesla-v100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/v100/){% endif %} | [Intel Xeon</br>Processor E5-2660 v4]{% if lang == "ru" %}(https://ark.intel.com/content/www/ru/ru/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html){% endif %}{% if lang == "en" %}(https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html){% endif %} | **Number of vGPUs**: 1</br>**Number of vCPUs**: 4</br>**RAM**: 12 GB</br>**GPU RAM**: 8 GB |

{% endif %}

## See also {#see-also}

* [Permitted vCPU and RAM configurations](performance-levels.md).
* [Permitted GPU, vCPU, and RAM configurations](gpus.md#config).
* [Pricing for computing resources on different platforms](../pricing.md#prices).