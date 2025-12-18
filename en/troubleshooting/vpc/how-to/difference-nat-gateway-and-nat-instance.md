# How a NAT gateway is different from a NAT instance


## Case description {#case-description}

You need to understand how a NAT gateway is different from a NAT instance.

## Solution {#case-resolution}

A NAT gateway allows you to provide internet access to all resources located in your subnet without creating additional VMs. Thus, this is one of the {{ yandex-cloud }} resources you can enjoy free of charge. At the same time, NAT gateways use random public IP addresses from [certain ranges](../../../vpc/concepts/ips.md), making it impossible to add the address of a cloud resource located behind a specific NAT gateway to the whitelist of any other solution.

A NAT instance addresses these shortcomings by means of more flexible NAT configuration and traffic management. However, these advantages involve [paid resources](../../../vpc/tutorials/nat-instance/index.md#paid-resources): a VM and a public IP address.
