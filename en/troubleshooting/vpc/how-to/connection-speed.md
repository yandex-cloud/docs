# How to determine the speed of communication channels


## Issue description {#issue-description}

You need to find out the speed of communication channels in Yandex Cloud.

## Solution {#case-resolution}

Connection speeds vary between different parts of the Yandex Cloud infrastructure. The ultimate speed depends on the network load profile, the capacity of the transmission endpoints, the quality of the connecting channels, and the traffic processing rules at intermediate nodes.

The speed is several gigabits between VMs belonging to the same availability zone, hundreds of megabits between VMs residing in different availability zones. For connections from a VM instance to a remote web endpoint, the speed depends on the route. We do not limit the speed on our side, so it can reach hundreds of megabits.

You can run tests independently, for example, using `iperf`. We do not provide specific figures as they heavily depend on your resource configuration. This is particularly relevant for accessing external IPs, as some traffic is routed externally via the internet where we cannot guarantee speed.