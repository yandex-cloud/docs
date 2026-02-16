{% note warning %}

{{ k8s }} node groups require internet access to download images and components.

You can provide internet access in the following ways:
* By assigning a [public IP address](../../vpc/concepts/address.md#public-addresses) to each node in the group.
* [By configuring a VM as a NAT instance](../../tutorials/routing/nat-instance/index.md).
* [By setting up a NAT gateway](../../vpc/operations/create-nat-gateway.md).

{% endnote %}