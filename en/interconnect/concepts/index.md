# {{ interconnect-name }} overview

{{ interconnect-name }} is designed to set up IP network connectivity between customer on-premise infrastructure resources and {{ yandex-cloud }} resources.

Example of setting up IP network connectivity as part of {{ interconnect-name }}:



In this example, the customer has the following resources:

* On-prem infrastructure with deployed customer resources, such as dedicated servers.
* Cloud infrastructure in {{ yandex-cloud }} with deployed cloud resources, such as VMs.

The task is to ensure the IP network connectivity between the customer on-premise infrastructure resources and {{ yandex-cloud }} resources.

Such a task will require:



* Creating a [Routing Instance](../../cloud-router/concepts/routing-instance.md) in the cloud folder.
* Adding a `private connection` to `Routing Instance`.
* On the {{ yandex-cloud }} virtual network side, [adding a set of subnet IP prefixes](../../cloud-router/tutorials/ri-prefixes-upsert.md) from a specific virtual network in `Routing Instance`, which will be announced towards the client equipment via BGP.
* On the client infrastructure side, via BGP, a set of IP prefixes of subnets with client resources must be announced through the client side of the `private connection`.

Once these steps are complete, IP connectivity should be established between the client's infrastructure resources and cloud resources in {{ yandex-cloud }}, thus enabling IP traffic exchange between them.

{% note warning "Tutorials" %}

A general list of guides for actions in {{ cr-name }} and {{ interconnect-name }} is located in the [Operation overview](../operations/cic-cr-ops.md) section.

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

