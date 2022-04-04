# Computing resource configurations

Once you create a project, it runs with the minimum resource configuration: <q>c1.4</q> (4 vCPUs).
You can [modify the configuration](../operations/projects/control-compute-resources.md) while using a notebook. In this case, the state of the interpreter is saved: no variables or computation results are lost.

{% note info %}

Since projects run on different {{ yandex-cloud }} platforms with different computing resources, {{ ml-platform-name }} does not guarantee that RAM will be 100% available.

{% endnote %}

| Name | Number of vCPUs | Number of GPUs | RAM, GB |
---- | ---- | ---- | ----
**Configurations with vCPUs using the [Intel Cascade Lake architecture](../../compute/concepts/performance-levels.md)**
**c1.4** (by default) | 4 | 0 | 32
**c1.8** | 8 | 0 | 64
**c1.32** (available upon request to technical support) | 32 | 0 | 256
**c1.80** (available to legal entities upon request to technical support) | 80 | 0 | 640
**Configurations with vCPUs using the [Intel Broadwell architecture](../../compute/concepts/performance-levels.md) and [NVIDIA® Tesla® V100](../../compute/concepts/gpus.md) GPUs**
**g1.1** (available upon request to technical support or with an account balance of at least $10) | 8 | 1 | between 48 and 96
**g1.2** (available upon request to technical support) | 16 | 2 | between 96 and 192
**g1.4** (available upon request to technical support) | 32 | 4 | between 192 and 384
**Configurations with vCPUs using the [AMD EPYC™ architecture](../../compute/concepts/gpus.md) and [NVIDIA® Ampere® A100](https://www.nvidia.com/en-us/data-center/a100/) GPUs**
**g2.mig** | 4 | 1/8 | 16
**g2.1** (available upon request to technical support) | 28 | 1 | 119
**g2.2** (available upon request to technical support) | 56 | 2 | 238
**g2.4** (available upon request to technical support) | 112 | 4 | 476
**g2.8** (available upon request to technical support) | 224 | 8 | 952

#### For details, see also {#see-also}

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)