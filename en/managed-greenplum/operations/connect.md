# Connecting to a database in a Greenplum cluster

**TODO: describe available connection methods**

## Configuring security groups {#configure-security-groups}

1. [Configure all the security groups](../vpc/concepts/security-groups.md) in the cluster to allow incoming traffic from those security groups that contain the intermediate virtual machine, on the {{ port-mgp }} port. To do this, [create](../vpc/operations/security-group-update.md#add-rule) the following incoming traffic rules in these groups:
    * Port range: `{{ port-mgp }}`.
    * Protocol: `TCP`.
    * Destination: `Security group`.
    * Security group: the security group containing the intermediate virtual machine. If it is the same as the group being configured, specify `Self` (`Self`).

1. [Configure the intermediate VM's security groups](../vpc/concepts/security-groups.md) to accept connections and to allow traffic between the VM and the cluster master host.

    Example rules for an intermediate VM:

    * For incoming traffic:
        * Port range: `{{ port-ssh }}`.
        * Protocol: `TCP`.
        * Source type: `CIDR`.
        * CIDR blocks: `0.0.0.0/0`.

        This rule enables you to connect to an intermediate VM over SSH.

    * For outgoing traffic:
        * Port range: `{{ port-any }}`.
        * Protocol: `Any` (`Any`).
        * Source type: `CIDR`.
        * CIDR blocks: `0.0.0.0/0`.

        This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% include [note-sg-detail-rules](../../_includes/mdb/note-sg-detail-rules.md) %}

## Getting an SSL certificate {#get-ssl-cert}

TODO: describe SSL certificate configuration

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

**TODO: describe connection restrictions imposed by service**

**TODO: provide example connection strings. At the same time, create Level 3 headers for each programming language**

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

