{% note info %}

Since projects run on different {{ yandex-cloud }} platforms with different computing resources, {{ ml-platform-name }} does not guarantee that RAM will be 100% available.

{% endnote %}


| Name | Number of vCPUs | Number of GPUs | RAM, GB |
---- | ---- | ---- | ----
**Configurations with vCPUs using the [Intel Ice Lake architecture](../../../compute/concepts/performance-levels.md)**
**c1.4** (default) | 4 | 0 | 32
**c1.8** | 8 | 0 | 64
**c1.32** ^1^ | 32 | 0 | 256
**c1.80** ^2^ | 80 | 0 | 640
**Configurations with vCPUs using the [Intel Broadwell architecture](../../../compute/concepts/performance-levels.md) and GPU [NVIDIA® Tesla® V100](../../../compute/concepts/gpus.md)**
**g1.1** ^1^ | 8 | 1 | From 48 to 96
**g1.2** ^1^ | 16 | 2 | From 96 to 192
**g1.4** ^1^ | 32 | 4 | From 192 to 384
**Configurations with vCPUs using the [AMD EPYC™ architecture](../../../compute/concepts/gpus.md) and GPU [NVIDIA® Ampere® A100](https://www.nvidia.com/en-us/data-center/a100/)**
**g2.mig** | 4 | 1/8 | 16
**g2.1** ^1^ | 28 | 1 | 119
**g2.2** ^1^ | 56 | 2 | 238
**g2.4** ^1^ | 112 | 4 | 476
**g2.8** ^2^ | 224 | 8 | 952

^1^ is available after you deposit at least $10 to your billing account or upon request to the support team.

^2^ is only available for businesses, upon individual request to the support team.


