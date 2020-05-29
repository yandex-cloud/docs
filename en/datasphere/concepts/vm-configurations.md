# List of available VM configurations

A project always runs on a VM with the minimal <q>S</q> configuration (2 vCPUs).

You can [migrate to a VM with a different configuration](../operations/projects/control-compute-resources.md) when working in the notebook. During migration, the state of the interpreter is saved: no variables or calculation results are lost.

**Available VM configurations:**

| Name | Number of vCPUs on the<br>[Intel Broadwell platform](../../compute/concepts/performance-levels.md) | Number of GPUs on the<br>[NVIDIA Tesla V100 platform](../../compute/concepts/gpus.md). |
| ---- | ---- | ---- |
| **S** | 4 | 0 |
| **L** | 8 | 1 |

#### See also

* [{#T}](../operations/projects/control-compute-resources.md)
* [{#T}](../../compute/concepts/performance-levels.md)
* [{#T}](../../compute/concepts/gpus.md)

