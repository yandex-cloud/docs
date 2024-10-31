| Resource | Cost per hour | Cost per hour | With CVoS for 6 months | With CVoS for 1 year |
| --- | --- | --- | --- | ---
| **Intel Broadwell** | Regular VM | Preemptible&nbsp;VM | |
| 5% vCPU | {{ sku|USD|compute.vm.cpu.c05|string }} | {{ sku|USD|compute.vm.cpu.c05.preemptible|string }} | − | − |
| 20% vCPU | {{ sku|USD|compute.vm.cpu.c20|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible|string }} | − | − |
| 100% vCPU | {{ sku|USD|compute.vm.cpu.c100|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible|string }} | − | − |
| 1 NVIDIA V100 GPU | {{ sku|USD|compute.vm.gpu.gpu-standard|string }} | {{ sku|USD|compute.vm.gpu.gpu-standard.preemptible|string }} | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute.vm.ram|string }} | {{ sku|USD|compute.vm.ram.preemptible|string }} | − | − |
| **Intel Cascade Lake** | Regular VM | Preemptible&nbsp;VM | |
| 5% vCPU | {{ sku|USD|compute.vm.cpu.c05.v2|string }} | {{ sku|USD|compute.vm.cpu.c05.preemptible.v2|string }} | − | − |
| 20% vCPU | {{ sku|USD|compute.vm.cpu.c20.v2|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.v2|string }} | − | − |
| 50% vCPU | {{ sku|USD|compute.vm.cpu.50.v2|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.v2|string }} | − | − |
| 100% vCPU | {{ sku|USD|compute.vm.cpu.c100.v2|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.cpu.c100.standard.v2|string }} |
| 1 NVIDIA V100 GPU | {{ sku|USD|compute.vm.gpu.gpu-standard.v2|string }} | {{ sku|USD|compute.vm.gpu.gpu-standard.preemptible.v2|string }} | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.v2|string }} | {{ sku|USD|compute.vm.ram.preemptible.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.ram.standard.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.ram.standard.v2|string }} |
| **Intel Ice Lake** | Regular VM | Preemptible&nbsp;VM | |
| 20% vCPU | {{ sku|USD|compute.vm.cpu.c20.v3|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.v3|string }} | − | − |
| 50% vCPU | {{ sku|USD|compute.vm.cpu.c50.v3|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.v3|string }} | − | − |
| 100% vCPU | {{ sku|USD|compute.vm.cpu.c100.v3|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.v3|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v3|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.cpu.c100.standard.v3|string }} |
| 1 NVIDIA T4 GPU | {{ sku|USD|compute.vm.gpu.standard.v3-t4|string }} | {{ sku|USD|compute.vm.gpu.standard.v3-t4.preemptible|string }} | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.v3|string }} | {{ sku|USD|compute.vm.ram.preemptible.v3|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.ram.standard.v3|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.ram.standard.v3|string }} |
| **Intel Ice Lake with T4i** | Regular VM | Preemptible&nbsp;VM  | | |
| 100% vCPU | $0.008400 | $0.008400 | - | - |
| 1 GPU | $1.152000 | $1.152000 | - | - |
| RAM (for 1 GB) | $0.002240 | $0.002240 | - | - |
| **Intel Ice Lake (Compute Optimized)** | Regular VM | Preemptible&nbsp;VM | | |
| 100% vCPU | {{ sku|USD|compute.vm.cpu.c100.highfreq-v3|string }} | - | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.highfreq-v3|string }} | - | − | − |
| **AMD EPYC™** | Regular VM | Preemptible&nbsp;VM | |
| 100% vCPU | {{ sku|USD|compute.vm.cpu.c100.gpu-standard.v3|string }} | {{ sku|USD|compute.vm.cpu.c100.gpu-standard.preemptible.v3|string }} | − | − |
| 1 NVIDIA A100 GPU | {{ sku|USD|compute.vm.gpu.gpu-standard.v3|string }} | {{ sku|USD|compute.vm.gpu.gpu-standard.preemptible.v3|string }} | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.gpu-standard.v3|string }} | {{ sku|USD|compute.vm.ram.gpu-standard.preemptible.v3|string }} | − | − |
| **AMD EPYC™ 9474F with Gen2**^*^ | Regular VM | Preemptible&nbsp;VM  | | |
| 100% vCPU | $0.007200 | $0.007200 | - | - |
| 1 GPU | $13.338400 | $13.338400 | - | - |
| RAM (for 1 GB) | $0.002240 | $0.002240 | - | - |

^*^ Feature is available on request, subject to technical availability.
