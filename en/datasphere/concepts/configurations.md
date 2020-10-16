# Computing resource configurations

Once you create a project, it runs with the minimal computing resource configuration: <q>S</q> (2 vCPUs).
You can [change the configuration](../operations/projects/control-compute-resources.md) when working in the notebook. In this case, the state of the interpreter is saved: no variables or computation results are lost.

**Available configurations of computing resources:**

| Name | Number of vCPUs on the<br>[Intel Broadwell platform](../../compute/concepts/performance-levels.md) | Number of GPUs on the<br>[NVIDIA Tesla V100 platform](../../compute/concepts/gpus.md). |
| ---- | ---- | ---- |
| **S** (default) | 4 | 0 |
| **M** | 8 | 0 |
| **L** | 8 | 1 |
| **XL** | 32 | 4 |

#### See also

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)
