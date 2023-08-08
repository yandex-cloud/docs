# Network in {{ mes-name }}

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}


 When creating a cluster, you can:

* Specify a network for the entire cluster.
* Specify subnets for each host in the cluster.
* Request a public IP address to access cluster hosts with the [_Data node_ role](./index.md) from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts, if the availability zone selected for each host contains exactly one subnet of the cluster network.


## Hostname and FQDN {#hostname}

{{ mes-short-name }} generates a name for each cluster host when it is being created. This name will be the host's fully qualified domain name (FQDN). The host name and, consequently, the FQDN cannot be changed.


You can use the FQDN to access the host within a single cloud network. For more information, see the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating the host. To connect to such a host, use its FQDN.

You can't request public access after creating a host.

When deleting a host with a public FQDN, the assigned IP address is revoked.

## Security groups {#security-groups}

{% note info %}

{% include [security-groups-note](../../_includes/vpc/security-groups-note-services.md) %}

{% endnote %}

Security groups follow the _All traffic that is not allowed is prohibited_ principle. To connect to a cluster, security groups must include rules allowing traffic from certain ports, IP addresses, or other security groups.

For example, let's assume a host with the _Data node_ role is assigned a public IP address. If there is no security group rule that allows connecting to it from the internet on port `443`, you will not be able to connect to the Kibana web interface. Furthermore, you will not be able to access a host either, unless it has a security group rule configured that explicitly allows incoming traffic on port `9200`.

{% note tip %}

If you connect to a cluster from within its cloud network, [configure](../operations/cluster-connect.md#configuring-security-groups) security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

