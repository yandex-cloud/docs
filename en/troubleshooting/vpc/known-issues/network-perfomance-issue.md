# Troubleshooting network performance when using cloud resources



## Issue description {#issue-description}

* Low network subsystem performance on cloud resources.
* Low transfer rates when reading from or writing to a virtual machine, even with minimum CPU or I/O usage.

## Solution {#issue-resolution}

{{ yandex-cloud }} does not cap network bandwidth on its side. The throughput of network interfaces can reach hundreds of megabits for outgoing and incoming traffic in total.

The final value depends on the network load profile, the capacity of the transmission endpoints, the quality of the connecting channels, and the traffic processing rules at intermediate nodes. The connection speed from the VM instance to a remote point in the global network depends on the route.

If high network load is expected on your instance, we recommend considering a [software-accelerated network](../../../vpc/concepts/software-accelerated-network.md).

You can also get a dedicated circuit with guaranteed bandwidth using [{{ interconnect-name }}](../../../interconnect/).

## If the issue persists {#if-issue-still-persists}

If the tips we provided above did not help you resolve the issue, [create a support ticket]({{ link-console-support }}). Provide the following information in your ticket:

1. IDs of cloud resources in question.
1. Issue description.