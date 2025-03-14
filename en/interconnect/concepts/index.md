# {{ interconnect-name }} overview

{{ interconnect-name }} is designed to set up IP network connectivity between customer on-premise infrastructure resources and {{ yandex-cloud }} resources.

Here is an example of how to set up connectivity:


![interconnect](../../_assets/interconnect/interconnect.svg)

In this example, the customer has the following resources:

* On-prem infrastructure with deployed customer resources, such as dedicated servers.
* Cloud infrastructure in {{ yandex-cloud }} with deployed cloud resources, such as VMs.

The task is to ensure the IP network connectivity between the customer on-premise infrastructure resources and {{ yandex-cloud }} resources.

Solving this task may require the following:

* Setting up a [trunk](./trunk.md).
* Creating a [private connection](./priv-con.md) within this [trunk](./trunk.md).
* Configuring a [point-to-point subnet](./priv-con.md#priv-address) and setting up [BGP peering](./priv-con.md#bgp-peering) for the [private connection](./priv-con.md). {{ interconnect-name }} will not work without BGP peering.
* [Cloud subnet prefix announcements](./priv-con.md#prc-announce) from the {{ yandex-cloud }} virtual network over BGP.
* Customer resource subnet prefix announcements from the customer infrastructure over BGP.

Once these steps are complete, your infrastructure resources and {{ yandex-cloud }} resources will feature the IP connectivity enabling them to exchange IP traffic between each other.

{% note warning "Tutorials" %}

For tutorials on how to enable and manage {{ interconnect-name }}, follow [this link](../tutorials/).

{% endnote %}
