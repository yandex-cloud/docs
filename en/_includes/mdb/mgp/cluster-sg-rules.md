

Set up a cluster's security groups so that they allow any incoming and outgoing traffic over any protocol. To do this, [create rules](../../../vpc/operations/security-group-add-rule.md) for incoming and outgoing traffic:

* Port range: `{{ port-any }}`.
* Protocol: `Any`.
* Source: `CIDR`.
* CIDR blocks: `0.0.0.0/0`.

