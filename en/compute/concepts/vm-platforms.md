---
title: Platforms
description: In this article, you will learn about available platforms when creating a VM.
---

# Platforms


{{ compute-full-name }} provides various types of physical processors. Choosing a platform guarantees the type of physical processor in the data center and determines the supported vCPU and RAM configurations. You can also add a graphics accelerator ([GPU](gpus.md)) to a VM. You need to choose a platform each time you create a new VM.


{% note warning %}

The `{{ region-id }}-d` and `{{ region-id }}-e` [availability zones](../../overview/concepts/geo-scope.md) do not support VM instances on certain {{ compute-name }} platforms. For more information, see [Limitations](#restrictions).

{% endnote %}


## Standard platforms {#standard-platforms}

Platform | Processor | Maximum number of</br> cores (vCPUs)per VM | CPU base</br> clock rate (GHz)
--- | --- | --- | ---
Intel Broadwell</br>(`standard-v1`) | [Intel® Xeon® Processor E5-2660 v4](https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html) | 32 | 2.00
Intel Cascade Lake</br>(`standard-v2`) | [Intel® Xeon® Gold 6230](https://ark.intel.com/content/www/us/en/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html) | 80 | 2.10
Intel Ice Lake</br>(`standard-v3`) | [Intel® Xeon® Gold 6338](https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html) | 96 | 2.00
AMD Zen 3</br>(`amd-v1`)^1^ | [AMD EPYC™ 7713](https://www.amd.com/en/products/processors/server/epyc/7003-series/amd-epyc-7713.html) | 128 | 2.00
AMD Zen 4</br>(`standard-v4a`) | [AMD EPYC™ 9654](https://www.amd.com/en/products/processors/server/epyc/4th-generation-9004-and-8004-series/amd-epyc-9654.html) | 288 | 2.40

{% include [amd-platform-preview](../../_includes/compute/amd-platform-preview.md) %}

{% note warning %}

{% include [vcpu-note](../../_includes/compute/vcpu-note.md) %}

{% endnote %}

## High-performance platforms {#compute-optimized-platforms}

Platform | Processor | Maximum number of</br> cores (vCPUs) per VM | CPU base</br> clock rate (GHz)
--- | --- | --- | ---
{{ highfreq-ice-lake }}</br>(`highfreq-v3`) | [Intel® Xeon® Processor 6354](https://ark.intel.com/content/www/us/en/ark/products/212460/intel-xeon-gold-6354-processor-39m-cache-3-00-ghz.html) | 56 | 3.00
AMD Zen 4 Compute-Optimized</br>(`highfreq-v4a`) | [AMD EPYC™ 9374F](https://www.amd.com/en/products/processors/server/epyc/4th-generation-9004-and-8004-series/amd-epyc-9374f.html) | 80 | 3.85

## Platforms with GPUs {#gpu-platforms}

Platform | Graphics</br> accelerator | Processor | Specifications
--- | --- | --- | ---
Intel Broadwell with</br>NVIDIA® Tesla® V100</br>(`gpu-standard-v1`) | [NVIDIA® Tesla® V100](https://www.nvidia.com/en-us/data-center/v100/) | [Intel® Xeon®</br>Processor E5-2660 v4](https://ark.intel.com/content/www/us/en/ark/products/91772/intel-xeon-processor-e5-2660-v4-35m-cache-2-00-ghz.html) | **Maximum number of GPUs per VM**: 4 </br> **Number of vCPUs per GPU**: 8 </br> **RAM per GPU**: 96 GB
Intel Cascade Lake</br>with NVIDIA® Tesla® V100</br>(`gpu-standard-v2`) | [NVIDIA® Tesla® V100](https://www.nvidia.com/en-us/data-center/v100/) | [Intel® Xeon® Gold 6230](https://ark.intel.com/content/www/us/en/ark/products/192437/intel-xeon-gold-6230-processor-27-5m-cache-2-10-ghz.html) | **Maximum number of GPUs per VM**: 8 </br> **Number of vCPUs per GPU**: 8 </br> **RAM per GPU**: 48 GB
AMD EPYC™</br>with NVIDIA® Ampere® A100</br>(`gpu-standard-v3`) | [NVIDIA® Ampere® A100](https://www.nvidia.com/en-us/data-center/a100/) | [AMD EPYC™ 7702](https://www.amd.com/en/products/cpu/amd-epyc-7702) | **Maximum number of GPUs per VM**: 8 </br> **Number of vCPUs per GPU**: 28 </br> **RAM per GPU**: 119 GB
Gen2</br>(`gpu-standard-v3i`) | Gen2 | [Gen2](https://www.amd.com/en/products/processors/server/epyc/4th-generation-9004-and-8004-series/amd-epyc-9474f.html) | **Maximum number of GPUs per VM**: 8 </br> **Number of vCPUs per GPU**: 22.5 or 18 </br> **RAM per GPU**: 180 or 144 GB
Intel Ice Lake with</br>NVIDIA® Tesla® T4</br>(`standard-v3-t4`) | [NVIDIA® Tesla® T4](https://www.nvidia.com/en-us/data-center/tesla-t4//) | [Intel® Xeon® Gold 6338](https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html) | **Maximum number of GPUs per VM**: 1 </br> **Number of vCPUs per GPU**: 4, 8, 16, or 32 </br> **RAM per GPU**: 16, 32, 64, or 128 GB
{{ t4i-ice-lake }}</br>(`standard-v3-t4i`) | T4i | [Intel® Xeon® Gold 6338](https://ark.intel.com/content/www/us/en/ark/products/212285/intel-xeon-gold-6338-processor-48m-cache-2-00-ghz.html) | **Maximum number of GPUs per VM**: 1 </br> **Number of vCPUs per GPU**: 4, 8, 16, or 32 </br> **RAM per GPU**: 16, 32, 64, or 128 GB
GPU PLATFORM V4</br>(`gpu-standard-v4`) | GPU V4 | Intel® Xeon® Platinum | **Maximum number of GPUs per VM**: 8 </br> **Number of vCPUs per GPU**: 22 or 22.5 </br> **RAM per GPU**: 220 or 225 GB

## Limits {#restrictions}

The table below shows which {{ compute-name }} platforms are supported in the `{{ region-id }}-d` and `{{ region-id }}-e` [availability zones](../../overview/concepts/geo-scope.md).

#|
|| {align="center"} platform | Availability zone {align="center"} | > ||
|| ^ | `{{ region-id }}-d` | `{{ region-id }}-e` ||
|| **Standard platforms** {align="center"} | > | > ||
|| Intel Broadwell | ![image](../../_assets/common/no.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| Intel Cascade Lake | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| Intel Ice Lake | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| AMD Zen 3 | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| AMD Zen 4 | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| **High-performance platforms** {align="center"} | > | > ||
|| {{ highfreq-ice-lake }} | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| AMD Zen 4 Compute-Optimized | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|| **Platforms with GPUs** {align="center"} | > | > ||
|| {{ v100-broadwell }} | ![image](../../_assets/common/no.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| {{ v100-cascade-lake }} | ![image](../../_assets/common/no.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| {{ a100-epyc }} | ![image](../../_assets/common/no.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| Gen2 | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| {{ t4-ice-lake }} | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| {{ t4i-ice-lake }} | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/no.svg) {align="center"} ||
|| GPU PLATFORM V4 | ![image](../../_assets/common/yes.svg) {align="center"} | ![image](../../_assets/common/yes.svg) {align="center"} ||
|#

{% note tip %}

To migrate a VM with a non-supported platform from the `{{ region-id }}-d` or `{{ region-id }}-e` zone, do one of the following:
* [Take](../operations/disk-control/create-snapshot.md) a disk snapshot and use it to [create](../operations/vm-create/create-from-snapshots.md) a new VM in the `{{ region-id }}-d` or `{{ region-id }}-e` zone on a different platform.
* [Stop](../operations/vm-control/vm-stop-and-start.md#stop) the VM, [change](../operations/vm-control/vm-update-resources.md#update-vcpu-ram) the platform, and [move](../operations/vm-control/vm-change-zone.md#relocate-command) the VM by running [yc compute instance relocate](../cli-ref/instance/relocate.md).

{% endnote %}

### See also {#see-also}

* [Supported vCPU and RAM configurations](performance-levels.md)
* [Supported GPU, vCPU, and RAM configurations](gpus.md#config)
* [Pricing for computing resources on different platforms](../pricing.md#prices)
