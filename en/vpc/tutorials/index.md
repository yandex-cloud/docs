---
title: '{{ vpc-full-name }} use cases'
description: Various {{ vpc-name }} use cases in {{ yandex-cloud }}.
---

# {{ vpc-name }} tutorials

## Setting up VPN connections {#sec-vpn}

* [Connecting to a cloud network using OpenVPN](openvpn.md)
* [Creating a bastion host](bastion.md)
* [Secure user access to cloud resources based on WireGuard VPN](remote-wireguard-vpn.md)
* [Creating a tunnel between two subnets using OpenVPN Access Server](site-to-site-openvpn.md)
* [Configuring a secure GRE tunnel over IPsec](gre-over-ipsec.md)
* [Setting up network connectivity with IPsec gateways](ipsec/index.md)

## NGFW-based network cloud infrastructure {#sec-ngfw}

* [Implementing a secure high-availability network infrastructure with a dedicated DMZ based on the Check Point NGFW](high-accessible-dmz.md)
* [Cloud infrastructure segmentation with the Check Point NGFW](network-segmentation-checkpoint.md)
* [Creating and configuring a UserGate gateway in proxy server mode](usergate-proxy.md)
* [Implementing a secure high-availability network infrastructure with a dedicated DMZ based on Smart-Soft NGFW](high-accessible-dmz-ting.md)
* [Creating and configuring a UserGate gateway in firewall mode](usergate-firewall.md)

## {{ baremetal-name }} {#sec-baremetal}

* [Configuring VRRP for a {{ baremetal-name }} server cluster using Keepalived](bms-vrf-routing.md)
* [Establishing network connectivity in a private {{ baremetal-full-name }} subnet](bms-simple-subnet.md)
* [Setting up network connectivity between {{ baremetal-full-name }} and {{ vpc-full-name }} subnets using {{ interconnect-full-name }}](bm-vrf-and-vpc-interconnect.md)
* [Forwarding USB devices to a {{ baremetal-name }} server or {{ compute-name }} virtual machine](usb-over-ip.md)
* [Configuring an OPNsense firewall in high availability cluster mode on {{ baremetal-full-name }} servers](opnsense-failover-cluster.md)
* [Deploying a web application on {{ baremetal-full-name }} servers with an L7 load balancer and {{ sws-full-name }} protection](webapp-on-bms-behind-sws.md)

## {{ interconnect-name }} {#sec-interconnect}

* [Configuring {{ interconnect-name }} access to cloud networks behind NGFWs](cic-with-ngfw.md)
* [Creating a direct trunk and a private connection in it](trunk-priv-add.md)
* [Creating a direct trunk and a public connection in it](trunk-pub-add.md)
* [Adding a private connection to a direct or partner trunk](priv-add.md)
* [Adding a public connection to a direct or partner trunk](pub-add.md)
* [Changing trunk capacity](trunk-capacity-change.md)
* [Deleting a private connection](priv-del.md)
* [Deleting a public connection](pub-del.md)
* [Deleting a trunk](trunk-del.md)

## Configuring network resources and interaction between them {#sec-network-resources}

* [Architecture and protection of a basic internet service](web-service.md)
* [Setting up networking between resources from different folders](multi-folder-vpc.md)
* [Implementing fault-tolerant use cases for network VMs](route-switcher.md)
* [Configuring a network for {{ dataproc-full-name }}](data-processing-nat-instance.md)
* [Network connection switching during {{ dataproc-full-name }} cluster recreation](data-processing-dns-reconnect.md)
* [Migrating an HDFS {{ dataproc-full-name }} cluster to a different availability zone](hdfs-cluster-migration.md)
* [DHCP settings for interfacing with a corporate DNS server](dhcp-options.md)
* [Routing through a NAT instance](nat-instance/index.md)
* [Deploying an Always On availability group with an internal network load balancer](mssql-alwayson-lb.md)

## Connecting to services {#sec-services-connect}

* [Connecting to {{ objstorage-name }} from {{ vpc-name }}](storage-vpc-access.md)
* [Connecting to {{ container-registry-name }} from {{ vpc-name }}](vpc-cr-access.md)

## Additional settings and tools {#sec-tools}

* [Installing the Cisco CSR 1000v virtual router](cisco.md)
* [Installing a Mikrotik CHR virtual router](mikrotik.md)
* [Configuring {{ dns-full-name }} to access a {{ mch-full-name }} cluster from other cloud networks](clickhouse-dns-peering.md)
* [Automating {{ yq-full-name }} tasks with {{ maf-full-name }}](airflow-auto-tasks.md)
* [Using {{ yandex-cloud }} modules in {{ TF }}](terraform-modules.md)