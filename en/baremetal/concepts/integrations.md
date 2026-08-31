---
title: '{{ baremetal-full-name }} integrations with other {{ yandex-cloud }} services'
description: This page provides a list of {{ yandex-cloud }} services that integrate with {{ baremetal-full-name }} and describes the tasks these integrations address.
---

# Integrations with other {{ yandex-cloud }} services

{{ baremetal-full-name }} supports integrations with other {{ yandex-cloud }} services for backup, monitoring, auditing, access management, image uploads, hybrid network connectivity, running application scripts on physical servers, and delivery of large amounts of static content to external users.

See below for the list of supported services and their respective {{ baremetal-name }} integration guides.

## {{ cdn-full-name }} {#cdn}

[{{ cdn-full-name }}](../../cdn/index.yaml) can deliver content from an origin hosted on a {{ baremetal-name }} server. Alternatively, you can configure an L7 load balancer as your CDN origin to route traffic to an application hosted on {{ baremetal-name }} servers.

This architecture accelerates static content delivery to end users and minimizes origin server load via CDN server-side caching.

Sections:

* [Creating a CDN resource with an origin server](../../cdn/quickstart/server.md)
* [Origins and origin groups](../../cdn/concepts/origins.md)
* [Creating a resource](../../cdn/operations/resources/create-resource.md)
* [{#T}](../tutorials/webapp-on-bms-behind-sws.md)

## {{ stackland-full-name }} {#stackland}

[{{ stackland-full-name }}](../../stackland/index.yaml) supports {{ baremetal-name }} as a deployment environment. You can install a {{ stackland-name }} cluster on {{ baremetal-name }} servers connected to the same private network.

This architecture enables the deployment of a containerization platform with integrated PaaS services on dedicated physical servers.

Tutorial: [Installing {{ stackland-name }} on {{ baremetal-name }}](../../stackland/tutorials/install-on-yc-bms.md).

## {{ backup-full-name }} {#backup}

[{{ backup-full-name }}](../../backup/index.yaml) allows you to assign {{ baremetal-name }} servers to backup policies, create backups, and restore servers from backups.

This integration safeguards your data and ensures server recovery following crashes, configuration errors, or data corruption.

Related guides:

* [{#T}](../operations/backup-baremetal.md)
* [{#T}](../tutorials/backup-baremetal.md)

## {{ interconnect-full-name }} {#interconnect}

[{{ interconnect-full-name }}](../../interconnect/index.yaml) establishes private connections between {{ baremetal-name }} VRFs and cloud networks. {{ baremetal-name }} servers can use these connections to exchange traffic with resources connected to {{ vpc-name }} subnets and on-prem infrastructure via private addresses.

This integration enables building hybrid L3 networks and connecting physical hardware directly to cloud services without using a public network.

Sections:

* [Private connection to cloud networks](./private-network.md#private-connection-to-vpc)
* [{#T}](../operations/create-vpc-connection.md)
* [{#T}](../tutorials/bm-vrf-and-vpc-interconnect.md)

## {{ cr-full-name }} {#cloud-router}

[{{ cr-full-name }}](../../cloud-router/index.yaml) provisions routing instances involved in traffic routing between a {{ interconnect-name }} private connection, {{ vpc-name }} networks, and {{ baremetal-name }} VRFs.

{{ cr-full-name }} enables management of hybrid network topologies and traffic routing between physical servers, cloud networks, and on-prem infrastructure.

Sections:

* [Routing Instance](../../cloud-router/concepts/routing-instance.md)
* [{#T}](../tutorials/bm-vrf-and-vpc-interconnect.md)

## {{ vpc-full-name }} {#vpc}

[{{ vpc-full-name }}](../../vpc/index.yaml) provides cloud networks and subnets you can connect to a {{ baremetal-name }} private network via {{ interconnect-name }} and {{ cr-name }}.

This approach ensures {{ baremetal-name }} server access to cloud resources via private addresses and enables connecting cloud load balancers, clusters, and databases to applications on physical servers.

Sections:

* [Private connection to cloud networks](./private-network.md#private-connection-to-vpc)
* [{#T}](../operations/create-vpc-connection.md)
* [{#T}](../tutorials/bm-vrf-and-vpc-interconnect.md)

## {{ managed-k8s-full-name }} {#managed-kubernetes}

[{{ managed-k8s-full-name }}](../../managed-kubernetes/index.yaml) allows you to connect a {{ baremetal-name }} server to a {{ managed-k8s-name }} cluster as an external node. Network connectivity between the {{ baremetal-name }} VRF and the cluster virtual network is established through {{ interconnect-name }}.

This integration supports running containerized workloads on physical servers for applications that require dedicated hardware resources or specialized network settings.

Sections:

* [{#T}](../tutorials/k8s-connect-bms-as-node.md)
* [Connecting external nodes to a cluster](../../managed-kubernetes/operations/external-nodes-connect.md)

## {{ alb-full-name }} {#application-load-balancer}

[{{ alb-full-name }}](../../application-load-balancer/index.yaml) can distribute HTTP(S) traffic to a web application deployed on {{ baremetal-name }} servers. Connections to servers are routed via {{ interconnect-name }} and {{ vpc-name }}.

This integration enables you to expose web applications running on physical servers to the public internet, balance load, and check backend availability.

Tutorial: [{#T}](../tutorials/webapp-on-bms-behind-sws.md).

## {{ sws-full-name }} {#smart-web-security}

[{{ sws-full-name }}](../../smartwebsecurity/index.yaml) enables you to connect a security profile to an L7 load balancer that routes traffic to a web application deployed on {{ baremetal-name }} servers.

The security profile ensures the protection of incoming HTTP(S) traffic from bots, DDoS, and web attacks.

Tutorial: [{#T}](../tutorials/webapp-on-bms-behind-sws.md).

## {{ dns-full-name }} {#cloud-dns}

[{{ dns-full-name }}](../../dns/index.yaml) allows you to resolve domain names from {{ yandex-cloud }} internal DNS zones on {{ baremetal-name }} servers. To do this, create an [inbound DNS connection](../../dns/concepts/dns-connection.md#dns-inbound) in the {{ vpc-name }} network and specify its IP address as the DNS server on the {{ baremetal-name }} server.

Tutorial: [{#T}](../tutorials/bm-vpc-dns-forwarder.md).

## {{ mpg-full-name }} {#managed-postgresql}

[{{ mpg-full-name }}](../../managed-postgresql/index.yaml) may be accessible from a {{ baremetal-name }} private network via its FQDN once network connectivity with {{ vpc-name }} and an inbound DNS connection is established.

This enables you to connect applications on physical servers to a managed database without using cluster host IP addresses that may change.

Tutorial: [{#T}](../tutorials/bm-vpc-dns-forwarder.md).

## {{ objstorage-full-name }} {#object-storage}

[{{ objstorage-full-name }}](../../storage/index.yaml) stores custom ISO images. First, an image file is uploaded to an {{ objstorage-name }} bucket, and then the object’s link is used to create an image in {{ baremetal-name }}.

This enables you to install on servers your own operating systems and software products that are not provisioned in stock images.

Sections:

* [Custom images](./images.md#user-images)
* [{#T}](../operations/image-upload.md)

## {{ marketplace-short-name }} {#marketplace}

[{{ marketplace-short-name }}](../../marketplace/index.yaml) provides pre-configured OS images available when renting a server or reinstalling an OS.

This enables you to deploy a server with a supported OS faster without the need to manually provision a custom ISO image.

Sections:

* [{{ marketplace-short-name }} images](./images.md#marketplace-images)
* [{#T}](../operations/servers/reinstall-os-from-marketplace.md)

## {{ monitoring-full-name }} {#monitoring}

{{ baremetal-name }} metrics are delivered to [{{ monitoring-full-name }}](../../monitoring/index.yaml).

Use these metrics to monitor the state of {{ baremetal-name }} resources and establish infrastructure observability across physical servers.

Section: [{#T}](../metrics.md).

## {{ at-full-name }} {#audit-trails}

[{{ at-full-name }}](../../audit-trails/index.yaml) receives management and data events for {{ baremetal-name }} resources.

You can use these audit events to analyze actions on resources, investigate incidents, monitor changes and network events.

Section: [{#T}](../at-ref.md).

## {{ iam-full-name }} {#iam}

Access to {{ baremetal-name }} resources is managed via [{{ iam-full-name }}](../../iam/index.yaml) roles, which are assigned to users, service accounts, groups, and system subjects.

These roles allow you to differentiate permissions to view, administer, and operate {{ baremetal-name }} resources.

Section: [{#T}](../security/index.md).

#### More {#see-also}

* [{#T}](./network.md)
* [{#T}](./private-network.md)
* [{#T}](./images.md)
* [{#T}](../tutorials/index.md)
