## {{ cr-name }} terminology

* **Hybrid Cloud** is a type of IT infrastructure that brings together the company’s internal IT resources on the one hand and public clouds resources on the other.

* **On-prem**: Customer site hosting their IT resources and network equipment for connection to {{ yandex-cloud }} via [{{ interconnect-name }}](../../interconnect/concepts/index.md).

* [Cloud network (VPC, Network)](../../vpc/concepts/network.md): {{ vpc-name }} resource. A cloud network is used to provide network connectivity in all [availability zones](../../overview/concepts/geo-scope.md) of a single region.

* [Subnet](../../vpc/concepts/network.md#subnet): {{ vpc-name }} resource. It belongs to a cloud network. Each subnet has an IP prefix (CIDR). Each subnet is always linked to a single [availability zone](../../overview/concepts/geo-scope.md). Cloud resources are connected to a subnet.

* [Routing instance (RI)](../../cloud-router/concepts/routing-instance.md) is a resource you can use to create a specific network topology which may include:
  * IP prefixes of [subnets](../../vpc/concepts/network.md#subnet) belonging to one or more [networks](../../vpc/concepts/network.md).
  * [Private connections](../../interconnect/concepts/priv-con.md). The number of private connections depends on the network topology type.

* `Routing` is the ability to direct network traffic using the [{{ cr-name }}](../../cloud-router/concepts/index.md) and [{{ interconnect-name }}](../../interconnect/concepts/index.md) resources.

* **VPC Stitching** is one of the `Cloud Router` mechanisms providing network connectivity between [cloud networks (VPCs)](../../vpc/concepts/network.md) that are located in folders of the same or different clouds within a single [cloud organization](../../organization/concepts/organization.md).

* **Stitching announcements** are aggregating routes implementing the `VPC-Stitching` mechanism. They are used to create individual types of network topologies to configure [private connections](../../interconnect/concepts/priv-con.md). Regional in scope, they combine IP prefixes of subnets across all availability zones. Stitching announcements are calculated and added to the [private connection](../../interconnect/concepts/priv-con.md) configuration by the client. Stitching announcements are not automatically calculated or added to the private connection configuration on the {{ yandex-cloud }} side. You will find them displayed in the `ipv4_static_routes` field of the {{ interconnect-name }} API for [private connections](../../interconnect/concepts/priv-con.md). 

