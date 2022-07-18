# Security groups

The feature is at the [Preview stage](../../overview/concepts/launch-stages.md).

Security groups let you manage VM access to resources and security groups in {{ yandex-cloud }} or resources on the internet. A security group is assigned to the network interface when creating or updating a VM and should contain rules for receiving and sending traffic. You can assign multiple security groups to each VM.



{% note warning %}

Security groups are not designed to protect against DDoS attacks. To filter out large volumes of unwanted traffic, use [DDoS protection](../ddos-protection/index.md).

{% endnote %}


{% include [sg-rules](../../_includes/vpc/sg-rules.md) %}

## Security group rules {#rules}

Security group rules define the protocols and IP addresses for receiving and sending traffic. If you assigned multiple security groups to the VM network interface, rules from all groups are taken into account. In this case, a VM may receive traffic that falls under at least one of the rules in the assigned groups.

Rules store session statuses. Security groups monitor the status of connections and map response traffic to an already open session to allow traffic receipt.

> For example, a rule allows a VM to create an outgoing session to port 80 of an IP address. Responses from port 80 to the request source port are automatically resolved.

### Types of rules {#rules-types}

There are two types of rules:

* For incoming traffic. Define address and port ranges or other security groups that VMs may receive traffic from.
* For outgoing traffic. Define address and port ranges or other security groups that VMs can send traffic to.

If a security group only contains a rule for outgoing traffic and no rules for incoming traffic, a VM can still receive the response traffic. If a security group only has rules for incoming traffic, the VM will only be able to respond to requests, but not initiate them.

If two VMs are in the same security group with no rules, they won't be able to exchange traffic. To enable VMs in the same group to transfer traffic between one another, you can:

* Use the `Self` rule for the entire group.
* Specify the addresses and ports of the required resources in the rules.

### Protocols {#protocols}

Security group rules let you specify which VM protocols can be used to transmit traffic. The following protocols are available:

* TCP.
* UDP.
* ICMP.
* All available protocols.

### IP addresses and address ranges {#cidrs}

In the rules, you can allow receiving and sending traffic to individual IPs or address ranges.

You can specify a particular IP address in the rules using CIDR with the `/32` mask.

To allow traffic to be sent to any addresses over any protocols, specify CIDR `0.0.0.0` with the `/0` mask and set `Any` in the protocol selection field.

Security groups don't block sending traffic to the addresses of services required for the VM and virtual network operation:

* The metadata server address: `169.254.169.254`.
* The address of the [DNS server](network.md#subnet): The second-in-order internal IP address (usually `x.x.x.2`) in each subnet.

To enable [health checks](../../network-load-balancer/concepts/health-check.md) for resources connected to a network load balancer, use one of the methods below:

* Recommended method: in the `predefined_target` field, enter `loadbalancer_healthchecks`.
* Manually allow traffic to be transferred between `198.18.235.0/24`, `198.18.248.0/24`, and target resources.

## Default security group {#default-security-group}

The default security group is automatically:
* Created in a new network.
* Assigned to VMs when connecting to the new network subnets if they don't have any security groups.

   In this case, the automatically assigned security group isn't displayed in API or CLI responses.

   {% note info %}

   You can't delete the default security group.

   {% endnote %}

### Default security group rules {#rules-default}

The default security group is created with the following rules:

{% list tabs %}

- Outgoing traffic

   All outgoing traffic is allowed.

- Incoming traffic

   Allowed:
   * All incoming traffic from members of the same security group.
   * SSH connections to port `22` (`TCP`) from any address (`0.0.0.0/0`).
   * RDP connections to port `3389` (`TCP`) from any address (`0.0.0.0/0`).
   * All incoming traffic over `ICMP` from any address (`0.0.0.0/0`).

{% endlist %}

{% note info %}

In networks created before the security group functionality was launched, traffic will be transmitted without any restrictions to maintain backward compatibility.

{% endnote %}