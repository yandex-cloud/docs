# Network in {{ data-transfer-full-name }}

{% if audience != "internal" %}
When creating an endpoint, you can select a [cloud network](../../vpc/concepts/network.md) and [security groups](../../vpc/concepts/security-groups.md) for network traffic. If the VMs and DB clusters used in endpoints are hosted in the selected cloud network, the rules of the selected security groups will apply to them during a transfer. This lets you perform transfers without changing the rules for the existing security groups of your VMs or DB clusters.

If you need to migrate data between {{ yandex-cloud }} and a third-party cloud, add the rules allowing incoming connections to the endpoint cluster from the internet from [IP addresses used by {{ data-transfer-name }}](https://stat.ripe.net/widget/announced-prefixes#w.resource%3DAS200350%26w.min_peers_seeing%3D0) to the endpoint cluster security group.

## Subnet IP address ranges {#subnet-address-ranges}

When performing transfers between the source and target hosts that are in different subnets within {{ yandex-cloud }}, their IP address ranges should not overlap. For example, an error occurs if the hosts use subnets with the following IP ranges:

* `network-1/subnet-a` with the IPv4 CIDR `10.130.0.0/24`.
* `network-2/subnet-b` with the IPv4 CIDR `10.130.0.0/24`.

## Transfering between a source on an external network and a target in {{ yandex-cloud }} {#source-external}

You can provide access to a source on an outside network using one of the following methods:

* [By configuring a source to make it available from the internet](../operations/prepare.md#source-mg).
* Using [{{ interconnect-full-name }}](../../interconnect/index.yaml).
* Using an intermediate VM configured to [route traffic to {{ vpc-name }}](../../vpc/concepts/static-routes.md).

{% else %}
By default, transfers are run on the Vanga YT cluster. Make sure the source and target are available from the `_YTVANGANETS_` or `_YTNETS_` macro.

## Transferring data between Yandex and external {{ yandex-cloud }}

To transfer data from an internal cloud to an external one, the latter should have a special IPv6 network allocated to ensure connectivity with the Yandex internal infrastructure. For more information, see [IS policies](https://wiki.yandex-team.ru/security/policies/yandex-cloud-rules/#setevajasvjaznostibalanceirovka).

To migrate data to an external cloud such as Managed Service for ClickHouse:

1. If this network wasn't created when creating a cloud, request it using the [form](https://st.yandex-team.ru/createTicket?queue=CLOUD&_form=54816). In the form, select the **PROD** bench , specify the `_CLOUD_YANDEX_CLIENTS_` parent macro, and choose "allocate project_id".
2. Use [Puncher](https://puncher.yandex-team.ru/) to request access to the allocated project_id from the `_YTVANGANETS_` or `_YTNETS_` macro. For Yandex Managed Service for ClickHouse, specify TCP ports 8443 and 9440. For information about ports for other databases, see the respective DB documentation.
3. In the cloud, create a cluster for Managed Service for ClickHouse or another DB and place the cluster's hosts in the network from step 1.
4. Create endpoints and a transfer **in the [internal cloud](https://cloud.yandex-team.ru)**. Make sure to set up the target endpoint as **On-Premise** by explicitly listing DB hosts.
5. Activate the transfer.

{% note warning %}

Using the allocated IPv6 network is preferable for transfers in {{ yandex-cloud }}. Don't use the internet for that.

{% endnote %}

## Transferring data between Yandex and online data stores

To export data to the internet:

1. Get approval from the Information Security department. It's prohibited to export data from Yandex if this is not explicitly authorized by IS employees.
2. Create endpoints and a transfer **in the [internal cloud](https://cloud.yandex-team.ru)**. Make sure to set up the endpoint on the internet as **On-Premise** by explicitly listing DB hosts. Enable SSL in the connection settings if needed.
3. Create a ticket for on-duty staff in the [DTSUPPORT](https://st.yandex-team.ru/DTSUPPORT) queue and specify the transfer `ID` from the previous step. In the ticket, be sure to provide information about the transfer's approval by the IS department (such as a comment or the number of a linked ticket).
4. Once an on-duty staff member enables internet access for the transfer (so far, this is not anyhow displayed in the UI or anywhere else), activate the transfer and check that everything is OK.

Internet access permission is granted individually for each transfer, so try to arrange your data workflow so that you can reuse the transfer on a regular basis rather than create a new transfer every time you need one.
{% endif %}