# How to monitor memory usage



## Case description {#case-description}

You need to obtain information about the used and remaining free space on the VM disk and RAM within the VM instance.

## Solution {#case-resolution}

Since utilization metrics are collected by the hypervisor, it sees the VM as using all allocated resources. To deliver metrics from within the VM, use `unified-agent`. For details of its installation and setup, see [this guide](../../../monitoring/concepts/data-collection/unified-agent/installation.md).
