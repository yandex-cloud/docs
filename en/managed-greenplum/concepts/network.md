# Network and DB clusters in {{ mgp-name }}


 When creating a cluster, you can:

* Set the network and subnet for the cluster.
* Request public IP addresses to access the cluster from outside {{ yandex-cloud }}.


You can only connect to {{ mgp-short-name }} clusters via master hosts. You cannot connect to segment hosts directly.

Segment hosts are combined into a virtual network, where each of them is a cloud resource. Data is replicated and rebalanced across the segments within this network.


By default, master hosts are available for connection from VMs located in the same cloud network. For more information about network functionality, see the [{{ vpc-full-name }} documentation](../../vpc/concepts/index.md).


## Hostname and FQDN {#hostname}

When you create a cluster, {{ mgp-short-name }} automatically assigns its hosts both short and full (FQDN) names. These cannot be changed.


You can use FQDN to access master hosts from both inside and outside {{ yandex-cloud }}.

## Public access to clusters {#public-access-to-a-host}

To get public IPs for master host access from outside {{ yandex-cloud }}, enable the **Public access** option when creating a cluster. To connect to a cluster, use the FQDNs of its master hosts.

After creating a cluster, you cannot request or disable public addresses.

## Security groups {#security-groups}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}


{% note tip %}

When connecting to a cluster from the same cloud network, [configure security groups](../operations/connect.md#configuring-security-groups) for the cluster and the connecting host.

{% endnote %}

Specifics of working with security groups:

* To connect to a cluster, you [need rules](../operations/connect.md#configuring-security-groups) that allow traffic between the cluster and the connecting host, even if they are assigned to the same security group.

* Security group settings affect the ability to connect to the cluster, its performance, and network connectivity between its hosts.

For more information, see the [{{ vpc-name }} documentation](../../vpc/concepts/security-groups.md).


{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
