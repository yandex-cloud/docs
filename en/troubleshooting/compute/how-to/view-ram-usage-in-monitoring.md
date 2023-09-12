# Getting details about RAM consumption for Compute Cloud instances

## Issue description {#case-description}

* You need to get details about RAM consumption on your Compute Cloud instance;
* You need to deliver metrics of RAM consumption for your instances to Yandex Cloud Monitoring.

## Solution {#case-resolution}

Yandex Compute Cloud cannot measure vRAM consumption within a guest OS. This service considers that the VM always consumes the amount of RAM allocated at startup.

You can use the API to set up collection of custom metrics.
For example, on a Linux-based OS, you can choose an [agent service](../../../monitoring/concepts/data-collection/unified-agent/index.md) within your VM to delivery system metrics. The agent allows you to collect statistics on the use of most system resources: CPU, RAM, network, and disk.

For more information, see the documentation articles:
* [Metric collection and export](../../../monitoring/qa/metrics-export.md).
* [Delivering Linux system metrics](../../../monitoring/operations/unified-agent/linux_metrics.md).