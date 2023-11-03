{% note warning %}

Groups of {{ k8s }} nodes require internet access for downloading images and components.

Internet access can be provided in the following ways:
* By assigning a [public IP address](../../vpc/concepts/address.md#public-addresses) to each node in the group.
* By [configuring a VM as a NAT instance](../../tutorials/routing/nat-instance.md).
* By [setting up a NAT gateway](../../vpc/operations/create-nat-gateway.md).

{% endnote %}