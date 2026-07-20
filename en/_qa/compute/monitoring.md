# Monitoring resource utilization

{% include [minitoc](minitoc/monitoring.md) %}

#### How do I track vRAM usage through monitoring? {#track-vRAM-use}

{{ compute-name }} cannot measure vRAM usage within the guest OS. For {{ compute-name }}, a VM's memory usage is a fixed amount allocated at the moment the VM starts up.

To monitor the vRAM state, use {{ monitoring-full-name }}. With {{ monitoring-full-name }}, you can write custom metrics. For details, see [{#T}](../../monitoring/operations/metric/add.md). Just schedule a job to export the vRAM state data, and {{ monitoring-name }} will render it.