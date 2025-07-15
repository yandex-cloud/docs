---
title: Resource relationships in {{ mspqr-full-name }}
description: '{{ SPQR }} is a system for horizontal {{ PG }} scaling through sharding. A {{ SPQR }} cluster consists of shards, a router, and a coordinator.'
---

# Resource relationships in {{ mspqr-full-name }}

{% include [preview](../../_includes/note-service-preview.md) %}

{{ SPQR }} is a system for horizontal {{ PG }} scaling through sharding. Essentialy, these are multiple {{ PG }} clusters merged into a single {{ SPQR }} cluster.

A {{ mspqr-name }} cluster consists of _shards_, a _router_, and a _coordinator_ (which is optional). Routers and coordinators run on _hosts_, i.e., virtual machines with dedicated computing resources and reserved data storage.

## Shard {#shard}

A shard is a {{ mpg-name }} cluster located in the same [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) and [cloud network](../../vpc/concepts/network.md) as the {{ mspqr-name }} cluster.

There may be one or multiple shards. The maximum number of shards is unlimited and does not depend on the sharding type used in the cluster.

Each shard stores an independent data fragment. The data is distributed across shards based on a sharding key.

Queries are routed to a shard depending on the data it contains. A router is the entity that distributes queries among shards.

## Router {#router}

A router is the main component of a {{ mspqr-name }} cluster, responsible for routing queries.

A client connects to the router and sends queries over the {{ PG }} protocol. The router analyzes the query, redirects it to the shard that stores the relevant data, gets the query result, and returns it to the client.

Router uses sharding rules to find the relevant shard. If the cluster has a coordinator, it is responsible for providing the rules. If there is no coordinator, the rules are set manually for each router and stored in its RAM until it gets rebooted.

When creating a cluster, you can choose between standard and advanced sharding. If you choose standard sharding, the cluster will include `INFRA` hosts, which serve as both the router and coordinator. To ensure that such a cluster is fault-tolerant, we recommend creating at least three `INFRA` hosts in different availability zones. The maximum number of `INFRA` hosts is seven.

If you choose advanced sharding, dedicated `ROUTER` hosts will be provided for routers. The number of routers placed on such hosts is unlimited.

## Coordinator {#coordinator}

A coordinator is a component of a {{ mspqr-name }} cluster that stores sharding rules and balances loads on shards.

Its availability depends on the cluster’s sharding type:

* With standard sharding, a coordinator is a required component represented by an `INFRA` host. To ensure that such a cluster is fault-tolerant, we recommend creating at least three `INFRA` hosts in different availability zones. The maximum number of `INFRA` hosts is seven.

* With advanced sharding, a coordinator is an optional component represented by a `COORDINATOR` host. To ensure that such a cluster is fault-tolerant, we recommend creating three `COORDINATOR` hosts in different availability zones. The maximum number of `COORDINATOR` hosts is five.

Coordinators store sharding rules in a QDB database running on `INFRA` or `COORDINATOR` hosts. This database represents an [etcd](https://etcd.io) cluster where the [consensus algorithm](https://raft.github.io) approves changes in data.

Using a coordinator, you can create or edit sharding rules for all routers at the same time. If you change the rules on one of the coordinators, the other coordinators and routers will get this update.

