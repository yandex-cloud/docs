**Intel Broadwell** | Regular VM | Preemptible VM
--- | --- | ---
vCPU 5% | {{ sku|USD|compute.vm.cpu.c05|string }} | {{ sku|USD|compute.vm.cpu.c05.preemptible|string }}
vCPU 20% | {{ sku|USD|compute.vm.cpu.c20|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible|string }}
vCPU 100% | {{ sku|USD|compute.vm.cpu.c100|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible|string }}
1 GPU Nvidia V100 | {{ sku|USD|compute.vm.gpu.gpu-standard|string }} | {{ sku|USD|compute.vm.gpu.gpu-standard.preemptible|string }}
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram|string }} | {{ sku|USD|compute.vm.ram.preemptible|string }}

<br>

**Intel Cascade Lake** | Regular VM | Preemptible VM
--- | --- | ---
vCPU 5% | {{ sku|USD|compute.vm.cpu.c05.v2|string }} | {{ sku|USD|compute.vm.cpu.c05.preemptible.v2|string }}
vCPU 20% | {{ sku|USD|compute.vm.cpu.c20.v2|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.v2|string }}
vCPU 50% | {{ sku|USD|compute.vm.cpu.50.v2|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.v2|string }}
vCPU 100% | {{ sku|USD|compute.vm.cpu.c100.v2|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.v2|string }}
1 GPU Nvidia V100 | {{ sku|USD|compute.vm.gpu.gpu-standard.v2|string }} | {{ sku|USD|compute.vm.gpu.gpu-standard.preemptible.v2|string }}
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.v2|string }} | {{ sku|USD|compute.vm.ram.preemptible.v2|string }}

<br>

**Intel Ice Lake** | Regular VM | Preemptible VM
--- | --- | ---
vCPU 20% | {{ sku|USD|compute.vm.cpu.c20.v3|string }} | {{ sku|USD|compute.vm.cpu.c20.preemptible.v3|string }}
vCPU 50% | {{ sku|USD|compute.vm.cpu.c50.v3|string }} | {{ sku|USD|compute.vm.cpu.c50.preemptible.v3|string }}
vCPU 100% | {{ sku|USD|compute.vm.cpu.c100.v3|string }} | {{ sku|USD|compute.vm.cpu.c100.preemptible.v3|string }}
1 GPU Nvidia T4 | {{ sku|USD|compute.vm.gpu.standard.v3-t4|string }} | {{ sku|USD|compute.vm.gpu.standard.v3-t4.preemptible|string }}
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.v3|string }} | {{ sku|USD|compute.vm.ram.preemptible.v3|string }}

<br>

**AMD EPYC™** | Regular VM | Preemptible VM
--- | --- | ---
vCPU 100% | {{ sku|USD|compute.vm.cpu.c100.gpu-standard.v3|string }} | {{ sku|USD|compute.vm.cpu.c100.gpu-standard.preemptible.v3|string }}
1 GPU Nvidia A100 | {{ sku|USD|compute.vm.gpu.gpu-standard.v3|string }} | {{ sku|USD|compute.vm.gpu.gpu-standard.preemptible.v3|string }}
RAM (for 1 GB) | {{ sku|USD|compute.vm.ram.gpu-standard.v3|string }} | {{ sku|USD|compute.vm.ram.gpu-standard.preemptible.v3|string }}
