# VPC Stitching

{% include [cic-only-warning](../../_includes/interconnect/cic-only-warning.md) %}

**VPC Stitching** is one of the `Cloud Router` mechanisms providing network connectivity between [cloud networks (VPCs)](../../vpc/concepts/network.md) that are located in folders of the same or different clouds within a single [cloud organization](../../organization/concepts/organization.md).

To configure topologies with the help of the `VPC Stitching` mechanism, stitching announcements should be used.

**Stitching announcements** are aggregating routes implementing the `VPC-Stitching` mechanism. They are used to create individual types of network topologies to configure [private connections](../../interconnect/concepts/priv-con.md). Regional in scope, they combine IP prefixes of subnets across all availability zones. Stitching announcements are calculated and added to the [private connection](../../interconnect/concepts/priv-con.md) configuration by the client. Stitching announcements are not automatically calculated or added to the private connection configuration on the {{ yandex-cloud }} side. You will find them displayed in the `ipv4_static_routes` field of the {{ interconnect-name }} API for [private connections](../../interconnect/concepts/priv-con.md).

`VPC Stitching` can be currently used in the following scenarios:
* [Network IP connectivity between two or more cloud networks without on-prem connections via Cloud Interconnect](../scenarios/vpc-st-with-two-vpc.md).
* [Network IP connectivity between two or more cloud networks, as well as IP connectivity from each cloud network to on-prem connections via Cloud Interconnect](../scenarios/vpc-st-with-two-vpc-and-onprem.md). 

