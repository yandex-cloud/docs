| Ресурс | Цена за 1 час,<br>вкл. НДС | Цена за 1 час,<br>вкл. НДС | Цена с CVoS на 6 месяцев,<br>вкл. НДС | Цена с CVoS на 1 год,<br>вкл. НДС |
| --- | --- | --- | --- | --- |
| **Intel Broadwell** | Обычная ВМ | Прерываемая&nbsp;ВМ | | |
| 5% vCPU | {{ sku|RUB|compute.vm.cpu.c05|string }} | {{ sku|RUB|compute.vm.cpu.c05.preemptible|string }} | − | − |
| 20% vCPU | {{ sku|RUB|compute.vm.cpu.c20|string }} | {{ sku|RUB|compute.vm.cpu.c20.preemptible|string }} | − | − |
| 100% vCPU | {{ sku|RUB|compute.vm.cpu.c100|string }} | {{ sku|RUB|compute.vm.cpu.c100.preemptible|string }} | − | − |
| 1 NVIDIA V100 GPU | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard|string }} | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard.preemptible|string }} | − | − |
| RAM (за 1 ГБ) | {{ sku|RUB|compute.vm.ram|string }} | {{ sku|RUB|compute.vm.ram.preemptible|string }} | − | − |
| **Intel Cascade Lake** | Обычная ВМ | Прерываемая&nbsp;ВМ | | |
| 5% vCPU | {{ sku|RUB|compute.vm.cpu.c05.v2|string }} | {{ sku|RUB|compute.vm.cpu.c05.preemptible.v2|string }} | − | − |
| 20% vCPU | {{ sku|RUB|compute.vm.cpu.c20.v2|string }} | {{ sku|RUB|compute.vm.cpu.c20.preemptible.v2|string }} | − | − |
| 50% vCPU | {{ sku|RUB|compute.vm.cpu.50.v2|string }} | {{ sku|RUB|compute.vm.cpu.c50.preemptible.v2|string }} | − | − |
| 100% vCPU | {{ sku|RUB|compute.vm.cpu.c100.v2|string }} | {{ sku|RUB|compute.vm.cpu.c100.preemptible.v2|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v2|string }} | {{ sku|RUB|v1.commitment.selfcheckout.y1.compute.vm.cpu.c100.standard.v2|string }} |
| RAM (за 1 ГБ) | {{ sku|RUB|compute.vm.ram.v2|string }} | {{ sku|RUB|compute.vm.ram.preemptible.v2|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.compute.vm.ram.standard.v2|string }} | {{ sku|RUB|v1.commitment.selfcheckout.y1.compute.vm.ram.standard.v2|string }} |
| **Intel Ice Lake** | Обычная ВМ | Прерываемая&nbsp;ВМ | | |
| 20% vCPU | {{ sku|RUB|compute.vm.cpu.c20.v3|string }} | {{ sku|RUB|compute.vm.cpu.c20.preemptible.v3|string }} | − | − |
| 50% vCPU | {{ sku|RUB|compute.vm.cpu.c50.v3|string }} | {{ sku|RUB|compute.vm.cpu.c50.preemptible.v3|string }} | − | − |
| 100% vCPU | {{ sku|RUB|compute.vm.cpu.c100.v3|string }} | {{ sku|RUB|compute.vm.cpu.c100.preemptible.v3|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v3|string }} | {{ sku|RUB|v1.commitment.selfcheckout.y1.compute.vm.cpu.c100.standard.v3|string }} |
| 1 GPU Nvidia T4 | {{ sku|RUB|compute_gpu.vm.gpu.standard.v3-t4|string }} | {{ sku|RUB|compute_gpu.vm.gpu.standard.v3-t4.preemptible|string }} | − | − |
| RAM (за 1 ГБ) | {{ sku|RUB|compute.vm.ram.v3|string }} | {{ sku|RUB|compute.vm.ram.preemptible.v3|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.compute.vm.ram.standard.v3|string }} | {{ sku|RUB|v1.commitment.selfcheckout.y1.compute.vm.ram.standard.v3|string }} |
| **Intel Cascade Lake with Nvidia V100** | Обычная ВМ | Прерываемая ВМ | | | 
| 100% vCPU | {{ sku|RUB|compute_gpu.vm.cpu.c100.gpu-standard.v2|string }} | {{ sku|RUB|compute_gpu.vm.cpu.c100.gpu-standard.preemptible.v2|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v2|string }} | {{ sku|RUB|v1.commitment.selfcheckout.y1.compute.vm.cpu.c100.standard.v2|string }} |
| 1 GPU Nvidia V100 | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard.v2|string }} | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard.preemptible.v2|string }} | − | − |
| RAM (за 1 ГБ) | {{ sku|RUB|compute_gpu.vm.ram.gpu-standard.v2|string }} | {{ sku|RUB|compute_gpu.vm.ram.gpu-standard.preemptible.v2|string }} | {{ sku|RUB|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v3|string }} | {{ sku|RUB|v1.commitment.selfcheckout.y1.compute.vm.ram.standard.v3|string }} |
| **Intel Ice Lake with T4i** | Обычная ВМ | Прерываемая&nbsp;ВМ | | |
| 100% vCPU | {{ sku|RUB|compute_gpu.vm.cpu.c100.gpu-standard.t4i|string }} | {{ sku|RUB|compute_gpu.vm.cpu.c100.gpu-standard.preemptible.t4i|string }} | - | - |
| 1 GPU | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard.t4i|string }} | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard.preemptible.t4i|string }} | - | - |
| RAM (за 1 ГБ) | {{ sku|RUB|compute_gpu.vm.ram.gpu-standard.t4i|string }} | {{ sku|RUB|compute_gpu.vm.ram.gpu-standard.preemptible.t4i|string }} | - | - |
| **Intel Ice Lake (Compute Optimized)** | Обычная ВМ | Прерываемая&nbsp;ВМ | | |
| 100% vCPU | {{ sku|RUB|compute.vm.cpu.c100.highfreq-v3|string }} | - | − | − |
| RAM (за 1 ГБ) | {{ sku|RUB|compute.vm.ram.highfreq-v3|string }} | - | − | − |
| **AMD EPYC™** | Обычная ВМ | Прерываемая&nbsp;ВМ | | |
| 100% vCPU | {{ sku|RUB|compute_gpu.vm.cpu.c100.gpu-standard.v3|string }} | {{ sku|RUB|compute_gpu.vm.cpu.c100.gpu-standard.preemptible.v3|string }} | − | − |
| 1 GPU Nvidia A100 | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard.v3|string }} | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard.preemptible.v3|string }} | − | − |
| RAM (за 1 ГБ) | {{ sku|RUB|compute_gpu.vm.ram.gpu-standard.v3|string }} | {{ sku|RUB|compute_gpu.vm.ram.gpu-standard.preemptible.v3|string }} | − | − |
| **AMD EPYC™ 9474F with Gen2**^*^ | Обычная ВМ | Прерываемая&nbsp;ВМ | | |
| 100% vCPU | {{ sku|RUB|compute_gpu.vm.cpu.c100.gpu-standard.v3i|string }} | {{ sku|RUB|compute_gpu.vm.cpu.c100.gpu-standard.preemptible.v3i|string }} | - | - |
| 1 GPU | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard.v3i|string }} | {{ sku|RUB|compute_gpu.vm.gpu.gpu-standard.preemptible.v3i|string }} | - | - |
| RAM (за 1 ГБ) | {{ sku|RUB|compute_gpu.vm.ram.gpu-standard.v3i|string }} | {{ sku|RUB|compute_gpu.vm.ram.gpu-standard.preemptible.v3i|string }} | - | - |

^*^ Доступ предоставляется по запросу, при наличии технической возможности.


