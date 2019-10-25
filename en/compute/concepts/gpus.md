# Graphics accelerators (GPUs)

{{ compute-full-name }} provides graphics accelerators (GPUs) as part of graphics cards. GPUs outperform vCPUs in processing certain types of data and can be used for complex computing.

{{ compute-short-name }} uses [NVIDIA Tesla V100](https://www.nvidia.com/en-us/data-center/tesla-v100/) GPUs with 32 GB HBM2.

The NVIDIA Tesla V100 graphics card contains 5120 CUDA cores that perform [high performance computing](https://www.nvidia.com/en-us/high-performance-computing/) (HPC), and 640 Tensor cores for deep learning (DL) tasks.

Graphics accelerators are also suitable for machine learning (ML), artificial intelligence (AI), and 3D rendering tasks.

You can control a GPU and RAM directly from your VM.

## VM configurations {#config}

Available VM configurations GPUs on [Intel Broadwell with NVIDIA Tesla V100](vm-platforms.md):

| Number of GPUs | Number of vCPUs | RAM |
| --- | --- | --- |
| 1 | 8 | 96 GB |
| 2 | 16 | 192 GB |
| 4 | 32 | 384 GB |

For more information about VM organizational and technical limits, see [Quotas and limits](../concepts/limits.md).

## OS images {#os}

{% include [gpu-os](../../_includes/compute/gpu-os.md) %}

## See also

* [Create a VM with a GPU](../operations/vm-create/create-vm-with-gpu.md).
* Learn how to [add a GPU to an existing VM](../operations/vm-control/vm-update-resources.md#add-gpu).
* Learn how to [change the number of GPUs](../operations/vm-control/vm-update-resources.md#update-gpu).

