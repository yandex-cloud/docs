# {{ interconnect-name }} overview

{{ interconnect-name }} is designed to set up IP network connectivity between the resources in the client infrastructure and cloud resources in {{ yandex-cloud }}.

Here is an example of connectivity setup:


![interconnect](../../_assets/interconnect/interconnect.svg)



In this example, the client has the following resources:

* On-premise infrastructure where the client resources, such as dedicated servers, are deployed.
* Cloud infrastructure in {{ yandex-cloud }} where cloud resources, such as VMs, are deployed.

The goal is to ensure the IP network connectivity between resources in the client's own infrastructure and cloud resources in {{ yandex-cloud }}.

To solve this task, you will need to do the following:

* Set up a [trunk](./trunk.md).
* Create a [private connection](./priv-con.md) within this [trunk](./trunk.md).
* Configure a [point-to-point subnet](./priv-con.md#priv-address) and [BGP connectivity](./priv-con.md#bgp-peering) in the [private connection](./priv-con.md). {{ interconnect-name }} will not work without BGP connectivity.
* [Announce cloud subnet prefixes](./priv-con.md#prc-announce) on the {{ yandex-cloud }} virtual network side using BGP.
* Announce the prefixes of subnets with client resources on the client infrastructure side using BGP.

Once you are done, you will have the IP connectivity available between your infrastructure resources and cloud resources in {{ yandex-cloud }} so that they can exchange IP traffic between each other.

{% note warning "Tutorials" %}

For detailed guides on how to enable and manage {{ interconnect-name }}, see the [tutorials](../tutorials/) section.

{% endnote %}
