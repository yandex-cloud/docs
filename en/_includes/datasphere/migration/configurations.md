{% note info %}

Since projects run on different {{ yandex-cloud }} platforms with different computing resources, {{ ml-platform-name }} does not guarantee that RAM will be 100% available.

{% endnote %}


| Name | Number of vCPUs | Number of GPUs | RAM, GB | VRAM, GB |
---- | ---- | ---- | ---- | ----
**Configurations with vCPUs based on [Intel Ice Lake](../../../compute/concepts/performance-levels.md)**
**c1.4** (default) | 4 | 0 | 32 | —
**c1.8** | 8 | 0 | 64 | —
**c1.32** ^1^ | 32 | 0 | 256 | —
**c1.80** ^2^ | 80 | 0 | 640 | —
**Configurations with vCPUs based on [Intel Broadwell](../../../compute/concepts/performance-levels.md) and [NVIDIA® Tesla® V100](../../../compute/concepts/gpus.md) GPU**
**g1.1** | 8 | 1 | From 48 to 96 | 32
**g1.2** | 16 | 2 | From 96 to 192 | 64
**g1.4** ^1^ | 32 | 4 | From 192 to 384 | 128
**Configurations with vCPUs based on [AMD EPYC™](../../../compute/concepts/gpus.md) and [NVIDIA® Ampere® A100](https://www.nvidia.com/en-us/data-center/a100/) GPU**
**g2.1** ^1^ | 28 | 1 | 119 | 80
**g2.2** ^1^ | 56 | 2 | 238 | 160
**g2.4** ^1^ | 112 | 4 | 476 | 320
**g2.8** ^2^ | 224 | 8 | 952 | From 320 to 640
**Configurations with vCPUs based on [Intel Ice Lake](../../../compute/concepts/performance-levels.md) and [NVIDIA® Tesla® T4](https://www.nvidia.com/en-us/data-center/tesla-t4/) GPU**
**gt4.1** ^1^ | 4 | 1 | 16 | 16

^1^ is available after you deposit at least $10 to your billing account or upon request to the support team.

^2^ is only available for businesses and upon request to the support team.


