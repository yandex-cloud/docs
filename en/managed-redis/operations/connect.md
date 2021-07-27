---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Connecting to a database in a {{ RD }} cluster

## Connection methods {#connection-methods}

You can connect to the {{ RD }} database host in two ways:

- Directly through port `6379`.
- Using [{{ RD }} Sentinel](https://redis.io/topics/sentinel) through port `26379`. This is a {{ RD }} host management system that provides monitoring, notification, automatic failover, and reporting of up-to-date host addresses to the clients.

Not every {{ RD }} client application supports connecting via Sentinel. In such cases, you can connect to the host directly. Note that you will need to track the roles of all the hosts yourself. If there is no need for a direct connection, use Sentinel for more reliable cluster host management.

## Connecting to clusters {#connect}

{{ RD }} cluster hosts can't be assigned public IPs. You can only access hosts from within the [virtual network](../../vpc/concepts/network.md) where the host is located.

To connect to the host of a {{ RD }} cluster:

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) with a public IP in the same virtual network as the host.
1. Connect to the created VM [via SSH](../../compute/operations/vm-connect/ssh.md) and then, from this VM, connect to {{ RD }} using one of the [sample connection strings](#connection-string).

## Configuring security groups {#configuring-security-groups}

{% include [sg-rules](../../_includes/mdb/sg-rules-connect.md) %}

Settings of rules depend on the connection method you select:

1. [Configure all the security groups](../../vpc/operations/security-group-update.md#add-rule) of the cluster to allow incoming traffic from the VM's security group on port `6379` for direct connections or port `26379` for connections via Sentinel. To do this, create the following rule for incoming traffic in these groups:
    - Protocol: `TCP`.
    - Port range: `6379` (`26379` for Sentinel).
    - Source type: `Security group`.
    - Source: Security group assigned to the VM. If it is the same as the configured group, specify **Current**.

1. [Set up the security group](../../vpc/operations/security-group-update.md#add-rule) assigned to the VM to allow connections to the VM and traffic between the VM and the cluster hosts.

    Example of rules for a VM:

    - For incoming traffic:
        - Protocol: `TCP`.
        - Port range: `22`.
        - Source type: `CIDR`.
        - Source: `0.0.0.0/0`.

        This rule lets you connect to the VM over SSH.

    - For outgoing traffic:
        - Protocol: `Any`.
        - Port range: `0-65535`.
        - Destination type: `CIDR`.
        - Destination: `0.0.0.0/0`.

        This rule allows any outgoing traffic: this lets you both connect to the cluster and install certificates and utilities you might need to connect to the cluster.

{% note info %}

You can set more detailed rules for security groups, e.g., to allow traffic in only specific subnets.

Security groups must be configured correctly for all subnets that will include cluster hosts. If security group settings are incomplete or incorrect, you may lose access to the cluster if the master is switched [manually](failover.md) or [automatically](../concepts/replication.md).

{% endnote %}

For more information about security groups, see [{#T}](../concepts/network.md#security-groups).

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

Examples of strings are provided for both connections using Sentinel and direct connections.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mrd-connection-strings](../../_includes/mdb/mrd-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the `bar` string is output.

