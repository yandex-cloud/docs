# Navigation

#### Where can I view a VM's RAM chart? {#ram-graphs-overview}

{{ compute-full-name }} can't measure vRAM consumption inside the guest operating system because for the service, memory consumption by the VM is always the same: whatever's allocated the moment it's started.

You can configure collecting custom metrics yourself [via the API](../operations/metric/add.md), and for Linux-compatible operating systems using the [agent for delivering system metrics](../operations/unified-agent/linux_metrics.md).

#### Where can I view a VM's disk space chart? {#space-graphs-overview}

{{ monitoring-name }} can't access guest operating systems, so there is no such metric.

You can configure collecting custom metrics yourself [via the API](../operations/metric/add.md), and for Linux-compatible operating systems using the [agent for delivering system metrics](../operations/unified-agent/linux_metrics.md). The agent lets you collect statistics on the use of most system resources: CPU, RAM, network, and disk.