# Computing resource configurations

Once you create a project, it runs with the minimal computing resource configuration: <q>c1.4</q> (4 vCPUs).
You can [change the configuration](../operations/projects/control-compute-resources.md) when working in the notebook. In this case, the state of the interpreter is saved: no variables or computation results are lost.

#### Configurations of computing resources available for training and deployment

| Name | Number of vCPUs on the<br>[Intel Broadwell platform](../../compute/concepts/performance-levels.md) | Number of GPUs on the<br>[NVIDIA Tesla V100 platform](../../compute/concepts/gpus.md). |
| ---- | ---- | ---- |
| **c1.4** (default) | 4 | 0 |
| **c1.8** | 8 | 0 |
| **c1.32** (by request) | 32 | 0|
| **c1.80** (by request) | 80 | 0 |
| **g1.1** | 8 | 1 |
| **g1.2** (by request) | 16 | 2 |
| **g1.4** (by request) | 32 | 4 |

#### Configurations of computing resources available only for training {#a100}

Name | Number of vCPUs on the<br>[AMD EPYC™ platform](../../compute/concepts/gpus.md) | Number of GPUs on the <br> {% if region =="int" %}[NVIDIA® Ampere®](https://www.nvidia.com/en-us/data-center/ampere-architecture/){% else %}[NVIDIA® Ampere®](https://www.nvidia.com/ru-ru/data-center/ampere-architecture/){% endif %}
---- | ---- | ----
**g2.1** (by request) | 28 | 1
**g2.8** (by request) | 224 | 8

#### See also

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)
