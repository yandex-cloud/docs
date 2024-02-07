# {{ yandex-cloud }} network overview

A {{ yandex-cloud }} network is formed of two large parts:

* [Physical network](#underlay): Hardware network within [data centers](../../overview/concepts/geo-scope.md) and a transport network between the data centers and external network and internet [connection points](../../interconnect/concepts/pops.md). A physical network is often referred to as *underlay*.
* [Virtual network](#overlay): Network that works on top of the physical network infrastructure. [Virtual Private Cloud (VPC)](../../vpc/concepts/) services provide users with:
  * IP connectivity between cloud resources.
  * Access to the internet for cloud resources.

   A virtual network is often referred to as *overlay*. One or more [virtual networks](../../vpc/concepts/network.md) can be created in a single [resource folder](../../resource-manager/concepts/resources-hierarchy.md#folder). Virtual networks are isolated from each other even if hosted in the same resource folder.

Below is an overview of the [physical network](#underlay) and [virtual network](#overlay) in {{ yandex-cloud }}. For more information about network components, see [Extra materials](#refs).

## Physical network in {{ yandex-cloud }} {#underlay}


One of the main physical network components is the *{{ yandex-cloud }} transport network*.

The following objects connect to the transport network:

* {{ yandex-cloud }} [data centers (availability zones)](../../overview/concepts/geo-scope.md).
* [Points of presence (PoP)](../../interconnect/concepts/pops.md). PoPs host the network equipment of the transport network. Connections to external networks and the internet (*Internet Peering*) are set up on individual PoPs. On individual PoPs, {{ yandex-cloud }} customers can set up IP connectivity between their own infrastructure's resources and [cloud resources](../../interconnect/concepts/priv-con.md) and [public services](../../interconnect/concepts/pub-con.md#svc-list) in {{ yandex-cloud }} using [{{ interconnect-full-name }}](../../interconnect/concepts/).

The {{ yandex-cloud }} transport network consists of two layers:

* Optical DWDM network layer. Dense wavelength-division multiplexing ([DWDM](https://en.wikipedia.org/wiki/Wavelength-division_multiplexing#DWDM_systems)) equipment provides a connection to IP/MPLS packet network equipment. With the DWDM equipment, the transport network can easily increase its capacity (bandwidth) to dozens of terabits.
* IP/MPLS packet network layer. It provides IPv4 connectivity between the availability zones and points of presence (underlay and overlay), as well as network transport required for all {{ yandex-cloud }} services to run.

The availability zones are linked through the {{ yandex-cloud }} transport network. PoPs enabling networking with other networks, including the internet, also connect to the transport network nodes. The transport network ensures fault-tolerant traffic exchange between the availability zones and PoPs.

Outbound traffic from the cloud resources in all the availability zones is distributed more or less evenly across all PoPs.

Likewise, inbound traffic to the cloud resources is distributed more or less evenly across all the {{ yandex-cloud }} availability zones.

All availability zones have the same weight: they provide identical network connectivity, i.e., the same data exchange rate and throughput. Traffic delays from an external resource to the cloud resources in different availability zones may differ slightly.

## Virtual network in {{ yandex-cloud }} {#overlay}

The {{ yandex-cloud }} virtual network includes a set of [{{ vpc-name }}](../../vpc/concepts/) network functions and allows users:

* Setting up networking between the cloud resources.
* Setting up networking between the cloud resources and the internet.
* Using additional network features for traffic processing ([CloudGate](#cloudgate)).

The virtual network in {{ yandex-cloud }} is built on selected components of the [Tungsten Fabric](https://github.com/tungstenfabric/opencontrails-docs) project (formerly known as OpenContrail).


The {{ yandex-cloud }} virtual network architecture has the following key components:

### VRouter {#vrouter}

*VRouter* is a network traffic listener. It runs on each {{ yandex-cloud }} physical server. It is used as the default gateway for all subnet objects (subnet's first IP address (`x.x.x.1`)). It handles network traffic of all the VMs running on a server. Traffic is forwarded based on the flows table the records in which are programmed using another virtual network component called VRouter agent. To enable traffic forwarding through the [underlay](#underlay) network, the [MPLS over UDP](https://datatracker.ietf.org/doc/html/rfc7510) tunneling technology is used.

VRouter enables One-to-One NAT for VM [public IP addresses](../../vpc/concepts/address.md#public-addresses).

VRouter also enables [security groups](../../vpc/concepts/security-groups.md) for all the VMs on the physical server it runs on.

### VRouter agent {#vrouter-agent}

The VRouter agent is an auxiliary component used for traffic processing. It works together with VRouter and programs the network flows table on the server. This table defines traffic forwarding rules for a specific IP prefix. The VRouter agent enables the following protocols and functions on the server for VMs:

* [VM metadata service](../../compute/concepts/vm-metadata.md) accessible only inside a VM at `169.254.169.254`.
* DNS service to process DNS traffic on a cloud subnet's second IP address (`x.x.x.2`).
* ICMP.

### CloudGate {#cloudgate}

CloudGate is a component that includes groups of service VMs in each [availability zone](../../overview/concepts/geo-scope.md) that ensure IP connectivity between the physical and virtual networks and provide a number of additional network functions:

* [NAT gateway (NAT-GW)](../../vpc/concepts/gateways.md)
* [Network load balancer (NLB)](../../network-load-balancer/concepts/)
* [Cloud Interconnect (CIC)](../../interconnect/concepts/)

Each network function within CloudGate runs on a separate group of service VMs inside {{ yandex-cloud }}.

## Types of networking {#flows}

Data centers are directly associated with the {{ yandex-cloud }} [availability zones](../../overview/concepts/geo-scope.md).

The above diagram shows the main types of networking between VMs in the {{ yandex-cloud }} virtual network:

#### Traffic between VMs in a single availability zone {#between-vm-in-one-az}

Traffic from `VM-A1` to `VM-A2` in availability zone A will be routed as follows:

1. `VM-A1` → `VRouter on Server-A1`.
1. `Server-A1` → `Server-A2` (within availability zone A).
1. `VRouter on Server-A2` → `VM-A2`.

#### Traffic between VMs in different availability zones {#between-vm-in-different-az}

Traffic from `VM-A2` in availability zone A to `VM-B1` in availability zone B will be routed as follows:

1. `VM-A2` → `VRouter on Server-A2`.
1. `Server-A2` → Boundary network equipment of the transport network of availability zone A.
1. Boundary network equipment of the transport network of availability zone A → Boundary network equipment of the transport network of availability zone B.
1. Availability zone B boundary network equipment → `Server-B1`.
1. `VRouter on Server-B1` → `VM-B1`.

#### VM traffic to the internet via a NAT gateway {#from-vm-to-internet-via-nat-gateway}

Traffic from `VM-A1` to the internet via the NAT gateway will be routed as follows:

1. `VM-A1` → `VRouter on Server-A1`.
1. `Server-A1` → CloudGate `NAT-GW` function (via the availability zone A intranet).
1. `NAT-GW` → Availability zone A boundary network equipment.
1. Availability zone A boundary network equipment → Network equipment at the point of presence where there is a connection to external networks and the internet.

## Limitations {#limits}

1. Currently, network connectivity in the {{ yandex-cloud }} virtual network is only provided through IPv4. There is no support for IPv6.
1. The {{ yandex-cloud }} virtual network runs on OSI Layer 3 (L3), which makes the use of the OSI Layer2 (L2) network technology very limited:
   1. Responses to ARP requests from VRouter (default gateway) will always be received from the same fixed MAC address.
   1. The only transport used for networking is `Unicast`. There is no support for `Multicast`.
   1. Network protocols that require a single virtual IP address (VIP) across VMs, such as HSRP, VRRP, or GLBP, are not supported.

## Extra materials {#refs}

* [Yandex Cloud network infrastructure overview (2019)](https://habr.com/ru/companies/yandex/articles/437816/)
* [Yandex Cloud's Virtual Private Cloud overview (2020)](https://habr.com/ru/companies/yandex/articles/487694/)
