
Set up a cluster's security groups so that they allow any incoming and outgoing traffic over any protocol. To do this, [create rules](../../../vpc/operations/security-group-update.md#add-rule) for incoming and outgoing traffic:

* Protocol: `Any` (`Any`).
* Port range: `0-65535`.
* Source type: `CIDR`.
* Source: `0.0.0.0/0`.

