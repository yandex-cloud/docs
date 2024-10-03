# How to read the "Connections quota utilization" chart


## Scenario description {#case-description}

You need to figure out how to read the `Connections quota utilization` chart.

## Solution {#case-resolution}

`Connections quota utilization` is a percentage of the limit (**50,000**) on the number of simultaneously established TCP/UDP connections on a VM instance. For each connection, we preserve a certain state, which is alive in the following scenarios:

* As long as the network connection is active.
* Until the session closes (`FIN`/`RST`).
* Until three minutes have passed since the last packet.

{% note info %}

Certain software, for example, Docker Swarm overlay networks, generate lots of unclosed UDP connections. As a result, the limit may be quickly exhausted. To circumvent this restriction, you can enable the Superflow option, which allows you to increase the connection limit because large groups of connections are counted as one by the hypervisor.

{% endnote %}

When a VM's network subsystem is running, a certain part of its vCPU is utilized by default.

For example, several network connections in some cases can be combined  by the hypervisor into one flow.
This approach differs from software-based network acceleration, another way to speed up I/O operations on a VM.

If a **software-accelerated network** was enabled for the VM at creation, incoming network packets will be processed on separate dedicated hypervisor cores. This way, you can reduce the vCPU consumption by your VM by making the services running on your VMs more stable at peak loads.

For more details, see [here](../../../compute/concepts/software-accelerated-network).