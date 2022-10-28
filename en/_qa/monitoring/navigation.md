# Navigation

#### Where can I view a VM's RAM chart? {#ram-graphs-overview}

The {{ compute-full-name }} service can't measure vRAM consumption inside the guest operating system because for the service, memory consumption by the virtual machine is always the same: the one that is allocated the moment it is started.

You can configure collecting custom metrics yourself [via the API](../../monitoring/operations/metric/add.md), and for Linux-compatible operating systems using the [agent for delivering system metrics](../../monitoring/operations/unified-agent/linux_metrics.md).

#### Where can I view a VM's disk space chart? {#space-graphs-overview}

{{ monitoring-name }} can't access guest operating systems, so there is no such metric.

You can configure collecting custom metrics yourself [via the API](../../monitoring/operations/metric/add.md), and for Linux-compatible operating systems using the [agent for delivering system metrics](../../monitoring/operations/unified-agent/linux_metrics.md).