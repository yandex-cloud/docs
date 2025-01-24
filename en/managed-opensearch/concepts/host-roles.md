---
title: Host roles in {{ mos-full-name }}
description: In this article, you will learn about host roles in {{ mos-name }}.
---

# Host roles in {{ mos-name }}

Each {{ mos-name }} cluster consists of one or more host groups of the `{{ OS }}` and `Dashboards` (optional) types:

* An `{{ OS }}` host group may contain hosts with the [DATA](#data) or [MANAGER](#manager) roles. If a cluster has a single `{{ OS }}` group, its hosts will have both roles.

* A `Dashboards` host group may only contain hosts with the [DASHBOARDS](#dashboards) role.

## Hosts with the DATA role {#data}

Hosts with this role store one or more indexes and handle search, write, and analysis queries. To ensure index scalability and fault tolerance, configure [sharding and replication](scalability-and-resilience.md) for this index.

{% note info %}

There should be at least one host with the `DATA` role in the cluster. A single-host cluster is not fault tolerant.

{% endnote %}

For fault tolerance reasons, you cannot create a cluster that only has two hosts with the `DATA` role. To make your cluster fault-tolerant, add a host group with the `MANAGER` role.

## Hosts with the MANAGER role {#manager}

Hosts with this role monitor the state of the cluster and manage its configuration, ensuring the performance of all {{ OS }} components.

If you are using hosts with the `MANAGER` role, a group containing three such hosts will be added to the cluster.

If no hosts with the `MANAGER` role are used, this role will be supported by hosts with the `DATA` role. However, having dedicated hosts with the `MANAGER` role allows you to increase the overall cluster reliability and reduce the load on hosts with the `DATA` role.

## Hosts with the DASHBOARDS role {#dashboards}

Hosts with this role run {{ OS }} Dashboards, a data visualization tool to use in such scenarios as real-time application monitoring, threat detection, incident management, or personalized search.
