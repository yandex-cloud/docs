---
title: Use cases for core infrastructure management systems in {{ yandex-cloud }}
description: Various use cases for core infrastructure management systems in {{ yandex-cloud }}.
---

# Tutorials for working with basic infrastructure management systems

* [Architecture and protection of a basic internet service](../routing/web-service.md)

## Fault tolerance and scaling {#fault-tolerance}

* [Configuring a fault-tolerant architecture in {{ yandex-cloud }}](../infrastructure-management/fault-tolerance.md)
* [Fault-tolerant website with load balancing via {{ network-load-balancer-full-name }}](../web/load-balancer-website/index.md)
* [Fault-tolerant website with load balancing using {{ alb-full-name }}](../web/application-load-balancer-website.md)
* [Integrating an L7 load balancer with {{ cdn-full-name }} and {{ objstorage-full-name }}](../web/cdn-storage-integration.md)
* [Running an instance group with autoscaling](../infrastructure-management/vm-autoscale/index.md)
* [Scheduled scaling of instance groups](../infrastructure-management/vm-scale-scheduled/index.md)
* [Autoscaling an instance group to process messages enqueued in {{ message-queue-name }}](../infrastructure-management/autoscale-monitoring.md)
* [Updating an instance group under load](../infrastructure-management/updating-under-load.md)
* [Creating a trigger for budgets that invokes a {{ sf-full-name }} function to stop VM instances](../infrastructure-management/serverless-trigger-budget-vm.md)
* [Deploying a fault-tolerant architecture with preemptible VMs](../infrastructure/nodejs-cron-restart-vm.md)
* [Creating triggers that invoke {{ sf-full-name }} functions to stop a VM and send Telegram notifications](../infrastructure-management/serverless-trigger-budget-queue-vm-tg.md)

## Tools {#tools}

* [Getting started with {{ TF }}](../infrastructure-management/terraform-quickstart.md)
* [Terraform data sources](../infrastructure-management/terraform-data-sources.md)
* [Uploading {{ TF }} states to {{ objstorage-full-name }}](../infrastructure-management/terraform-state-storage.md)
* [Getting started with Packer](../infrastructure-management/packer-quickstart.md)
* [Building a VM image with infrastructure tools using Packer](../infrastructure-management/packer-custom-image.md)
* [Locking {{ TF }} states using {{ ydb-full-name }}](../infrastructure-management/terraform-state-lock.md)
* [Using {{ yandex-cloud }} modules in {{ TF }}](../infrastructure-management/terraform-modules.md)
* [Running a Docker image on a VM](../infrastructure-management/run-docker-on-vm/index.md)
* [Transferring logs through {{ unified-agent-short-name }} HTTP input to {{ cloud-logging-full-name }}](../infrastructure-management/ua-http-logging.md)

## Network {#routing}

* [Configuring clock synchronization using NTP](../infrastructure-management/ntp.md)
* [DHCP settings for working with a corporate DNS server](../routing/dhcp-options.md)
* [Routing through a NAT instance](../routing/nat-instance/index.md)
* [Installing a Cisco CSR 1000v virtual router](../routing/cisco.md)
* [Installing a Mikrotik CHR virtual router](../routing/mikrotik.md)
* [Installing an NGINX Ingress controller with a {{ certificate-manager-name }} certificate](../container-infrastructure/nginx-ingress-certificate-manager.md)

## VPNs {#vpns}

* [Setting up network connectivity with IPsec gateways](../routing/ipsec/index.md)
* [Connecting to a cloud network using OpenVPN](../routing/openvpn.md)
* [Creating and configuring a UserGate gateway in proxy server mode](../routing/usergate-proxy.md)

## {{ dns-full-name }} {#dns}

* [Configuring a local caching DNS resolver](../infrastructure-management/local-dns-cache.md)
* [Migrating DNS zones from {{ yandex-360 }} to {{ dns-name }}](../infrastructure-management/connect-migration.md)
* [{#T}](../dataplatform/clickhouse-dns-peering.md)
* [{#T}](../infrastructure-management/dns-integration.md)
* [Creating an ACME resolver webhook for responses to DNS01 checks](../infrastructure-management/cert-manager-webhook.md)
