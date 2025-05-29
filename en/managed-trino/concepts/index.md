---
title: Resource relationships in {{ mtr-full-name }}
description: '{{ TR }} is a high-performance distributed SQL query engine. With {{ mtr-name }}, you can run queries to various data storages and work with data in various formats using the standard SQL syntax. The main entity {{ mtr-name }} operates is a cluster.'
---

# Resource relationships in {{ mtr-full-name }}

{{ TR }} is a high-performance distributed massively parallel query processing system. With {{ TR }}, you can run queries to various data storages and work with data in various formats using the standard SQL syntax.

{{ TR }} implements separated storage and compute layers. {{ TR }} works only with queries and their results. All data operations are delegated to the external data storage you are querying, so you do not need to upload data from the storage to {{ TR }} to run a query. This approach accelerates query processing and, in combination with the massively parallel architecture, simplifies {{ mtr-name }} cluster scaling for various needs.

## Cluster architecture {#cluster-architecture}

The main entity in {{ mtr-name }} is a cluster.

A {{ TR }} cluster consists of the _coordinator_ and _workers_.

### Coordinator {#coordinator}

The coordinator is the primary data processing node. It receives user queries, plans query execution, manages task distribution among workers, and processes task results they return.

The coordinator server runs a discovery service that monitors worker availability. If a worker becomes unavailable, the coordinator stops assigning new tasks to it.

A {{ TR }} cluster always has only one coordinator.

### Workers {#workers}

Workers are processing nodes. They handle coordinator queries, run data operations, and return results to the coordinator. When started, each worker registers itself with the discovery service running on the coordinator server. This way it becomes available for task assignment. From time to time, workers send availability signals to the discovery service. If the discovery service does not receive such a signal within the specified time, new tasks will not be assigned to that worker.

When [creating a cluster](../operations/cluster-create.md), you can either set a fixed number of workers (from 1 to 64) or autoscale the number of workers (between 0 and 64) based on workload.

### Catalog {#catalog}

The coordinator and workers can access data sources through _catalogs_.

A catalog is a set of parameters describing a connection to a data source. In a {{ mtr-name }} cluster, you can create one or more catalogs. {{ TR }} supports working with data from multiple catalogs within a single query.

Each catalog describes only one data source. The data source type is determined by the selected _connector_.

### Connector {#connector}

A _connector_ is an interface for accessing a specific type of data source. Connector provide data from the source as an abstract table which the workers can send queries to. This table supports the same workflow for all data sources regardless of what particular requirements they may have.

In {{ mtr-name }}, the following connectors are available:

{% include [connectors](../../_includes/managed-trino/connector-list.md) %}

## Running a query in a {{ TR }} cluster {#query-execution}

The user works with the {{ TR }} cluster via a client, e.g., the {{ TR }} CLI. The client sends queries to the coordinator and shows their results.

Running a query in a {{ TR }} cluster involves these stages:

1. The coordinator receives a query from the client as an SQL statement.

1. The coordinator plans query execution stages and converts it into a series of related tasks distributed among workers.

1. Workers run queries to data sources, process the incoming information, exchange intermediate task results, and submit the results of all tasks to the coordinator.

1. The coordinator collects task results from workers, generates the final result, and sends it to the client, which outputs the query result to the user.

Workers interact with each other and the coordinator via the REST API. Additionally, workers can exchange intermediate data through Exchange Manager, which servers as a temporary data storage. This way, if a worker fails, its active process may be completed on a different worker using the intermediate data from Exchange Manager.
