# Resolving issues with network connection speed when accessing cloud resources



## Issue description {#issue-description}

* Slow network subsystem performance on cloud resources.
* Low speed when uploading data from a VM instance or to a VM instance with slight engagement of its computing resources (CPU, I/O).

## Solution

Yandex Cloud is not capping network bandwidth on its side. The throughput of network interfaces can reach hundreds of megabits in total for outgoing and incoming traffic.
The final speed greatly depends on the profile of the network load, the power of the traffic transmission endpoints, the quality of the linking channels, and the rules for processing traffic at intermediate nodes. The connection speed from the VM instance to a remote point in the global network will depend on the route.

If high network load is expected on your instance, we recommend considering a [software-accelerated network](../../../vpc/concepts/software-accelerated-network.md).

You can also get a dedicated channel with guaranteed bandwidth using the [Cloud Interconnect](https://cloud.yandex.ru/docs/interconnect/) service.

## If the issue persists {#if-issue-still-persists}

If the above recommendations did not help solve the issue, [create a request for technical support](https://console.cloud.yandex.ru/support?section=contact).
Provide the following information in the request:

1. IDs of problematic cloud resources.
2. Problem description.