---
title: Resource relationships in {{ mtr-full-name }}
description: '{{ TR }} is a high-performance distributed SQL query engine. {{ mtr-name }} enables users to run SQL queries on data in various formats and storage systems. The main entity in {{ mtr-name }} is a cluster.'
---

# Resource relationships in {{ mtr-full-name }}

{{ TR }} is a high-performance distributed massively parallel query processing system. With {{ TR }}, you can run queries to data in various formats and systems using the standard SQL syntax.

{{ TR }} implements separated storage and compute layers. {{ TR }} works only with queries and their results and does not provide data storage. All data operations are delegated to the data storage you are querying. As a result, you do not need to pre-load data from your storage into {{ TR }} to run a query. This means queries are processed faster, and {{ TR }} can work without an additional data storage. Together with the massively parallel architecture, this approach makes it easier to scale a {{ mtr-name }} cluster for various tasks.

## Cluster architecture {#cluster-architecture}

The main entity in {{ mtr-name }} is a cluster.

A {{ TR }} cluster consists of the _coordinator_ and _workers_.

### Coordinator {#coordinator}

The coordinator is the primary data processing node. It receives user queries, plans query execution, manages task distribution among workers, and processes task results they return.

The coordinator server runs a discovery service that monitors worker availability. If a worker becomes unavailable, the coordinator stops assigning new tasks to it.

A {{ TR }} cluster always has only one coordinator.

### Workers {#workers}

Workers are processing nodes. They handle coordinator queries, run data operations, and return results to the coordinator. When started, each worker registers itself with the discovery service running on the coordinator server. This way it becomes available for task assignment. From time to time, workers send availability signals to the discovery service. If the discovery service does not receive such a signal within the specified time, new tasks will not be assigned to that worker.

When [creating a cluster](../operations/cluster-create.md), you can either set a fixed number of workers (from 1 to 64) or configure automatic scaling of workers (between 0 and 64) based on workload.

### Catalog {#catalog}

The coordinator and workers can access data sources through _catalogs_.

A catalog is a set of parameters describing a connection to a data source. In a {{ mtr-name }} cluster, you can create one or more catalogs. {{ TR }} supports working with data from multiple catalogs within a single query.

Each catalog describes only one data source. The data source type is determined by the selected _connector_.

### Connector {#connector}

A _connector_ is an interface for accessing a specific type of data source. Connector provide data from the source as an abstract table which the workers can send queries to. This abstraction allows you to work uniformly with all data sources regardless of their specific requirements.

In {{ mtr-name }}, the following connectors are available:

{% include [connectors](../../_includes/managed-trino/connector-list.md) %}

## Running a query in a {{ TR }} cluster {#query-execution}

Users interact with the {{ TR }} cluster by means of the coordinator, to which a user connects via a client such as the {{ TR }} CLI. The client is used to send queries to {{ TR }} and display their results. Learn more about [connecting to a {{ TR }} cluster](../operations/connect.md).

Running a query in a {{ TR }} cluster involves these stages:

1. The coordinator receives a query from the client as an SQL statement.

1. The coordinator plans query execution stages and converts it into a series of related tasks distributed among workers. 

1. The workers run queries to data sources, process the received information, exchange intermediate task results, and send final results to the coordinator. 

1. The coordinator collects task results from workers, generates the final result, and sends it to the client, which outputs the query result to the user.

Workers interact with each other and the coordinator via the REST API. Additionally, workers can exchange intermediate results through Exchange Manager, which servers as a temporary data storage. This way, if a worker fails, its active process may be completed on a different worker using the intermediate data from Exchange Manager.
