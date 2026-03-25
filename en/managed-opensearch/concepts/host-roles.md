---
title: Host roles in {{ mos-full-name }}
description: In this article, you will learn about host roles in {{ mos-name }}.
---

# Host roles in {{ mos-name }}

Each {{ mos-name }} cluster consists of one or more host groups of the `{{ OS }}` and `Dashboards` (optional) types:

* An `{{ OS }}` host group may contain hosts with the [DATA](#data) or [MANAGER](#manager) roles.
  
  The cluster must contain hosts with both roles. If a cluster has a single `{{ OS }}` group, its hosts will have both roles.

* A `Dashboards` host group may only contain hosts with the [DASHBOARDS](#dashboards) role.

## Hosts with the DATA role {#data}

Hosts with this role store one or more indexes and handle search, write, and analysis queries.


For a cluster to be highly available and covered by a [service level agreement (SLA)](https://yandex.com/legal/cloud_sla_mdb/), it must have two or more hosts with the `DATA` role.


[More on high-availability of clusters](../../managed-opensearch/concepts/high-availability.md).

### Use cases {#examples-data}

* [{#T}](../tutorials/migration-to-opensearch.md)
* [{#T}](../tutorials/opensearch-index-policy.md)
* [{#T}](../tutorials/opensearch-to-object-storage.md)
* [{#T}](../tutorials/opensearch-yandex-lemmer.md)

## Hosts with the MANAGER role {#manager}

Hosts with this role monitor the state of the cluster and manage its configuration, ensuring the performance of all {{ OS }} components.

If you are using hosts with the `MANAGER` role, a group containing three such hosts will be added to the cluster.

If no hosts with the `MANAGER` role are used, make sure to assign this role to the hosts with the `DATA` role. However, having dedicated hosts with the `MANAGER` role allows you to increase the overall cluster reliability and reduce the load on hosts with the `DATA` role.

## Hosts with the DASHBOARDS role {#dashboards}

Hosts with this role run {{ OS }} Dashboards, a data visualization tool to use in such scenarios as real-time application monitoring, threat detection, incident management, or personalized search.

### Use cases {#examples-dashboards}

* [{#T}](../tutorials/saml-keycloak.md)
* [{#T}](../tutorials/trails-to-opensearch.md)
* [{#T}](../tutorials/migration-to-opensearch.md)
