---
title: Queries in {{ ycdr-full-name }}
description: Queries in {{ ycdr-name }} use KQL to find and analyze security events.
---

# Queries

{% include [preview-by-request](../../_includes/note-preview-by-request.md) %}

To search for events, {{ ycdr-full-name }} uses a subset of the [Kusto Query Language (KQL)](../kql-reference.md). KQL enables you to filter, aggregate, and analyze security events for the past 90 days.

## KQL syntax {#kql-syntax}

A KQL query has the following components:

* **Data source**: Event tables, e.g., `Events`.
* **Filtering operators**: `where` to filer events by conditions.
* **Aggregation operators**: `summarize` for counting and grouping.
* **Sorting operators**: `sort` for result sorting.

For more information about the KQL syntax, see [{#T}](../kql-reference.md).

Request example:

```kql
Events
| project event_class, ['time']
| limit 1
```

This query selects events from the `Events` table, displays the `event_class` and `time` fields, and limits the result to one entry.


## Query history {#query-history}

{{ ycdr-name }} stores execution history for each query. The history contains:

* Date and time of running the query.
* Query text.
* Time period.
* Execution status.
* Number of results.

From the history, you can:

* Rerun a query with the same parameters.
* Copy query text for editing.
* Share a link to the query with your team.

## Query optimization {#optimization}

To use queries efficiently, follow these best practices:

* **Use filters**: Use `where` clauses to make queries faster.
* **Define a precise time range**: Avoid querying data for a broader time window than needed.
* **Aggregate data**: Use `summarize` operators to group and count events instead of retrieving the full output.
* **Limit results**: Use the `limit` operator to limit the number of returned rows.

#### See also {#see-also}

* [{#T}](investigations.md)
* [{#T}](../operations/queries/index.md)
* [{#T}](../quickstart.md)
* [{#T}](../kql-reference.md)