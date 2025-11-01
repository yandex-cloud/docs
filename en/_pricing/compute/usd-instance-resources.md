| Resource | Price per hour,<br>without VAT | Price per hour,<br>without VAT | With CVoS for 6 months,<br>without VAT | With CVoS for 12 months,<br>without VAT 
| --- | --- | --- | --- | --- 
**Intel Broadwell** | Regular VM | Preemptible&nbsp;VM | |
5% vCPU | {{ sku|USD|compute.vm.cpu.c05|string }} | {{ sku|USD|compute.vm.cpu.c05.preemptible|string }} | − | − 
20% vCPU | {{ sku|USD|compute.vm.cpu.c20|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible|string }} | − | − 
100% vCPU | {{ sku|USD|compute.vm.cpu.c100|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible|string }} | − | − 
1 NVIDIA V100 GPU | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard|string }} | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard.preemptible|string }} | − | − 
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram|string }} | {{ sku|USD|compute.vm.ram.preemptible|string }} | − | − 
**Intel Cascade Lake** | Regular VM | Preemptible&nbsp;VM | |
5% vCPU | {{ sku|USD|compute.vm.cpu.c05.v2|string }} | {{ sku|USD|compute.vm.cpu.c05.preemptible.v2|string }} | − | − 
20% vCPU | {{ sku|USD|compute.vm.cpu.c20.v2|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.v2|string }} | − | − 
50% vCPU | {{ sku|USD|compute.vm.cpu.50.v2|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.v2|string }} | − | − 
100% vCPU | {{ sku|USD|compute.vm.cpu.c100.v2|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.cpu.c100.standard.v2|string }} 
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.v2|string }} | {{ sku|USD|compute.vm.ram.preemptible.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.ram.standard.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.ram.standard.v2|string }} 
**Intel Ice Lake** | Regular VM | Preemptible&nbsp;VM | |
20% vCPU | {{ sku|USD|compute.vm.cpu.c20.v3|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.v3|string }} | − | − 
50% vCPU | {{ sku|USD|compute.vm.cpu.c50.v3|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.v3|string }} | − | − 
100% vCPU | {{ sku|USD|compute.vm.cpu.c100.v3|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.v3|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v3|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.cpu.c100.standard.v3|string }}
1 GPU Nvidia T4 | {{ sku|USD|compute_gpu.vm.gpu.standard.v3-t4|string }} | {{ sku|USD|compute_gpu.vm.gpu.standard.v3-t4.preemptible|string }} | − | − 
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.v3|string }} | {{ sku|USD|compute.vm.ram.preemptible.v3|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.ram.standard.v3|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.ram.standard.v3|string }} 
| **Intel Cascade Lake with Nvidia V100** | Regular VM | Preemptible VM | | | 
| 100% vCPU | {{ sku|USD|compute_gpu.vm.cpu.c100.gpu-standard.v2|string }} | {{ sku|USD|compute_gpu.vm.cpu.c100.gpu-standard.preemptible.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.cpu.c100.standard.v2|string }} |
| 1 GPU Nvidia V100 | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard.v2|string }} | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard.preemptible.v2|string }} | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute_gpu.vm.ram.gpu-standard.v2|string }} | {{ sku|USD|compute_gpu.vm.ram.gpu-standard.preemptible.v2|string }} | {{ sku|USD|v1.commitment.selfcheckout.m6.compute.vm.cpu.c100.standard.v3|string }} | {{ sku|USD|v1.commitment.selfcheckout.y1.compute.vm.ram.standard.v3|string }} |
| **Intel Ice Lake with T4i** | Regular VM | Preemptible&nbsp;VM  | | |
| 100% vCPU | {{ sku|USD|compute_gpu.vm.cpu.c100.gpu-standard.t4i|string }} | {{ sku|USD|compute_gpu.vm.cpu.c100.gpu-standard.preemptible.t4i|string }} | - | - |
| 1 GPU | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard.t4i|string }} | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard.preemptible.t4i|string }} | - | - |
| RAM (for 1 GB) | {{ sku|USD|compute_gpu.vm.ram.gpu-standard.t4i|string }} | {{ sku|USD|compute_gpu.vm.ram.gpu-standard.preemptible.t4i|string }} | - | - |
| **Intel Ice Lake (Compute Optimized)** | Regular VM | Preemptible&nbsp;VM | | |
| 100% vCPU | {{ sku|USD|compute.vm.cpu.c100.highfreq-v3|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.highfreq-v3|string }} | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.highfreq-v3|string }} | {{ sku|USD|compute.vm.ram.preemptible.highfreq-v3|string }} | − | − |
| **AMD EPYC™** | Regular VM | Preemptible&nbsp;VM | |
| 100% vCPU | {{ sku|USD|compute_gpu.vm.cpu.c100.gpu-standard.v3|string }} | {{ sku|USD|compute_gpu.vm.cpu.c100.gpu-standard.preemptible.v3|string }} | − | − 
1 GPU Nvidia A100 | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard.v3|string }} | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard.preemptible.v3|string }} | − | − 
RAM (for 1 GB) | {{ sku|USD|compute_gpu.vm.ram.gpu-standard.v3|string }} | {{ sku|USD|compute_gpu.vm.ram.gpu-standard.preemptible.v3|string }} | − | − 
| **Gen2**^*^ | Regular VM | Preemptible&nbsp;VM  | | |
| 100% vCPU | {{ sku|USD|compute_gpu.vm.cpu.c100.gpu-standard.v3i|string }} | {{ sku|USD|compute_gpu.vm.cpu.c100.gpu-standard.preemptible.v3i|string }} | - | - |
| 1 GPU | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard.v3i|string }} | {{ sku|USD|compute_gpu.vm.gpu.gpu-standard.preemptible.v3i|string }} | - | - |
| RAM (for 1 GB) | {{ sku|USD|compute_gpu.vm.ram.gpu-standard.v3i|string }} | {{ sku|USD|compute_gpu.vm.ram.gpu-standard.preemptible.v3i|string }} | - | - |
| **AMD Zen 3**^*^ | Regular VM | Preemptible&nbsp;VM | | |
| 20% vCPU | {{ sku|USD|compute.vm.cpu.c20.amd.v1|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.amd.v1|string }} | − | − |
| 50% vCPU | {{ sku|USD|compute.vm.cpu.c50.amd.v1|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.amd.v1|string }} | − | − |
| 100% vCPU | {{ sku|USD|compute.vm.cpu.c100.amd.v1|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.amd.v1|string }} | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.amd.v1|string }} | {{ sku|USD|compute.vm.ram.preemptible.amd.v1|string }} | − | − |
| **AMD Zen 4** | Regular VM | Preemptible&nbsp;VM | | |
| 20% vCPU | {{ sku|USD|compute.vm.cpu.c20.v4a|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.v4a|string }} | − | − |
| 50% vCPU | {{ sku|USD|compute.vm.cpu.c50.v4a|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.v4a|string }} | − | − |
| 100% vCPU | {{ sku|USD|compute.vm.cpu.c100.v4a|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.v4a|string }} | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.v4a|string }} | {{ sku|USD|compute.vm.ram.preemptible.v4a|string }} | − | − |
| **AMD Zen 4 (Compute-Optimized)** | Regular VM | Preemptible&nbsp;VM | | |
| 20% vCPU | {{ sku|USD|compute.vm.cpu.c20.highfreq-v4a|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.highfreq-v4a|string }} | − | − |
| 50% vCPU | {{ sku|USD|compute.vm.cpu.c50.highfreq-v4a|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.highfreq-v4a|string }} | − | − |
| 100% vCPU | {{ sku|USD|compute.vm.cpu.c100.highfreq-v4a|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.highfreq-v4a|string }} | − | − |
| RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.highfreq-v4a|string }} | {{ sku|USD|compute.vm.ram.preemptible.highfreq-v4a|string }} | − | − |
| **GPU PLATFORM V4** | Regular VM | Preemptible&nbsp;VM | | |
| 100% vCPU | {{ sku|USD|compute_gpu.vm.cpu.c100.standard.v4|string }} | {{ sku|USD|compute_gpu.vm.cpu.c100.standard.v4.preemptible|string }} | — | — |
| 1 GPU | {{ sku|USD|compute_gpu.vm.gpu.standard.v4|string }} | {{ sku|USD|compute_gpu.vm.gpu.standard.v4.preemptible|string }} | — | — |
| RAM (for 1 GB) | {{ sku|USD|compute_gpu.vm.ram.standard.v4|string }} | {{ sku|USD|compute_gpu.vm.ram.standard.v4.preemptible|string }} | — | — |

^*^ This feature is available upon request and subject to technical availability.
