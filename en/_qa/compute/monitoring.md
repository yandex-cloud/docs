# Monitoring resource utilization

{% include [minitoc](minitoc/monitoring.md) %}

#### Why does vCPU utilization displayed on the chart exceed 100%? {#why-cpu-more-100}

If your vCPUs feature guaranteed performance, e.g., 5%, the monitoring system treats the guaranteed 5% vCPU as the 100% expected utilization. With no other VMs sharing the physical core, you can get up to 100% of vCPU performance, which is 20 times the maximum expected utilization (20 times the 5%). Thus, the chart can show up to 2000%.

If you consistently observe vCPU utilization above 100% on the monitoring charts, we recommend increasing the guaranteed vCPU performance. Otherwise, if other VMs are allocated to the same physical core, your actual physical core utilization will drop to the guaranteed 5% (about 100 MHz). In such a scenario, the guest OS may fail to handle the workload and you could lose access to your VM.

#### How do I track vRAM usage through monitoring? {#track-vRAM-use}

{{ compute-name }} cannot measure vRAM usage within the guest OS. For {{ compute-name }}, a VM's memory usage is a fixed amount allocated at the moment the VM starts up.

To monitor the vRAM state, use {{ monitoring-full-name }}. It enables you to write custom metrics. For details, [this guide](../../monitoring/operations/metric/add.md). Just schedule a job to export the vRAM state data, and {{ monitoring-name }} will render it.