---
title: "Use cases for core infrastructure management systems in {{ yandex-cloud }}"
description: "Various use cases for core infrastructure management systems in {{ yandex-cloud }}."
---

# Tutorials for working with basic infrastructure management systems

* [Architecture and protection of a basic internet service](../routing/web-service.md)

## Fault tolerance and scaling {#fault-tolerance}

* [Configuring a fault-tolerant architecture in {{ yandex-cloud }}](../infrastructure-management/fault-tolerance.md)
* [Fault-tolerant website with load balancing by {{ network-load-balancer-full-name }}](../web/load-balancer-website.md)
* [Fault-tolerant website with load balancing by {{ alb-full-name }}](../web/application-load-balancer-website.md)
* [Integrating an L7 load balancer with {{ cdn-full-name }} and {{ objstorage-full-name }}](../web/cdn-storage-integration.md)
* [Running instance groups with auto-scaling](../infrastructure-management/vm-autoscale.md)
* [Scheduled scaling of instance groups](../infrastructure-management/vm-scale-scheduled.md)
* [Auto-scaling an instance group when processing messages from a queue in {{ message-queue-full-name }}](../infrastructure-management/autoscale-monitoring.md)
* [Updating an instance group under load](../infrastructure-management/updating-under-load.md)
* [Creating a trigger for budgets that invokes a {{ sf-full-name }} function to stop VM instances](../infrastructure-management/serverless-trigger-budget-vm.md)
* [Deploying a fault-tolerant architecture with preemptible VMs](../infrastructure/nodejs-cron-restart-vm.md)
* [Creating triggers that invoke {{ sf-full-name }} functions to stop a VM and send Telegram notifications](../infrastructure-management/serverless-trigger-budget-queue-vm-tg.md)

## Tools {#tools}

* [Getting started with {{ TF }}](../infrastructure-management/terraform-quickstart.md)
* [Uploading {{ TF }} statuses to {{ objstorage-name }}](../infrastructure-management/terraform-state-storage.md)
* [Getting started with Packer](../infrastructure-management/packer-quickstart.md)
* [Building a VM image with a set of infrastructure tools using Packer](../infrastructure-management/packer-custom-image.md)
* [Locking {{ TF }} states using {{ ydb-full-name }}](../infrastructure-management/terraform-state-lock.md)
* [Using {{ yandex-cloud }} modules in {{ TF }}](../infrastructure-management/terraform-modules.md)

## Network {#routing}

* [Configuring clock synchronization using NTP](../infrastructure-management/ntp.md)
* [DHCP settings for working with a corporate DNS server](../routing/dhcp-options.md)
* [Routing through a NAT instance](../routing/nat-instance.md)
* [Installing a Cisco CSR 1000v virtual router](../routing/cisco.md)
* [Installing a Mikrotik CHR virtual router](../routing/mikrotik.md)

## VPNs {#vpns}

* [Setting up network connectivity with IPsec gateways](../routing/ipsec/index.md)
* [Connecting to a cloud network using OpenVPN](../routing/openvpn.md)
* [Creating and configuring a UserGate gateway in proxy server mode](../routing/usergate-proxy.md)

## {{ dns-full-name }} {#dns}

* [Configuring a local caching DNS resolver](../infrastructure-management/local-dns-cache.md)
* [Migrating DNS zones from {{ yandex-360 }} to {{ dns-name }}](../infrastructure-management/connect-migration.md)
* [{#T}](../dataplatform/mdb-dns-peering.md)
* [{#T}](../infrastructure-management/dns-integration.md)
* [Creating an ACME resolver webhook for responses to DNS01 checks](../infrastructure-management/cert-manager-webhook.md)
