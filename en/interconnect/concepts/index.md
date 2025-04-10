# {{ interconnect-name }} overview

{{ interconnect-name }} is designed to set up IP network connectivity between customer on-premise infrastructure resources and {{ yandex-cloud }} resources.

Example of setting up IP network connectivity as part of {{ interconnect-name }}:

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

## Scopes of responsibility {#scopes}

{{ yandex-cloud }} provides the {{ interconnect-name }} service in cooperation with other parties, each with its own area of responsibility:
* [Points of presence](./pops.md):
  * Provide customers with the services of setting up and switching `cross connections` (optical fiber pairs) between the customer (telecom operator) equipment and {{ yandex-cloud }} equipment.
  * Provide customers with the services of placing the customer equipment at the point of presence.
* `Telecom operators`:
  * Provide customers with the services of setting up communication channels between the customer infrastructure and {{ yandex-cloud }} equipment at the points of presence.
  * Provide customers with IP services when connected to {{ interconnect-name }}.

{% note info %}

Services provided by the points of presence or telecom operators are not included in the [cost of {{ interconnect-name }}](../pricing.md).

{% endnote %}

{{ yandex-cloud }} **does not provide** any [point of presence](./pops.md) or `telecom operator` services to customers, including the following:
* Setting up and switching cross connections at the points of presence.
* Organizing communication channels at the points of presence.
* Placement of equipment at the points of presence.

