# How to determine the speed of communication channels



## Issue description {#case-description}

You need to find out the speed of communication channels in {{ yandex-cloud }}.

## Solution {#case-resolution}

Connection speed may vary across different parts of the {{ yandex-cloud }} infrastructure. The final value depends on the network load profile, the capacity of the transmission endpoints, the quality of the connecting channels, and the traffic processing rules at intermediate nodes.

The speed is several gigabits between VMs belonging to the same availability zone and hundreds of megabits between VMs residing in different availability zones. For connections from a VM to a remote web endpoint, the speed depends on the route. We do not limit the speed on our side, so it can reach hundreds of megabits.

You can run tests independently, e.g., using `iperf`. We do not provide specific figures as they heavily depend on your resource configuration. This is particularly relevant for accessing external IP addresses, as some traffic is routed externally via the internet where we cannot guarantee speed.