
[Set up the security group](../../../../vpc/operations/security-group-update.md#add-rule) assigned to the VM to allow connections to the VM and traffic between the VM and the cluster hosts.


Example of rules for a VM:

* For incoming traffic:
    * Protocol: `TCP`.
    * Port range: `22`.
    * Source type: `CIDR`.
    * Source: `0.0.0.0/0`.

    This rule lets you connect to the VM over SSH.

* For outgoing traffic:
    * Protocol: `Any`.
    * Port range: `0-65535`.
    * Destination type: `CIDR`.
    * Destination: `0.0.0.0/0`.

    This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.
