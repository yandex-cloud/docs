---
title: '{{ ES }} host roles'
description: 'Each {{ ES }} cluster consists of one or more {{ ES }} hosts with different roles: data node or master node.'
keywords:
  - Elasticsearch host roles
  - Elasticsearch
  - Elasticsearch hosts
---

# Host roles

{% include [Elasticsearch-end-of-service](../../_includes/mdb/mes/note-end-of-service.md) %}

Each {{ mes-name }} cluster consists of one or more {{ ES }} hosts with different roles: _data node_ or _master node_.

## Dedicated hosts with the data node role {#data-node}

Hosts with this role store one or more indexes and handle search and analysis queries. To ensure index scalability and fault tolerance, configure [sharding and replication](scalability-and-resilience.md) for this index.

To simplify the processing of indexes and search queries, these hosts come with pre-configured [Kibana](https://www.elastic.co/kibana/features), which can be accessed from the web interface. For more information, see [Connecting to a cluster](../operations/cluster-connect.md).

{% note info %}

There should be at least one host with the _data node_ role in the cluster.

{% endnote %}

## Dedicated hosts with the Master node role {#master-node}

Hosts with this role monitor the state of the cluster and manage its configuration, ensuring the performance of all {{ ES }} components.

When using dedicated hosts with the _Master node_ role, there are three such hosts added to the cluster; you cannot change their number.

If no hosts with the _master node_ role are used, this role will be supported by the hosts with the _data node_ role. However, with dedicated hosts with the _master node_ role, the overall cluster reliability will be higher and the load on hosts with the _data node_ role will be smaller.