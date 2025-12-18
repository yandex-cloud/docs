# How to read the `Connections quota utilization` chart



## Case description {#case-description}

You need to figure out how to read the `Connections quota utilization` chart.

## Solution {#case-resolution}

`Connections quota utilization` is a percentage of the limit (50,000) on the number of concurrent TCP/UDP connections on a VM instance. For each connection, we preserve a certain state, which is alive in the following scenarios:

* As long as the network connection is active.
* Until the session closes (`FIN`/`RST`).
* Within three minutes after receiving the last packet.

{% note info %}

Certain software, for example, Docker Swarm overlay networks, generate a lot of unclosed UDP connections. As a result, the limit may be quickly exhausted. To bypass this limit, you can enable the `Superflow` option that allows you to increase the connection limit with a large number of connections counted as one by the hypervisor.

{% endnote %}

When a VM's network subsystem is running, a certain part of its vCPU is utilized by default.

For example, in some cases, multiple network connections can be combined by the hypervisor into one _flow_. This approach differs from the software-based network acceleration, another way to speed up I/O operations on a VM.

If you enabled the **{{ ui-key.yacloud.component.compute.resources.field_sw-accelerated-net }}** option for the VM when creating it, incoming network packets will be processed on separate dedicated hypervisor cores. This way, you can reduce the vCPU consumption by your VM by making the services running on your VMs more stable at peak loads.

For more information, see [this guide](../../../compute/concepts/software-accelerated-network.md).