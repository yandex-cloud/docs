| **Intel Broadwell** | Regular VM | Preemptible VM |
| --- | --- | --- |
| 5% vCPU | {{ sku|KZT|compute.vm.cpu.c05|string }} | {{ sku|KZT|compute.vm.cpu.c05.preemptible|string }} |
| 20% vCPU | {{ sku|KZT|compute.vm.cpu.c20|string }} | {{ sku|KZT|compute.vm.cpu.c20.preemptible|string }} |
| 100% vCPU | {{ sku|KZT|compute.vm.cpu.c100|string }} | {{ sku|KZT|compute.vm.cpu.c100.preemptible|string }} |
| 1 GPU Nvidia V100 | {{ sku|KZT|compute.vm.gpu.gpu-standard|string }} | {{ sku|KZT|compute.vm.gpu.gpu-standard.preemptible|string }} |
| RAM (for 1 GB) | {{ sku|KZT|compute.vm.ram|string }} | {{ sku|KZT|compute.vm.ram.preemptible|string }} |

<br>

| **Intel Cascade Lake** | Regular VM | Preemptible VM |
| --- | --- | --- |
| 5% vCPU | {{ sku|KZT|compute.vm.cpu.c05.v2|string }} | {{ sku|KZT|compute.vm.cpu.c05.preemptible.v2|string }} |
| 20% vCPU | {{ sku|KZT|compute.vm.cpu.c20.v2|string }} | {{ sku|KZT|compute.vm.cpu.c20.preemptible.v2|string }} |
| 50% vCPU | {{ sku|KZT|compute.vm.cpu.50.v2|string }} | {{ sku|KZT|compute.vm.cpu.c50.preemptible.v2|string }} |
| 100% vCPU | {{ sku|KZT|compute.vm.cpu.c100.v2|string }} | {{ sku|KZT|compute.vm.cpu.c100.preemptible.v2|string }} |
| 1 GPU Nvidia V100 | {{ sku|KZT|compute.vm.gpu.gpu-standard.v2|string }} | {{ sku|KZT|compute.vm.gpu.gpu-standard.preemptible.v2|string }} |
| RAM (for 1 GB) | {{ sku|KZT|compute.vm.ram.v2|string }} | {{ sku|KZT|compute.vm.ram.preemptible.v2|string }} |

<br>

| **Intel Ice Lake** | Regular VM | Preemptible VM |
| --- | --- | --- |
| 20% vCPU | {{ sku|KZT|compute.vm.cpu.c20.v3|string }} | {{ sku|KZT|compute.vm.cpu.c20.preemptible.v3|string }} |
| 50% vCPU | {{ sku|KZT|compute.vm.cpu.c50.v3|string }} | {{ sku|KZT|compute.vm.cpu.c50.preemptible.v3|string }} |
| 100% vCPU | {{ sku|KZT|compute.vm.cpu.c100.v3|string }} | {{ sku|KZT|compute.vm.cpu.c100.preemptible.v3|string }} |
| 1 GPU Nvidia T4 | {{ sku|KZT|compute.vm.gpu.standard.v3-t4|string }} | {{ sku|KZT|compute.vm.gpu.standard.v3-t4.preemptible|string }} |
| RAM (for 1 GB) | {{ sku|KZT|compute.vm.ram.v3|string }} | {{ sku|KZT|compute.vm.ram.preemptible.v3|string }} |

<br>

| **AMD EPYC™** | Regular VM | Preemptible VM |
| --- | --- | --- |
| 100% vCPU | {{ sku|KZT|compute.vm.cpu.c100.gpu-standard.v3|string }} | {{ sku|KZT|compute.vm.cpu.c100.gpu-standard.preemptible.v3|string }} |
| 1 GPU Nvidia A100 | {{ sku|KZT|compute.vm.gpu.gpu-standard.v3|string }} | {{ sku|KZT|compute.vm.gpu.gpu-standard.preemptible.v3|string }} |
| RAM (for 1 GB) | {{ sku|KZT|compute.vm.ram.gpu-standard.v3|string }} | {{ sku|KZT|compute.vm.ram.gpu-standard.preemptible.v3|string }} |