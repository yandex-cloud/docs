# Routing Instance

The `Routing Instance` (RI) object is a core resource in the [{{ cr-name }}](./index.md) resource model. It is designed to create network topologies enabling network connectivity between cloud resources in different [networks](../../vpc/concepts/network.md).

## General rules and recommendations {#cr-general}

When using [{{ cr-name }}](./index.md) and [{{ interconnect-name }}](../../interconnect/concepts/index.md), we strongly recommend to follow these rules and guidelines:

1. All network segments (both cloud and on-prem sides) connected via `Routing Instance (RI)` must use non-overlapping, coordinated IP addressing. [Subnet](../../vpc/concepts/network.md#subnet) IP prefixes you add to an RI must be coordinated between themselves. You cannot add two identical IP prefixes to a single RI. `On-Prem` IP addressing must be aligned with IP addressing in the virtual cloud networks. IP address overlapping will cause IP connectivity problems. **Plan IP addressing carefully**.

1. Network communication across [virtual networks](../../vpc/concepts/network.md) is strictly confined to a single cloud [organization](../../organization/concepts/organization.md). All {{ cr-name }} and {{ interconnect-name }} resources, as well as the virtual cloud networks that are going to be integrated into a network topology using an `RI`, must reside in [cloud folders](../../resource-manager/concepts/resources-hierarchy.md#folder) within the same cloud organization. For network connectivity between virtual cloud networks belonging to different cloud organizations, consider migrating clouds from several organizations into a single one.

    If such migration is not feasible, you have to obtain formal written consents (on paper) from owners of all such cloud organizations for cross-organization networking. For detailed information about the verification procedure, contact {{ yandex-cloud }} [support](../../support/overview.md).

1. No direct exchange of routing info between any [private connections](../../interconnect/concepts/priv-con.md) (PRCs) within an `RI` is allowed.

1. The IP prefixes announced by the customer’s network hardware also get into the `RI` and from there to the virtual networks connected to that `RI`. Currently, you cannot view these IP prefixes at the `RI` level. We recommend getting this information from the customer's network hardware. In some cases, if routing issues arise, you may want to contact [support]({{ link-console-support }}) for this information.

1. You can only add a [VPC network ID](../../vpc/operations/network-get-info.md), `vpc_network_id`, to one `Routing Instance` at a time. An attempt to add the same ID to another `Routing Instance` will fail.

1. You can only add a [private connection ID](../../interconnect/operations/priv-con-get-info.md), `cic_private_connection_id`, to one `Routing Instance` at a time. An attempt to add the same ID to another `Routing Instance` will fail.


## Tips for configuring private connections {#prc} 

1. Always set up two {{ interconnect-name }} communication circuits through two [points of presence](../../interconnect/concepts/pops.md). This will keep your services up and running if one of the circuits fails.

1. To simplify the setup of fault-tolerant BGP routing, consider using the same [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) for multiple customer edge routers connecting to {{ interconnect-name }}. You can use different **BGP ASNs**, e.g., when setting up connections via telecom providers. Keep in mind that {{ yandex-cloud }} is not responsible for configuring the customer and telecom provider network hardware.

1. If the customer's two {{ interconnect-name }} communication circuits connect to different routers, ensure **iBGP** connectivity is configured between these customer routers. Without such connectivity, if one of the communication circuits fails on one of the routers, the remaining one will learn nothing about the failure and the dead circuit's traffic will not be automatically rerouted to the live circuit over BGP.

1. Use prefixes of different lengths for BGP announcements on customer edge routers if you need to distribute outgoing traffic from cloud networks across multiple {{ interconnect-name }} communication circuits:
    * Short prefixes, such as `/8`, have the lowest route priority.
    * Long prefixes, such as `/32`, have the highest route priority.

    For more information on traffic distribution between multiple communication circuits, see [use cases](../scenarios/index.md).

1. When selecting a communication circuit for outgoing traffic from the customer infrastructure to cloud networks, consider using the `Local Preference` BGP attribute on the customer edge router. For more information on traffic distribution between multiple communication circuits, see [use cases](../scenarios/index.md).


## Networking limitations {#gaps}

1. You can use {{ interconnect-name }} along with a [NAT gateway](../../vpc/operations/create-nat-gateway.md) if customer edge routers do not announce the `0.0.0.0/0` default route over BGP to {{ yandex-cloud }}. If customer edge routers do announce the `0.0.0.0/0` default route over BGP to {{ yandex-cloud }}, you cannot use a [NAT gateway](../../vpc/operations/create-nat-gateway.md).

1. Currently, {{ yandex-cloud }} does not support routing of outgoing traffic from cloud subnets to the customer infrastructure using [BGP community](https://linkmeup.gitbook.io/sdsm/8.1.-ibgp/3.-atributy-bgp/4.-community/0.-teoriya) attributes.

{% note alert %}

You cannot use matching prefixes in {{ vpc-short-name }} route tables and customer edge router announcements at the same time.

{% endnote %}


## Working with security groups {#cic-sg}

[Security groups](../../vpc/concepts/security-groups.md) are used to protect {{ yandex-cloud }} resources and cannot be used for filtering traffic outside {{ yandex-cloud }}.

Security group rules should be set up for the prefixes announced by customer edge routers to {{ yandex-cloud }}. For example, to allow access from the customer infrastructure to a web application (port 443) deployed in {{ yandex-cloud }}, set up a security group as follows:
```json
ingress {
      protocol       = "TCP"
      port           = 443
      description    = "Allow ingress traffic from Interconnect to Web server"
      v4_cidr_blocks = ["172.16.1.5/32"]
    }
egress {
      protocol       = "ANY"
      description    = "We allow any egress traffic"
      v4_cidr_blocks = ["10.0.0.0/8"]
    }
```

The `Egress` security group rule allows any cloud resources to access customer infrastructure resources on any port without any restriction.

If required, you can use more granular rules to only allow access to specific IP addresses or subnets and ports:

```json
ingress {
      protocol       = "TCP"
      port           = 443
      description    = "Allow ingress traffic from Interconnect to Web server"
      v4_cidr_blocks = ["172.16.1.5/32"]
    }
egress {
      protocol       = "TCP"
      port           = 3389
      description    = "Allow RDP traffic to server behind Interconnect"
      v4_cidr_blocks = ["10.10.10.10/32"]
    }
```

