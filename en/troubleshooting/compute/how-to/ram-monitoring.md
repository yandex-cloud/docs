# How to track memory usage


## Scenario description {#case-description}

You need to obtain information about the used and remaining free space on the VM disk and RAM within the VM instance.

## Solution {#case-resolution}

Usage metrics are collected on the hypervisor side, so from its point of view, the VM instance consumes the entire allocated volume. To deliver metrics from within the VM instance, use `unified-agent`. We describe the details of its installation and setup in the [documentation](../../../monitoring/concepts/data-collection/unified-agent/installation).
