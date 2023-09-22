---
title: "Security groups in {{ vpc-full-name }}"
description: "Security groups allow you to manage VM access to resources and security groups in {{ yandex-cloud }} or resources on the internet."
---

# Security groups

Security groups allow you to manage [VM](../../compute/concepts/vm.md) access to {{ yandex-cloud }} resources and security groups, or resources on the internet. A security group is assigned to the network interface when creating or updating a VM and should contain rules for receiving and sending traffic. You can assign multiple security groups to each VM.

Security groups:
* Are not designed to protect against DDoS attacks. To filter out large volumes of unsolicited traffic, use [{{ ddos-protection-full-name }}](../ddos-protection/index.md).
* Operate based on the "what is not allowed is forbidden" principle. If you assign a security group without rules to the network interface of a VM, the VM will not be able to send or receive traffic.
* Automatically terminate TCP connections in the `idle` status in 180 seconds. We do not recommend using session timeouts in applications for a longer period of time. See more about limits [here](limits.md#vpc-limits).

You can learn how to create a security group [here](../operations/security-group-create.md).

## Security group rules {#rules}

Security group rules define the protocols and [IP addresses](address.md) for receiving and sending traffic. If you assigned multiple security groups to the VM network interface, rules from all groups are taken into account. In this case, a VM may receive traffic that falls under at least one of the rules in the assigned groups.

Rules store session statuses. Security groups monitor the status of connections and map response traffic to an already open session to allow receiving traffic.

> For example, you can configure a rule that allows a VM to create an outgoing session to port 80 of an IP address. This will automatically allow responses from port 80 to the request source port.

You can learn how to create a rule [here](../operations/security-group-add-rule.md).

### Types of rules {#rules-types}

There are two types of rules:
* For incoming traffic: define IP address and port ranges or other security groups the VMs can receive traffic from.
* For outgoing traffic: define IP address and port ranges or other security groups the VMs can send traffic to.

If a security group only contains a rule for outgoing traffic and no rules for incoming traffic, a VM can still receive the response traffic. If a security group only has rules for incoming traffic, the VM will only be able to respond to requests, but not initiate them.

If two VMs are in the same security group with no rules, they will not be able to exchange traffic. To enable VMs in the same group to transfer traffic between one another, you can:
* Use the `Self` rule for the entire group.
* In the rules, specify the IP addresses and ports of the required resources.

### Protocols {#protocols}

Security group rules allow you to specify which VM protocols can be used to transmit traffic. You can use the following protocols:
* TCP
* UDP
* ICMP
* ESP
* AH
* All available protocols

### IP addresses and address ranges {#cidrs}

In the rules, you can allow receiving and sending traffic to individual IPs or address ranges.

You can specify a particular IP address in the rules using CIDR with the `/32` mask.

To allow traffic to be sent to any IP addresses over any protocols, specify CIDR `0.0.0.0` with the `/0` mask and set `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` in the protocol selection field.

Security groups do not block the sending of traffic to IP addresses of services required for the operation of the VM and [virtual network](network.md#network):
* Metadata server address: `169.254.169.254`.
* [DNS server](network.md#subnet) address: Second [internal IP address](address.md#internal-addresses) (usually, `x.x.x.2`) in each subnet.

To enable [health checks](../../network-load-balancer/concepts/health-check.md) for resources connected to a [network load balancer](../../network-load-balancer/), use one of the methods below:
* Recommended method: in the `predefined_target` field, enter `loadbalancer_healthchecks`.
* Manually allow traffic to be transferred between the `198.18.235.0/24` and `198.18.248.0/24` IP address ranges and target resources.

### Exchanging traffic with other security groups {#groups}

The rules for selecting a security group as a source/destination only apply to packets that have IP addresses from [private ranges](network.md#subnet) specified as the source/destination and assigned to the interfaces from the selected security group.

Packets redirected to other network IPs through static routes will not match the rules that allow traffic. In this case, create rules explicitly specifying CIDR for the source or destination.

## Default security group {#default-security-group}

The default security group is automatically:
* Created in a new network.
* Assigned to VMs when connecting to the new network subnets if they do not have any security groups.

   In this case, the automatically assigned security group is not displayed in API or CLI responses.

   {% note warning %}

   You cannot delete the default security group.

   {% endnote %}

### Default security group rules {#rules-default}

The default security group is created with the following rules:

{% list tabs %}

- Outgoing traffic

   All outgoing traffic is allowed.

- Incoming traffic

   Allowed:
   * All incoming traffic from members of the same security group.
   * SSH connections to port `22` (`TCP`) from any IPs (`0.0.0.0/0`).
   * RDP connections to port `3389` (`TCP`) from any IPs (`0.0.0.0/0`).
   * All incoming traffic over `ICMP` from any IPs (`0.0.0.0/0`).

{% endlist %}

{% note info %}

In the networks created before the security group feature was released, the traffic will be transmitted without any restrictions to maintain backward compatibility.

{% endnote %}
