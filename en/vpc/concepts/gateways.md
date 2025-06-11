---
title: Gateways in {{ vpc-full-name }}
description: In this tutorial, you will learn about gateways used in {{ vpc-full-name }}.
---

# Gateways

## NAT gateway {#nat-gateway}

A _NAT gateway_ allows you to grant internet access permissions to cloud resources without assigning public IP addresses to them. Instead, they will access the internet via the NAT gateway that will be assigned an IP address from a separate range of public IPs. A gateway is a regional resource one can find in all availability zones. You can [manage gateways](../operations/create-nat-gateway.md) using the management console, CLI, Terraform, or API.

To route traffic through a gateway, specify it as the next hop in a [route table](routing.md). Currently, you can only use a route with the `0.0.0.0/0` destination prefix with a NAT gateway: all traffic bound outside the network will pass through the gateway.

If a VM network interface has a [public IP address](address.md#public-addresses) assigned, and the subnet this interface is connected to has a route table with a configured gateway, the VM will access the internet through the public IP address rather than the gateway. Currently, you cannot use reserved public IP addresses for gateways.


## Use cases {#examples}

* [{#T}](../tutorials/nat-instance/index.md)
* [{#T}](../tutorials/route-switcher.md)
* [{#T}](../tutorials/data-processing-nat-instance.md)
* [{#T}](../tutorials/storage-vpc-access.md)
* [{#T}](../tutorials/airflow-auto-tasks.md)