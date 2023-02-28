# Network in {{ data-transfer-full-name }}

{% if audience != "internal" %}

When creating endpoints of certain types, you can select a [cloud subnet](../../vpc/concepts/network.md). The transfer will use the above subnet to access source or target endpoint hosts.

You can specify the subnet manually in the endpoint settings (for **On-Premise** endpoints) or have one selected automatically for [MDB endpoints](#managed-cluster-subnets). This subnet is referred to as the __selected subnet__. The network that the selected subnet belongs to is referred to as the __selected network__.

If hosts are referenced by domain names in the endpoint settings, the {% if lang == "ru" and audience != "internal" %}[DNS servers](../../glossary/dns.md#dns-server){% else %}DNS servers{% endif %} specified in the selected subnet DHCP settings will be used to resolve them into IP addresses. For more information, see [IP addresses and domain names in endpoint settings](#ip-addresses-and-domain-names).

{% note info %}

The subnets selected for both the endpoints of a single transfer must belong to the same availability zone.

{% endnote %}

## MDB cluster subnets {#managed-cluster-subnets}

You can only specify a subnet for endpoints with the **On-Premise** connection type. If the endpoint settings contain an MDB cluster ID rather than a host, one of the subnets that the database cluster is connected to will be selected for endpoint access.

{% note info %}

In the event that both the transfer endpoints are MDB clusters and the source and target subnets' availability zones do not intersect, you will not be able to initiate a transfer. There are two workarounds for this situation:

* Adding a host to one of the clusters and selecting an appropriate availability zone.
* Configuring one of the endpoints as **On-Premise** and connecting it to any subnet with an availability zone matching that of the other endpoint. If there is no suitable network, create a new one in a required zone and specify it in the On-Premise endpoint settings.

{% endnote %}

## Subnet IP address ranges {#subnet-address-ranges}

When performing transfers between the source and target hosts that are in different subnets within {{ yandex-cloud }}, their IP address ranges should not overlap. For example, an error occurs if the hosts use subnets with the following IP ranges:

* `network-1/subnet-a` with the IPv4 CIDR `10.130.0.0/24`.
* `network-2/subnet-b` with the IPv4 CIDR `10.130.0.0/24`.

{% note info %}

To launch a successful transfer in the selected endpoint subnet address range, there must be at least one free IP address:

{% endnote %}

## IP address availability and ownership {#ip-address-availability}

An IP address __belongs to a network__ if it belongs to any CIDR of any subnet on this network. For example, if there is a network called `my-network` with subnets `my-network-a` (CIDR `192.168.0.0/24`) and `my-network-b` (CIDR `192.168.1.0/24`), then `192.168.0.100` and `192.168.1.50` belong to `my-network` while `1.2.3.4` does not.

An IP address __is available via a subnet__ if it belongs to this subnet's network, or the network this subnet belongs to has properly configured routing for the IP address in question. `192.168.0.100` and `192.168.1.50` will be available via the `my-network-a` subnet (as well as via `my-network-b`). `1.2.3.4` will be available through these subnets in the following cases only:
* An egress [NAT gateway](../../vpc/concepts/gateways.md) is enabled in `my-network`; this will cause traffic to be routed to the internet.
* `my-network` has a static route configured to process the address in question (`1.2.3.4`). This will cause traffic to be directed to the next-hop address specified in the route.

## IP addresses and domain names in endpoint settings {#ip-addresses-and-domain-names}

If a host is specified as an IP address in the endpoint settings, the selected endpoint subnet will be used for access to a cluster even if the specified IP [does not belong](#ip-address-availability) to the network selected for the endpoint.

If an **On-Premise** endpoint with a host specified as a domain name or an MDB endpoint is being used, the host name will be resolved into an IP address using a DNS server specified in the DHCP settings for the selected subnet or a default DNS server (second address in the subnet range). For a transfer to be successful, the address that the host domain name resolves into must belong to the network selected for the endpoint while the DNS server address must be [available](#ip-address-availability) via the selected subnet.

## Security groups {#security-groups}

You can assign [security groups](../../vpc/concepts/security-groups.md) to the subnet selected for the endpoint. In the event that network access to source or target hosts is restricted by security groups, you can disable network connectivity between {{ data-transfer-full-name }} and your DBMS without adding permissive rules for wide IP ranges to your security groups, and allow access from specific groups granularly. You can grant access to your DBMS hosts using one of the methods below:

* Create a permissive rule called `self` in the security group that protects source or target hosts, and specify this security group in the endpoint settings.
* Create a new security group for the endpoint and create permissive rules between the endpoint and the DBMS security groups.

{% note info %}

Make sure to allow outgoing traffic to the port required by the security group specified in the endpoint.

{% endnote %}

## Transferring between a source on an external network and a target in {{ yandex-cloud }} {#source-external}

You can provide access to a source on an outside network using one of the following methods:

* By configuring a source to make it available from the internet.
{% if product == "yandex-cloud" %}* Using [{{ interconnect-full-name }}](../../interconnect/).{% endif %}
* Using an intermediate {% if lang == "ru" and audience != "internal" %}[VM](../../glossary/vm.md){% else %}VM{% endif %} configured to [route traffic to {{ vpc-name }}](../../vpc/concepts/static-routes.md).

If you need to migrate data between {{ yandex-cloud }} and a third-party cloud, allow incoming connections to the third-party cloud database from the internet from [IP addresses used by {{ data-transfer-name }}](https://stat.ripe.net/widget/announced-prefixes#w.resource%3DAS200350%26w.min_peers_seeing%3D0).

To launch transfers requiring internet access to run, you need to have the `data-transfer.transfers.createExternal` privilege.

{% else %}

By default, transfers are run on the Vanga YT cluster. Make sure the source and target are available from the `_YTVANGANETS_` or `_YTNETS_` macro.

## Transferring data between Yandex and external {{ yandex-cloud }} {#internal-to-external}

To transfer data from an internal cloud to an external one, the latter should have a special IPv6 network allocated to ensure connectivity with the Yandex internal infrastructure. For more information, see [IS policies](https://wiki.yandex-team.ru/security/policies/yandex-cloud-rules/#setevajasvjaznostibalanceirovka).

To migrate data to an external cloud such as {{ mch-name }}:

1. If this network wasn't created when creating a cloud, request it using the [form](https://st.yandex-team.ru/createTicket?queue=CLOUD&_form=54816). In the form, select the **PROD** bench , specify the `_CLOUD_YANDEX_CLIENTS_` parent macro, and choose "allocate project_id".
2. Use [Puncher](https://puncher.yandex-team.ru/) to request access to the allocated project_id from the `_YTVANGANETS_` or `_YTNETS_` macro. For {{ mch-name }}, specify TCP ports {{ port-mch-http }} and {{ port-mch-cli }}. For information about ports for other databases, see the [MDB documentation](../../mdb/access.md#network-access).
3. In the cloud, create a cluster for {{ mch-name }} or another DB and place the cluster's hosts in the network from step 1.
4. Create endpoints and a transfer **in the [internal cloud](https://cloud.yandex-team.ru)**. Make sure to set up the target endpoint as **On-Premise** by explicitly listing DB hosts.
5. Activate the transfer.

{% note warning %}

Using the allocated IPv6 network is preferable for transfers in {{ yandex-cloud }}. Don't use the internet for that.

{% endnote %}

## Transferring data between Yandex and online data stores {#internal-to-internet}

To export data to the internet:

1. Get approval from the Information Security department. It's prohibited to export data from Yandex if this is not explicitly authorized by IS employees.
2. Create endpoints and a transfer **in the [internal cloud](https://cloud.yandex-team.ru)**. Make sure to set up the endpoint on the internet as **On-Premise** by explicitly listing DB hosts. Enable SSL in the connection settings if needed.
3. Create a ticket for on-duty staff in the [DTSUPPORT](https://st.yandex-team.ru/DTSUPPORT) queue and specify the transfer `ID` from the previous step. In the ticket, be sure to provide information about the transfer's approval by the IS department (such as a comment or the number of a linked ticket).
4. Once an on-duty staff member enables internet access for the transfer (so far, this is not anyhow displayed in the UI or anywhere else), activate the transfer and check that everything is OK.

Internet access permission is granted individually for each transfer, so try to arrange your data workflow so that you can reuse the transfer on a regular basis rather than create a new transfer every time you need one.

{% endif %}
