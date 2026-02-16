# How to get details about RAM consumption for {{ compute-name }} VM instances


## Issue description {#case-description}

* You need to get details about RAM consumption for your {{ compute-name }} VM instance.
* You need to deliver metrics of RAM consumption for your VM instances to {{ monitoring-full-name }}.

## Solution {#case-resolution}

{{ compute-full-name }} cannot measure vRAM consumption within a guest OS. {{ compute-full-name }} assumes that the VM always consumes the amount of RAM allocated at startup.

You can use the API to set up collection of custom metrics. For example, on a Linux-based OS, you can choose an [agent](../../../monitoring/concepts/data-collection/unified-agent/index.md) running within your VM to deliver system metrics. This agent allows you to collect statistics for CPU, memory, network, and disk usage.

For more information, see these guides:

* [Collecting and exporting metrics](../../../monitoring/qa/metrics-export.md)
* [Delivering Linux system metrics](../../../monitoring/operations/unified-agent/linux_metrics.md)