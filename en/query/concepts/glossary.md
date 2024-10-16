---
title: Which terms and definitions are used in {{ yq-full-name }}
description: In this tutorial, you will learn about the terms and definitions used in {{ yq-name }}.
---

# Terms and definitions in {{ yq-name }}

## Connection {#connection}

A _connection_ is a set of parameters required for connecting {{ yq-full-name }} to a data source and target. For example, if a file from {{ objstorage-full-name }} is used as a data source, a connection contains the name of a bucket and its authorization parameters.

{{ yq-full-name }} supports the following connection types:

* {{ objstorage-short-name }}, which is a connection to a {{ objstorage-full-name }} [bucket](../../storage/concepts/bucket.md); it can be both a data source and a target.
* {{ mpg-name }}, which is a connection to {{ mpg-name }}; it can only be a data source.
* {{ mch-name }}, which is a connection to {{ mch-name }}; it can only be a data source.
* {{ yds-short-name }}, which is a connection to a {{ ydb-full-name }} [database](../../ydb/concepts/resources.md#database) where a {{ yds-full-name }} [stream](../../data-streams/concepts/glossary.md#stream-concepts) is located; it can be both a data source and a target.
* {{ monitoring-short-name }}, which is a connection to {{ monitoring-full-name }}; it can only be a data target.

## Binding {#binding}

The same YQL query can be run on the data available through different types of [connections](#connection), such as bucket or stream data. In this case, for each connection, it may be handy to create a _binding_, which is a resource containing information about a connection, data [format](../sources-and-sinks/formats.md), and [data schema](#schema).

You can only create data bindings for file-based data sources, i.e., to {{ objstorage-short-name }}.

## Query {#query}

A _query_ is an expression that is written in [YQL](https://ydb.tech/docs/en/yql/reference/syntax/), an SQL dialect, and used for data operations. A query consists of YQL statements and information about a [connection](#connection) or [binding](#binding). When using a connection, you need to specify a [data schema](#schema).

Using {{ yq-full-name }} queries, you can perform [batch](batch-processing.md) and [streaming](./stream-processing.md) data processing.

## Information about query runs {#jobs}

You can run the same [query](#query) multiple times. The following information is saved for each query run:

* Query execution status.
* Query execution start date and time.
* Query execution duration.
* Name of the user who ran the query.
* Query execution metrics.

The results of the last query run are saved and stored for 24 hours.

## Data schema {#schema}

_Data schema_ is a list of source data fields and types that have no explicit schema, such as {{ objstorage-short-name }} buckets or {{ yds-short-name }} streams. A schema should describe all fields to use in a query. If a query accesses data using a [connection](#connection), specify the schema in the request body. If you use a [binding](#binding), specify the data schema in its properties.

When working with the {{ mch-name }} or {{ mpg-name }} sources, you cannot specify the schema explicitly since it is automatically extracted from the DBMS's.

## Checkpoint {#checkpoint}

Streaming analysis systems handle infinite data streams that do not have any beginning or end. To avoid processing all data in a stream from the beginning every time, {{ yq-full-name }} remembers offsets in processed data when a query is rerun. If the processing is paused and then restarted, {{ yq-full-name }} rewinds the data stream to the saved offset and resumes processing data from that point.

Checkpoints contain information about a streaming query, including offsets in data streams.

If you add instructions to access new streaming sources of data to the text of a query, checkpoints will not contain information about offsets within data streams. As a result, some data may be read from existing streams starting from the last checkpoint, while other data may be read once new messages appear in new data streams.

{% note info %}

Query execution method settings (processing data starting from a checkpoint or processing anew) are specified when [running a query](../operations/query.md#run).

{% endnote %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
