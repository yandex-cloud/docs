# How to enable Egress NAT


## Scenario description {#case-description}

You need to enable Egress NAT in the cloud to access online resources without public IP addresses.

## Solution {#case-resolution}

The "Egress NAT" functionality has been deprecated: you cannot enable it for new {{ yandex-cloud }} resources. Use a [NAT gateway](https://cloud.yandex.ru/docs/vpc/concepts/gateways#nat-gateway) to grant internet access to cloud resources without assigning them public IP addresses.