{% note info %}

Since projects run on different {{ yandex-cloud }} platforms with different computing resources, {{ ml-platform-name }} does not guarantee that RAM will be 100% available.

{% endnote %}

Name | Number of vCPUs | Number of GPUs | RAM, GB | VRAM, GB
---- | ---- | ---- | ---- | ----
**Configurations with vCPUs based on [Intel Ice Lake](../../../compute/concepts/performance-levels.md)**
**c1.4** (default) | 4 | 0 | 32 | —
**c1.8** | 8 | 0 | 64 | —
**c1.32** ^1^ | 32 | 0 | 256 | —
**c1.80** ^2^ | 80 | 0 | 640 | —
**Configurations with [Intel Broadwell](../../../compute/concepts/performance-levels.md) vCPUs and [NVIDIA® Tesla® V100](../../../compute/concepts/gpus.md) GPUs**
**g1.1** | 8 | 1 | 48 to 96 | 32
**g1.2** | 16 | 2 | 96 to 192 | 64
**g1.4** ^1^ | 32 | 4 | 192 to 384 | 128
**Configurations with [AMD EPYC™](../../../compute/concepts/gpus.md) vCPUs and [NVIDIA® Ampere® A100](https://www.nvidia.com/en-us/data-center/a100/) GPUs**
**g2.1** ^1^ | 28 | 1 | 119 | 80
**g2.2** ^1^ | 56 | 2 | 238 | 160
**g2.4** ^1^ | 112 | 4 | 476 | 320
**g2.8** ^2^ | 224 | 8 | 952 | 320 to 640
**Configurations with [Intel Ice Lake](../../../compute/concepts/performance-levels.md) vCPUs and [NVIDIA® Tesla® T4](https://www.nvidia.com/en-us/data-center/tesla-t4/) GPUs**
**gt4.1** ^1^ | 4 | 1 | 16 | 16
**Configurations with [Intel Ice Lake](../../../compute/concepts/performance-levels.md) vCPUs and [NVIDIA® Tesla® T4i](../../../compute/concepts/gpus.md#t4i) GPUs**
**gt4i.1** ^1^ | 8 | 1 | 32 | 24

^1^ Available after you deposit at least $10 to your billing account or upon a request to our support.

^2^ Only available for businesses and upon a request to our support.
