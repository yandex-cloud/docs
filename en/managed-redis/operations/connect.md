# Connecting to a database in a {{ RD }} cluster

## Connection methods {#connection-methods}

You can connect to the {{ RD }} database host in two ways:

- Directly through port `6379`.
- Using [{{ RD }} Sentinel](https://redis.io/topics/sentinel) through port `26379`. This is a {{ RD }} host management system that provides monitoring, notification, automatic failover, and reporting of up-to-date host addresses to the clients.

Not every {{ RD }} client application supports connecting via Sentinel. In such cases, you can connect to the host  directly. Note that you will need to track the roles of all the hosts yourself. If there is no need for a direct connection, use Sentinel for more reliable cluster host management.

## Connecting to clusters {#connect}

{{ RD }} cluster hosts can't be assigned public IPs. You can only access hosts from within the [virtual network](../../vpc/concepts/network.md) where the host is located.

To connect to the host of a {{ RD }} cluster:

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) with a public IP in the same virtual network as the host.
1. Connect to the created VM [via SSH](../../compute/operations/vm-connect/ssh.md) and then, from this VM, connect to {{ RD }} using one of the [sample connection strings](#connection-string).

## Sample connection strings {#connection-string}

{% include [conn-strings-environment](../../_includes/mdb/mdb-conn-strings-env.md) %}

Examples of strings are provided for both connections using Sentinel and direct connections.

{% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

{% include [mrd-connection-strings](../../_includes/mdb/mrd-conn-strings.md) %}

If the connection to the cluster and the test query are successful, the `bar` string is output.

