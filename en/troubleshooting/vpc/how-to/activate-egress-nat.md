# How to enable Egress NAT



## Case description {#case-description}

You need to enable _Egress NAT_ in the cloud to access online resources without public IP addresses.

## Solution {#case-resolution}

The _Egress NAT_ feature has been deprecated and is no longer supported for new {{ yandex-cloud }} resources. Use a [NAT gateway](../../../vpc/concepts/gateways.md#nat-gateway) to grant internet access to cloud resources without assigning them public IP addresses.