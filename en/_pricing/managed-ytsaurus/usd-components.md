| Resource      | Rate for 1 hour,<br>without VAT                      | Rate for 1 month,<br>without VAT |
|---------------|-----------------------------------------------------:|----------------------------:|
| **Compute Node (Intel Ice Lake)** |
| 100% vCPU     | {{ sku|USD|yt.compute-nodes.cpu.v3|string }} | {{ sku|USD|yt.compute-nodes.cpu.v3|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|yt.compute-nodes.ram.v3|string }} | {{ sku|USD|yt.compute-nodes.ram.v3|month|string }} |
| **Compute Node (AMD Epyc with Nvidia A100)** |
| 100% vCPU     | {{ sku|USD|yt.compute-nodes.cpu.gpu-standard-v3|string }} | {{ sku|USD|yt.compute-nodes.cpu.gpu-standard-v3|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|yt.compute-nodes.ram.gpu-standard-v3|string }} | {{ sku|USD|yt.compute-nodes.ram.gpu-standard-v3|month|string }} |
| 1 GPU Nvidia A100 | {{ sku|USD|yt.compute-nodes.gpu.gpu-standard-v3|string }} | {{ sku|USD|yt.compute-nodes.gpu.gpu-standard-v3|month|string }} |
| **Compute Node (Intel Cascade Lake with Nvidia Tesla V100)**|
| 100% vCPU     | {{ sku|USD|yt.compute-nodes.cpu.gpu-standard-v2|string }} | {{ sku|USD|yt.compute-nodes.cpu.gpu-standard-v2|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|yt.compute-nodes.ram.gpu-standard-v2|string }} | {{ sku|USD|yt.compute-nodes.ram.gpu-standard-v2|month|string }} |
| 1 GPU Nvidia Tesla V100 | {{ sku|USD|yt.compute-nodes.gpu.gpu-standard-v2|string }} | {{ sku|USD|yt.compute-nodes.gpu.gpu-standard-v2|month|string }} |
| **Compute Node (Intel Ice Lake with T4i)** |
| 100% vCPU     | {{ sku|USD|yt.compute-nodes.cpu.gpu-standard-t4i|string }} | {{ sku|USD|yt.compute-nodes.cpu.gpu-standard-t4i|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|yt.compute-nodes.ram.gpu-standard-t4i|string }} | {{ sku|USD|yt.compute-nodes.ram.gpu-standard-t4i|month|string }} |
| 1 GPU | {{ sku|USD|yt.compute-nodes.gpu.gpu-standard-t4i|string }} | {{ sku|USD|yt.compute-nodes.gpu.gpu-standard-t4i|month|string }} |
| **Master Node (Intel Ice Lake)** |
| 100% vCPU     | {{ sku|USD|yt.master-nodes.cpu.v3|string }} | {{ sku|USD|yt.master-nodes.cpu.v3|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|yt.master-nodes.ram.v3|string }} | {{ sku|USD|yt.master-nodes.ram.v3|month|string }} |
| **Proxy Node (Intel Ice Lake)** |
| 100% vCPU     | {{ sku|USD|yt.proxy-nodes.cpu.v3|string }} | {{ sku|USD|yt.proxy-nodes.cpu.v3|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|yt.proxy-nodes.ram.v3|string }} | {{ sku|USD|yt.proxy-nodes.ram.v3|month|string }} |
| **Storage Node (Intel Ice Lake)** |
| 100% vCPU     | {{ sku|USD|yt.storage-nodes.cpu.v3|string }} | {{ sku|USD|yt.storage-nodes.cpu.v3|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|yt.storage-nodes.ram.v3|string }} | 720 × {{ sku|USD|yt.storage-nodes.ram.v3|string }} |
| **System Node (Intel Ice Lake)** |
| 100% vCPU     | {{ sku|USD|yt.system-nodes.cpu.v3|string }} | {{ sku|USD|yt.system-nodes.cpu.v3|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|yt.system-nodes.ram.v3|string }} | {{ sku|USD|yt.system-nodes.ram.v3|month|string }} |
| **Tablet Node (Intel Ice Lake)** |
| 100% vCPU     | {{ sku|USD|yt.tablet-nodes.cpu.v3|string }} | {{ sku|USD|yt.tablet-nodes.cpu.v3|month|string }} |
| RAM (for 1 GB) | {{ sku|USD|yt.tablet-nodes.ram.v3|string }} | {{ sku|USD|yt.tablet-nodes.ram.v3|month|string }} |
