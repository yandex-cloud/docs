---
title: Host roles in {{ mos-full-name }}
description: In this article, you will learn about host roles in {{ mos-name }}.
---

# Host roles in {{ mos-name }}

Each {{ mos-name }} cluster consists of one or more host groups of the `{{ OS }}` and `Dashboards` (optional) types:

* The `{{ OS }}` host group may contain hosts with the [DATA](#data), [MANAGER](#manager), [WARM](#warm), or [INGEST](#ingest) roles.
  
  The cluster must include hosts with the `DATA` and `MANAGER` roles. If a cluster has a single `{{ OS }}` group, its hosts will have both roles.

* A `Dashboards` host group may only contain hosts with the [DASHBOARDS](#dashboards) role.

## Hosts with the DATA role {#data}

Hosts with this role store one or more indexes and handle search, write, and analysis queries.


For a cluster to be highly available and covered by a [service level agreement (SLA)](https://yandex.ru/legal/cloud_sla_mdb/), it must have two or more hosts with the `DATA` role.


[More on high-availability of clusters](../../managed-opensearch/concepts/high-availability.md).

### Use cases {#examples-data}

* [{#T}](../tutorials/migration-to-opensearch.md)
* [{#T}](../tutorials/opensearch-index-policy.md)
* [{#T}](../tutorials/opensearch-cold-storage-policy.md)
* [{#T}](../tutorials/opensearch-to-object-storage.md)
* [{#T}](../tutorials/opensearch-yandex-lemmer.md)

## Hosts with the MANAGER role {#manager}

Hosts with this role monitor the state of the cluster and manage its configuration, ensuring the performance of all {{ OS }} components.

If you are using hosts with the `MANAGER` role, a group containing three such hosts will be added to the cluster.

If no hosts with the `MANAGER` role are used, make sure to assign this role to the hosts with the `DATA` role. However, having dedicated hosts with the `MANAGER` role allows you to increase the overall cluster reliability and reduce the load on hosts with the `DATA` role.

{% include [note-host-manager](../../_includes/mdb/mos/note-host-group-manager.md) %}

## Hosts with the WARM role {#warm}

Hosts with this role provide access to searchable snapshots stored in S3 warm storage. Hosts with the `WARM` role also store a cache of frequently used data segments.

This warm storage feature is at the [Preview stage](../../overview/concepts/launch-stages.md). To activate it, contact [support]({{ link-console-support }}).

Read more about searchable snapshots in the [relevant {{ OS }} guide]({{ os.docs }}/tuning-your-cluster/availability-and-recovery/snapshots/searchable_snapshot/).

## Hosts with the INGEST role {#ingest}

Hosts with this role preprocess data before saving it to an index. Dedicated hosts with the `INGEST` role can come in handy if you use resource-intensive data ingestion pipelines prior to uploading data into {{ OS }}. If the cluster contains no hosts with the `INGEST` role, it is hosts with the `DATA` role that perform this role.

Learn more about data ingestion pipelines in the [relevant {{ OS }} guide]({{ os.docs }}/ingest-pipelines/).

## Hosts with the DASHBOARDS role {#dashboards}

Hosts with this role run {{ OS }} Dashboards, a data visualization tool to use in such scenarios as real-time application monitoring, threat detection, incident management, or personalized search.

### Use cases {#examples-dashboards}

* [{#T}](../tutorials/saml-keycloak.md)
* [{#T}](../tutorials/trails-to-opensearch.md)
* [{#T}](../tutorials/migration-to-opensearch.md)
