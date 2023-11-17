# Networking in {{ mos-name }}


When creating a cluster, you can:

* Specify a network for the entire cluster.
* Specify subnets for each host in the cluster.
* Request public access to connect to the cluster host groups from outside {{ yandex-cloud }}.

You can create a cluster without specifying any subnets for the hosts if the availability zone selected for each host contains exactly one subnet of the cluster network.


## Host name and FQDN {#hostname}

{{ mos-short-name }} generates the name of each cluster host when creating it. This name will be the host's fully qualified domain name (FQDN). The host name and, consequently, FQDN cannot be changed.

{% include [see-fqdn](../../_includes/mdb/mos/fqdn-host.md) %}


You can use the FQDN to access the host within a single cloud network. For more information, see the [{{ vpc-full-name }} documentation](../../vpc/).

## Public access to a host {#public-access-to-a-host}

Any cluster host can be accessible from outside {{ yandex-cloud }} if you requested public access when creating its host group. To connect to such a host, use its FQDN.

You cannot request public access after creating a host group.

When deleting a host group with public FQDNs, the assigned IP addresses are revoked.

## Security groups {#security-groups}

Security groups follow the _All traffic that is not allowed is prohibited_ principle. To connect to a cluster, security groups must include rules allowing traffic from certain ports, IP addresses, or other security groups.

For example, let's assume public access is enabled for a host group of the `Dashboards` type. If there is no security group rule that allows connecting to it from the internet on port `{{ port-https }}`, you will not be able to connect to the web interface. You will not be able to access an `{{ OS }}` host group either, unless it has a security group rule that explicitly allows incoming traffic on port `{{ port-mos }}`.

{% note tip %}

If you connect to a cluster from within its cloud network, [configure](../operations/connect.md#security-groups) security groups both for the cluster and the connecting host.

{% endnote %}

{% include [sg-rules-concept](../../_includes/mdb/sg-rules-concept.md) %}

