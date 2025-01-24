---
title: '{{ GP }} Command Center'
description: In this article, you will learn about the {{ GP }} Command Center, the concepts of current state, state history, consumption history, query keys, and query IDs.
---

# {{ GP }} Command Center

_{{ GP }} Command Center_ is a tool that allows you to:

* Monitor query metrics and execution plans.
* Terminate individual sessions or queries.
* View execution history for completed queries.
* Analyze database queries.
* Perform database tuning.

{% note info %}

The Command Center is available in clusters with {{ GP }} version 6.25 or higher.

{% endnote %}

The Command Center allows you to analyze the following session and query data:

* [Current state](#current-state)
* [State history](#states-history)
* [Resource consumption history](#consumption-history)

The Command Center also assigns query [keys](#statement-key) and [IDs](#statement-id) to identify and group queries.

For more information on how to use the Command Center, see [{#T}](../operations/command-center.md).

## Current state {#current-state}

A _current state_ is a real-time state of sessions or queries in a cluster. The **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** tab shows the users currently connected to the DB, queries being run, and amount of resources being consumed.

> Let's assume that some users are performing resource-intensive computations within multiple sessions. These computations are still in progress by the time you need to run your regular workload.
>
> On the **{{ ui-key.yacloud.greenplum.cluster.perf-diag.title_current-state }}** tab, you can sort the sessions by **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}** to see which ones are using the most CPU. You can also find and [terminate](../operations/command-center.md#terminate-session) the most resource-intensive sessions, freeing up resources for other operations. For more information on how to diagnose such cases, see [{#T}](../operations/command-center.md#current-session).

## State history {#states-history}

The _state history_ shows snapshots of sessions or queries at specific points in the past. The state history allows you to determine which sessions or queries caused abnormal cluster performance.

> For example, in the morning you observe that your overnight [ETL jobs](https://en.wikipedia.org/wiki/Extract,_transform,_load) took longer to complete than they normally did. Analyzing the state history helps you gain useful insights into the overnight sessions: what queries were run and how long they took, who was blocking the operations, and when a given query started executing.

## Consumption history {#consumption-history}

The _consumption history_ shows information about {{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-cpu-time }}, {{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-peak-memory }}, and other resource consumption statistics at specific points in the past for completed queries.

> Let's assume that in the [state history](#states-history) you observe an unusually high CPU load over a certain period of time. You can refer to the consumption history to find out which queries had caused the spike. For an example of such an analysis, see [{#T}](../operations/command-center.md#past-statements).

The consumption history may contain a large number of completed queries. These queries are grouped together, and their collective statistics are available.

A group of queries is essentially a list which displays information about each query. The information displayed about a query depends on its duration:

* More than one hour: Full query information is saved. This includes details, such as the start time of the query, the user who ran the query, and the amount of resources consumed at each {{ GP }} segment.
* Less than one hour: The information is aggregated the same way as in the [pg_stat_statements]({{ pg.docs.org }}/current/pgstatstatements.html) {{ PG }} view. You can learn only total consumption at a selected time point.

You can group queries by one or multiple parameters:

* User running the query.
* Database used.
* [Query ID](#statement-id).
* [Resource group](resource-groups.md).

You can also sort groups of queries by various parameters, e.g., {{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-cpu-time }}. This allows you to find the group you need faster.

## Query keys {#statement-key}

A _key_ is a unique attribute assigned to a query when it is executed. Every time you run the same query, it receives a new key. This allows you to differentiate between multiple runs of the same query based on time.

Key template:

```text
<session_ID>/<timestamp>/<query_number>
```

Where:

* `session_ID`: Session when the query was executed.
* `timestamp`: {{ GP }} segment start time.
* `query_number`: Query sequence number within the session.

> Key example: `7247590/1701763297/5`.

## Query IDs {#statement-id}

An _ID_ is a non-unique hash value generated from the text of the query. An ID is calculated based on query duration. If it took more than one hour to complete the query:

1. All the numeric and string literals are removed from the query.
1. The rest of the query is used to calculate the hash. This hash value serves as the ID.

If it took less than one hour to complete the query:

1. The Command Center selects several other queries that can be grouped together with this particular query.

   Sometimes the same SQL query is executed repeatedly. In this case, the Command Center gathers information about multiple queries which differ only in the execution time.

1. All the numeric and string literals are removed from the query.
1. Then, minor differences between the queries within the group are identified and removed.
1. The rest of the query is used to calculate the hash. This hash value serves as the ID.

As a result, queries that ran for less than one hour and can form a single group receive the same ID. This ID is used to group queries.

> ID example: `1f9c40bf`.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
