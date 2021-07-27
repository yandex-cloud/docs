---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Computing resource configurations

Once you create a project, it runs with the minimal computing resource configuration: <q>c1.4</q> (4 vCPUs).
You can [change the configuration](../operations/projects/control-compute-resources.md) when working in the notebook. In this case, the state of the interpreter is saved: no variables or computation results are lost.

**Available configurations of computing resources:**

| Name | Number of vCPUs on the<br>[Intel Broadwell platform](../../compute/concepts/performance-levels.md) | Number of GPUs on the<br>[NVIDIA Tesla V100 platform](../../compute/concepts/gpus.md). |
| ---- | ---- | ---- |
| **c1.4** (default) | 4 | 0 |
| **c1.8** | 8 | 0 |
| **c1.80** (by request) | 80 | 0 |
| **g1.1** | 8 | 1 |
| **g1.4** (by request) | 32 | 4 |

#### See also

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)
