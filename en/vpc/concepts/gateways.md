---
title: "Gateways in {{ vpc-full-name }}"
description: "In this tutorial, you will learn about gateways used in {{ vpc-full-name }}."
---

# Gateways

## NAT gateway {#nat-gateway}

A _NAT gateway_ allows you to grant internet access permissions to cloud resources without assigning public IP addresses to them. Instead, they will access the internet via the NAT gateway that will be assigned an IP address from a separate range of public IPs. A gateway is a regional resource one can find in all availability zones. You can [manage gateways](../operations/create-nat-gateway.md) using the management console, CLI, Terraform, or API.

To route traffic through a gateway, specify it as the next hop in a [route table](static-routes.md). Currently, you can only use a NAT gateway for a route with the `0.0.0.0/0` destination prefix; any traffic to route outside the network will pass through this gateway.

If a VM's network interface is assigned a [public IP](address.md#public-addresses) and the subnet that this interface is connected to has a route table with a set up gateway, the VM will access the internet from that public IP rather than through the gateway. Currently, you cannot use reserved public IP addresses for gateways.
