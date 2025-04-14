# Navigation

#### Where can I see a VM RAM consumption chart? {#ram-graphs-overview}

{{ compute-full-name }} cannot measure the guest operating system vRAM consumption. In fact, the service sees the VM memory consumption as a constant: the amount of RAM allocated to it at start up.

You can configure the collection of custom metrics [via the API](../../monitoring/operations/metric/add.md) or using a [system metrics delivery agent](../../monitoring/operations/unified-agent/linux_metrics.md) for Linux operating systems.

#### Where can I see a VM disk space chart? {#space-graphs-overview}

There is no such metric because {{ monitoring-name }} cannot access guest operating systems.

You can configure the collection of custom metrics [via the API](../../monitoring/operations/metric/add.md) or using a [system metrics delivery agent](../../monitoring/operations/unified-agent/linux_metrics.md) for Linux operating systems.