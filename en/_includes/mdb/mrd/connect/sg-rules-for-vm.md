
To connect to a cluster from a VM in {{ yandex-cloud }}, [in its security groups, create](../../../../vpc/operations/security-group-update.md#add-rule) rules, enabling:

* VM connections from the internet.
* Traffic between the VM and cluster hosts.


Example of rules for a VM:

* For incoming traffic:
   * Port range: `22`.
   * Protocol: `TCP`.
   * Source: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

   This rule lets you connect to the VM over SSH.

* For outgoing traffic:
   * Port range: `{{ port-any }}`.
   * Protocol: `Any`.
   * Source type: `CIDR`.
   * CIDR blocks: `0.0.0.0/0`.

   This rule allows all outgoing traffic, which lets you both connect to the cluster and install the certificates and utilities that the VMs need to connect to the cluster.
