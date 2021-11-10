# Computing resource configurations

Once you create a project, it runs with the minimum resource configuration: <q>c1.4</q> (4 vCPUs).
You can [change the configuration](../operations/projects/control-compute-resources.md) when working in the notebook. In this case, the state of the interpreter is saved: no variables or computation results are lost.

#### Resource configurations available for service training and deployment

| Name | Number of vCPUs on the<br>[Intel Broadwell platform](../../compute/concepts/performance-levels.md) | Number of GPUs on the<br>[NVIDIA Tesla V100 platform](../../compute/concepts/gpus.md) |
| ---- | ---- | ---- |
| **c1.4** (default) | 4 | 0 |
| **c1.8** | 8 | 0 |
| **c1.32** (request by writing to support) | 32 | 0 |
| **c1.80** (request by writing to support) | 80 | 0 |
| **g1.1** (request by writing to support or bring your balance up to {% if region == "ru" %}₽500{% endif %}{% if region == "int" %}$10{% endif %}{% if region == "kz" %}₸3000{% endif %}) | 8 | 1 |
| **g1.2** (request by writing to support) | 16 | 2 |
| **g1.4** (request by writing to support) | 32 | 4 |

#### Computing configurations available only for training {#a100}

| Name | Number of vCPUs on the<br>[AMD EPYC™ platform](../../compute/concepts/gpus.md) | Number of <br> [NVIDIA® Ampere® A100]{% if lang == "ru" %}(https://www.nvidia.com/ru-ru/data-center/a100/){% endif %}{% if lang == "en" %}(https://www.nvidia.com/en-us/data-center/a100/){% endif %} GPUs |
| ---- | ---- | ---- |
| **g2.1** (request by writing to support) | 28 | 1 |
| **g2.8** (request by writing to support) | 224 | 8 |

#### See also

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)

