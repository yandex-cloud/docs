{% note warning %}

{{ k8s }} node groups require internet access to download images and components.

Internet access can be provided through:
* By assigning a [public IP address](../../vpc/concepts/address.md#public-addresses) to each node in the group.
* [Configuring a VM as a NAT instance](../../tutorials/routing/nat-instance/index.md).
* [Setting up a NAT gateway](../../vpc/operations/create-nat-gateway.md).

{% endnote %}