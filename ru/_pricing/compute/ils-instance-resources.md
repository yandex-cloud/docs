| **Intel Ice Lake** | Обычная ВМ | Прерываемая ВМ |
| --- | --- | --- |
| 20% vCPU | {{ sku|ILS|compute.vm.cpu.c20.v3|string }} | {{ sku|ILS|compute.vm.cpu.c20.preemptible.v3|string }} |
| 50% vCPU | {{ sku|ILS|compute.vm.cpu.c50.v3|string }} | {{ sku|ILS|compute.vm.cpu.c50.preemptible.v3|string }} |
| 100% vCPU | {{ sku|ILS|compute.vm.cpu.c100.v3|string }} | {{ sku|ILS|compute.vm.cpu.c100.preemptible.v3|string }} |
| RAM (за 1 ГБ) | {{ sku|ILS|compute.vm.ram.v3|string }} | {{ sku|ILS|compute.vm.ram.preemptible.v3|string }} |

<br>

| **AMD EPYC™** | Обычная ВМ | Прерываемая ВМ |
| --- | --- | --- |
| 100% vCPU | {{ sku|ILS|compute.vm.cpu.c100.gpu-standard.v3|string }} | {{ sku|ILS|compute.vm.cpu.c100.gpu-standard.preemptible.v3|string }} |
| 1 GPU NVIDIA A100 | {{ sku|ILS|compute.vm.gpu.gpu-standard.v3|string }} | {{ sku|ILS|compute.vm.gpu.gpu-standard.preemptible.v3|string }} |
| RAM (за 1 ГБ) | {{ sku|ILS|compute.vm.ram.gpu-standard.v3|string }} | {{ sku|ILS|compute.vm.ram.gpu-standard.preemptible.v3|string }} |