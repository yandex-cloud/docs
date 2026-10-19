---
title: Migrating to {{ managed-k8s-name }}
description: This section contains guides for migrating Kubernetes workloads from a public cloud or on-premises setup to {{ managed-k8s-name }}.
---

# Migrating to {{ managed-k8s-name }}

{{ managed-k8s-name }} enables you to migrate your Kubernetes workloads from any environment, without vendor or infrastructure lock-in. The following scenarios are supported:

* [Migration from other cloud providers to {{ yandex-cloud }}](migration-from-cloud.md).
* Migration from on-premises infrastructure to {{ yandex-cloud }}.
* Hybrid setups with partial workload migration to {{ yandex-cloud }} using [external nodes](../../operations/external-nodes-connect.md) or [BareMetal servers](../../operations/bms-server-connect.md).

## Migration overview {#overview}

1. **Inventory**: Audit your workloads, assess API compatibility, and define network requirements.
1. **Network connectivity (for on-premises)**: Establish a connection between the source infrastructure and {{ yandex-cloud }}.
1. **{{ yandex-cloud }} infrastructure**: Create VPCs, security groups, IAM resources, a {{ managed-k8s-name }} cluster, and node groups.
1. **Image migration**: Copy your container images to {{ container-registry-full-name }}.
1. **Stateful workload migration**: Migrate your data using {{ data-transfer-full-name }} or Velero.
1. **Stateless workload migration**: Export, adjust, and apply your manifests.
1. **Load balancers and DNS**: Configure Gwin, Network Load Balancer, and DNS switching.
1. **Final steps**: Test your new setup, clean up the source infrastructure, and archive backups.

## Required time and effort {#effort}

The time a migration may take depends on the size of your data, number of services to migrate, and your specific migration path. Here are the general estimates:

#|
|| **Scenario** | **Average scope** | **Estimated duration** ||
|| Public cloud to {{ yandex-cloud }} | Up to 10 services, up to 100 GB of data | 1–3 days ||
|| Public cloud to {{ yandex-cloud }} | 10 to 50 services, up to 1 TB of data | 1–2 weeks ||
|| Private cloud to {{ yandex-cloud }} | Up to 10 services, up to 100 GB of data | 2–5 days ||
|| Private cloud to {{ yandex-cloud }} | 10 to 50 services, up to 1 TB of data | 2–4 weeks ||
|| Hybrid cloud | Up to 10 services, up to 100 GB of data | 2–5 days ||
|| Hybrid cloud | 10 to 50 services, up to 1 TB of data | 2–4 weeks ||
|#

These estimates assume a team of two or three engineers. Timelines may increase for complex stateful workloads, non-standard network requirements, or regulatory constraints.

## Required tools {#tools}

#|
|| **Tool** | **Description** ||
|| [Gwin](https://github.com/yandex-cloud/gwin) | Gateway API controller for {{ alb-full-name }}. Recommended for setting up an L7 load balancer. ||
|| [Velero](https://velero.io/) | Backup and recovery tool for persistent volumes ||
|| [{{ data-transfer-full-name }}](../../../data-transfer/index.yaml) | Data migration from managed databases ||
|| [{{ container-registry-full-name }}](../../../container-registry/index.yaml) | Storage for container images in {{ yandex-cloud }} ||
|| [{{ objstorage-full-name }}](../../../storage/index.yaml) | Storage for Velero backups and intermediate storage during migration ||
|| [{{ dns-full-name }}](../../../dns/index.yaml) | DNS record management when switching traffic ||
|#
