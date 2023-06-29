# {{ interconnect-name }} overview

The {{ interconnect-name }} service is designed to set up IP network connectivity between the resources in the client infrastructure and cloud resources in {{ yandex-cloud }}.

Example of connectivity setup:


![interconnect](../../_assets/interconnect/interconnect.svg)



In this example, the client has the following resources:

* On-premise infrastructure where the client resources, such as dedicated servers, are deployed.
* Cloud infrastructure in {{ yandex-cloud }} where cloud resources, such as VMs, are deployed.

Let's assume the goal is to ensure IP network connectivity between resources in the client's own infrastructure and cloud resources in {{ yandex-cloud }}.

What you may need for this task:

* Setting up a [trunk](./trunk.md).
* The [trunk](./trunk.md) is created with a [private connection](./priv-con.md).
* A [point-to-point subnet](./priv-con.md#priv-address) and [BGP connectivity](./priv-con.md#bgp-peering) are configured in each [private connection](./priv-con.md). The {{ interconnect-name }} service is not provided if BGP connectivity is not set up.
* [Cloud subnet prefixes are announced](./priv-con.md#prc-announce) on the {{ yandex-cloud }} virtual network side using BGP.
* The prefixes of subnets with client resources are announced on the client infrastructure side using BGP.

After the above steps are complete, IP connectivity should be available between your infrastructure resources and cloud resources in {{ yandex-cloud }} so that they can exchange IP traffic between each other.

{% note warning "Guides" %}

For detailed guides on how to enable and manage {{ interconnect-name }}, see the [Guides](../operations/) section.

{% endnote %}
