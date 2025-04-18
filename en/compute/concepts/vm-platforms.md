---
title: Platforms
description: In this article, you will learn about available platforms when creating a VM.
---

# Platforms


{{ compute-full-name }} provides various types of physical processors. Choosing a platform guarantees the type of physical processor in the data center and determines the supported vCPU and RAM configurations. You can also add a graphics accelerator ([GPU](gpus.md)) to a VM. You need to choose a platform each time you create a new VM.

{% note warning %}

The `{{ region-id }}-d` zone does not support VMs based on the Intel Broadwell platform. To [move](../operations/vm-control/vm-change-zone.md) such VMs to `{{ region-id }}-d`, do one of the following:

* Take a disk snapshot and use it to create a new VM in the `{{ region-id }}-d` zone on a different platform.
* Stop the VM, change the platform, and move the VM by running `relocate`.

{% endnote %}

## Standard platforms {#standard-platforms}

Platform | Processor | Maximum number of</br> cores (vCPUs) per VM | CPU base</br> clock rate (GHz)
--- | --- | --- | ---
Intel Broadwell</br>(`standard-v1`) | [Intel® Xeon® Processor E5-2660 v4](https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html) | 32 | 2.00
Intel Cascade Lake</br>(`standard-v2`) | [Intel® Xeon® Gold 6230](https://ark.intel.com/content/www/us/en/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html) | 80 | 2.10
Intel Ice Lake</br>(`standard-v3`) | [Intel® Xeon® Gold 6338](https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html) | 96 | 2.00

## High-performance platforms {#compute-optimized-platforms}

Platform | Processor | Maximum number of</br> cores (vCPUs) per VM | CPU base</br> clock rate (GHz)
--- | --- | --- | ---
{{ highfreq-ice-lake }}</br>(`highfreq-v3`) | [Intel® Xeon® Processor 6354](https://ark.intel.com/content/www/us/en/ark/products/212460/intel-xeon-gold-6354-processor-39m-cache-3-00-ghz.html) | 56 | 3.00

## Platforms with GPUs {#gpu-platforms}

Platform | Graphics</br> accelerator | Processor | Specifications
--- | --- | --- | --- 
Intel Broadwell with</br>NVIDIA® Tesla® V100</br>(`gpu-standard-v1`) | [NVIDIA® Tesla® V100](https://www.nvidia.com/en-us/data-center/v100/) | [Intel® Xeon®</br>Processor E5-2660 v4](https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html) | **Maximum number of GPUs per VM**: 4 </br> **Number of vCPUs per GPU**: 8 </br> **RAM per GPU**: 96 GB
Intel Cascade Lake</br>with NVIDIA® Tesla® V100</br>(`gpu-standard-v2`) | [NVIDIA® Tesla® V100](https://www.nvidia.com/en-us/data-center/v100/) | [Intel® Xeon® Gold 6230](https://ark.intel.com/content/www/us/en/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html) | **Maximum number of GPUs per VM**: 8 </br> **Number of vCPUs per GPU**: 8 </br> **RAM per GPU**: 48 GB
AMD EPYC™</br>with NVIDIA® Ampere® A100</br>(`gpu-standard-v3`) | [NVIDIA® Ampere® A100](https://www.nvidia.com/en-us/data-center/a100/) | [AMD EPYC™ 7702](https://www.amd.com/en/products/cpu/amd-epyc-7702) | **Maximum number of GPUs per VM**: 8 </br> **Number of vCPUs per GPU**: 28 </br> **RAM per GPU**: 119 GB
AMD EPYC™ 9474F</br>with Gen2</br>(`gpu-standard-v3i`) | Gen2 | [AMD EPYC™ 9474F](https://www.amd.com/en/products/processors/server/epyc/4th-generation-9004-and-8004-series/amd-epyc-9474f.html) | **Maximum number of GPUs per VM**: 8 </br> **Number of vCPUs per GPU**: 22.5 or 18 </br> **RAM per GPU**: 180 or 144 GB
Intel Ice Lake with</br>NVIDIA® Tesla® T4</br>(`standard-v3-t4`) | [NVIDIA® Tesla® T4](https://www.nvidia.com/en-us/data-center/tesla-t4//) | [Intel® Xeon® Gold 6338](https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html) | **Maximum number of GPUs per VM**: 1 </br> **Number of vCPUs per GPU**: 4, 8, 16, or 32 </br> **RAM per GPU**: 16, 32, 64, or 128 GB
{{ t4i-ice-lake }}</br>(`standard-v3-t4i`) | T4i | [Intel® Xeon® Gold 6338](https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html) | **Maximum number of GPUs per VM**: 1 </br> **Number of vCPUs per GPU**: 4, 8, 16, or 32 </br> **RAM per GPU**: 16, 32, 64, or 128 GB

## See also {#see-also}

* [Supported vCPU and RAM configurations](performance-levels.md)
* [Supported GPU, vCPU, and RAM configurations](gpus.md#config)
* [Pricing for computing resources on different platforms](../pricing.md#prices)
