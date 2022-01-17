# Computing resource configurations

Once you create a project, it runs with the minimum resource configuration: <q>c1.4</q> (4 vCPUs).
You can [change the configuration](../operations/projects/control-compute-resources.md) when working in the notebook. In this case, the state of the interpreter is saved: no variables or computation results are lost.

| Name | Number of vCPUs | Number of GPUs |
| ---- | ---- | ---- |
| **Configurations with vCPUs on the<br>[Intel Broadwell platform](../../compute/concepts/performance-levels.md)** |
| **c1.4** (default) | 4 | 0 |
| **c1.8** | 8 | 0 |
| **c1.32** (request by writing to support) | 32 | 0 |
| **c1.80** (request by writing to support) | 80 | 0 |
| **Configurations with vCPUs on the<br>[Intel Broadwell platform](../../compute/concepts/performance-levels.md) and GPUs [NVIDIA® Tesla® V100](../../compute/concepts/gpus.md)** |
| **g1.1** (request by writing to support or bring your balance up to $10) | 8 | 1 |
| **g1.2** (request by writing to support) | 16 | 2 |
| **g1.4** (request by writing to support) | 32 | 4 |
| **Configurations with vCPUs on the<br>[AMD EPYC™ platform](../../compute/concepts/gpus.md) and GPUs on the [NVIDIA® Ampere® A100](https://www.nvidia.com/en-us/data-center/a100/)** |
| **g2.mig** | 4 | 1/8 |
| **g2.1** (request by writing to support) | 28 | 1 |
| **g2.2** (request by writing to support) | 56 | 2 |
| **g2.4** (request by writing to support) | 112 | 4 |
| **g2.8** (request by writing to support) | 224 | 8 |

#### See also

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)

