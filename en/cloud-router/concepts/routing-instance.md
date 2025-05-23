# Routing instance

The [routing instance](./terms.md) (RI) object is a core resource in the [{{ cr-name }}](./index.md) resource model. It is designed to create network topologies enabling network connectivity between cloud resources in different [networks](../../vpc/concepts/network.md).

## General rules and recommendations {#cr-general}

The following rules and recommendations apply to [{{ cr-name }}](./index.md) and [{{ interconnect-name }}](../../interconnect/concepts/index.md):  

1. Consistent IP addressing. [Subnet](../../vpc/concepts/network.md#subnet) IP prefixes you add to an RI must be coordinated between themselves. You cannot add two identical IP prefixes to a single RI. IP addressing on `On-Prem` side must be coordinated with IP addressing in the virtual cloud networks. IP address overlapping will cause IP connectivity problems. Plan IP addressing carefully. 

1. Network communication across [virtual networks](../../vpc/concepts/network.md) is strictly confined to a single cloud [organization](../../organization/concepts/organization.md). All {{ cr-name }} and {{ interconnect-name }} resources, as well as the virtual cloud networks that are going to be integrated into a network topology using an `RI`, must reside in [cloud folders](../../resource-manager/concepts/resources-hierarchy.md#folder) within the same cloud organization. For network connectivity between virtual cloud networks belonging to different cloud organizations, consider migrating clouds from several organizations into a single one.

    If such migration is not feasible, you have to obtain formal written consents (on paper) from owners of all such cloud organizations for cross-organization networking. For detailed information about the verification procedure, contact {{ yandex-cloud }} [support](../../support/overview.md).

1. No direct exchange of routing info between any [private connections](../../interconnect/concepts/priv-con.md) (PRCs) within an `RI` is allowed.

1. The IP prefixes announced by the client’s network hardware also get into the `RI` and from there to the virtual networks connected to that `RI`. Currently, you cannot view these IP prefixes at the `RI` level. We recommend getting this information from the client's network hardware. In some cases, if routing issues arise, you may contact [support]({{ link-console-support }}) for this information. 

1. You can communicate with an RI via the [CLI](../../cli/quickstart.md) and API calls. For a list of available operations, see [step-by-step guides](../operations/index.md).

## RI network topologies {#ri-topologies}

Here is a list of network topologies you can create using an `RI`:

No. | Topology type | Short description |
:---: | --- | ---
1 | [OnPrem-1xRI-1xVPC-1xPRC](#ri-topology-1) | Non-reserved on-prem connection (private {{ interconnect-name }} connection) to one RI with one cloud network. 
2 | [OnPrem-1xRI-2xVPC-1xPRC](#ri-topology-2) | Non-reserved on-prem connection (private {{ interconnect-name }} connection) to one RI with two or more cloud networks without network connectivity to each other. 
3 | [OnPrem-1xRI-1xVPC-2xPRC](#ri-topology-3) | Reserved on-prem connection (two private {{ interconnect-name }} connections) to one RI with one cloud network.
4 | [On-Prem-1xRI-2xVPC-2xPRC](#ri-topology-4) | Reserved on-prem connection (two private {{ interconnect-name }} connections) to one RI with two or more cloud networks without network connectivity to each other.
5 | [OnPrem-2x(1xRI-1xVPC-1xPRC)](#ri-topology-5) | Two separate non-reserved on-prem connections (each private {{ interconnect-name }} connection to a separate RI) without network connectivity between cloud networks.
 
### OnPrem-1xRI-1xVPC-1xPRC [1] {#ri-topology-1}

Non-reserved on-prem connection via a single {{ interconnect-name }} [private connection](../../interconnect/concepts/priv-con.md) to a single `RI` with a single [VPC cloud network](../../vpc/concepts/network.md).

* `On-Prem` client with two local subnets: `subnet-c1` and `subnet-c2`.
* The `On-Prem` network hardware is connected to the {{ yandex-cloud }} network hardware via [{{ interconnect-name }}](../../interconnect/concepts/index.md).
* The `prc-m9` [private connection](../../interconnect/concepts/priv-con.md) established via the `M9` [point of presence](../../interconnect/concepts/pops.md) connects to `RI` in {{ yandex-cloud }}.
* The `Net-1` virtual network comprised of three subnets, `subnet-a1`, `subnet-b1`, and `subnet-d1`, connects to `RI` on the {{ yandex-cloud }} side.

This topology enables network connectivity between `On-Prem` subnets and `Net-1` VPC subnets.

### OnPrem-1xRI-2xVPC-1xPRC [2] {#ri-topology-2}

Non-reserved on-prem connection via a single {{ interconnect-name }} [private connection](../../vpc/concepts/network.md) to a single `RI` with two or more [cloud networks](../../interconnect/concepts/priv-con.md) without network connectivity between them.

* `On-Prem` client with two local subnets: `subnet-c1` and `subnet-c2`.
* The `On-Prem` network hardware is connected to the {{ yandex-cloud }} network hardware via [{{ interconnect-name }}](../../interconnect/concepts/index.md).
* The `prc-m9` [private connection](../../interconnect/concepts/priv-con.md) established via the `M9` [point of presence](../../interconnect/concepts/pops.md) connects to `RI` in {{ yandex-cloud }}.
* Two virtual networks connect to `RI` on the {{ yandex-cloud }} side:
  * `Net-1` comprised of three subnets: `subnet-a1`, `subnet-b1`, and `subnet-d1`.
  * `Net-2` comprised of three subnets: `subnet-a2`, `subnet-b2`, and `subnet-d2`.

This topology enables network connectivity between:

* `On-Prem` subnets and `Net-1` VPC subnets `subnet-a1`, `subnet-b1`, and `subnet-d1`.
* `On-Prem` subnets and `Net-2` VPC subnets `subnet-a2`, `subnet-b2`, and `subnet-d2`.

This topology enables network connectivity between `Net-1` and `Net-2` virtual networks subnets.

### OnPrem-1xRI-1xVPC-2xPRC [3] {#ri-topology-3}

Reserved on-prem connection via two {{ interconnect-name }} [private connections](../../vpc/concepts/network.md) to a single `RI` with a single [cloud network](../../interconnect/concepts/priv-con.md).

* `On-Prem` client with two local subnets: `subnet-c1` and `subnet-c2`.
* The `On-Prem` network hardware connects to the {{ yandex-cloud }} network hardware via [Cloud Interconnect](../../interconnect/concepts/index.md).
* Two private connections called `prc-m9` and `prc-nord` via the `M9` and `NORD` [points of presence](../../interconnect/concepts/pops.md) connect to `RI` in {{ yandex-cloud }}.
* On the {{ yandex-cloud }} side, the `Net-1` virtual network comprised of three subnets, `subnet-a1`, `subnet-b1`, and `subnet-d1`, connects to `RI`.

This topology enables network connectivity between `On-Prem` subnets and `Net-1` VPC subnets.

Use appropriate {{ interconnect-name }} [routing tools](../../interconnect/concepts/routing.md#cic-routing-as) to prioritize traffic between [private connections](../../interconnect/concepts/priv-con.md).

In case of failure of any of the private connections above, all network traffic will be automatically switched over to the remaining private connection.

### On-Prem-1xRI-2xVPC-2xPRC [4] {#ri-topology-4}

Reserved on-prem connection via two {{ interconnect-name }} [private connections](../../vpc/concepts/network.md) to a single `RI` with two *or more* [cloud networks](../../interconnect/concepts/priv-con.md) without network connectivity between them.

* `On-Prem` client with two local subnets: `subnet-c1` and `subnet-c2`.
* The `On-Prem` network hardware connects to the {{ yandex-cloud }} network hardware via [Cloud Interconnect](../../interconnect/concepts/index.md).
* Two private connections, `prc-m9` and `prc-nord`, established via two [points of presence](../../interconnect/concepts/pops.md), `M9` and `NORD`, connect to `RI` in {{ yandex-cloud }}.
* Two virtual networks connect to `RI` on the {{ yandex-cloud }} side:
  * `Net-1` comprised of three subnets: `subnet-a1`, `subnet-b1`, and `subnet-d1`.
  * `Net-2` comprised of three subnets: `subnet-a2`, `subnet-b2`, and `subnet-d2`.

This topology enables network connectivity between:

* `On-Prem` subnets and `Net-1` VPC subnets `subnet-a1`, `subnet-b1`, and `subnet-d1`.
* `On-Prem` subnets and `Net-2` VPC subnets `subnet-a2`, `subnet-b2`, and `subnet-d2`.

In case of failure of any of the private connections above, all network traffic will be automatically switched over to the remaining private connection.

This topology enables network connectivity between `Net-1` and `Net-2` virtual networks subnets.

### OnPrem-2x(1xRI-1xVPC-1xPRC) [5] {#ri-topology-5}

Two separate independent network topologies. In each topology, there is a [private connection](../../interconnect/concepts/priv-con.md) connected to `RI` on one side and a [virtual cloud network](../../vpc/concepts/network.md) on the other.

* `On-Prem` client with two local subnets: `subnet-c1` and `subnet-c2`.
* The `On-Prem` network hardware connects to the {{ yandex-cloud }} network hardware via [Cloud Interconnect](../../interconnect/concepts/index.md).
* The `prc-m9-1` [private connection](../../interconnect/concepts/priv-con.md) via the `M9` [point of presence](../../interconnect/concepts/pops.md) connects to `Routing Instance 1` in {{ yandex-cloud }}.
* The `Net-1` virtual network comprised of three subnets, `subnet-a1`, `subnet-b1`, and `subnet-d1`, connects to `RI 1` on the {{ yandex-cloud }} side.
* The `prc-m9-2` [private connection](../../interconnect/concepts/priv-con.md) via the `M9` [point of presence](../../interconnect/concepts/pops.md) connects to `Routing Instance 2` in {{ yandex-cloud }}.
* The `Net-2` virtual network comprised of three subnets, `subnet-a2`, `subnet-b2`, and `subnet-d2`, connects to `RI 2` on the {{ yandex-cloud }} side.

This creates two network topologies (based on the number of RIs used):

* Topology 1 enables network connectivity between `On-Prem` subnets and `Net-1` VPC subnets via `RI 1`.
* Topology 2 enables network connectivity between `On-Prem` subnets and `Net-2` VPC subnets via `RI 2`.

These topologies do not enable network connectivity between `Net-1` and `Net-2` virtual networks subnets.

{% note info %}

If necessary, customers can enable network connectivity between `Net-1` and `Net-2` VPC subnets by setting up traffic routing between private connections on their network hardware.

{% endnote %}

