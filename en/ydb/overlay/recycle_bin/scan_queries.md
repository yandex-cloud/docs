<!-- Refactored to concepts/scan_query + CLI article on scan query command -->

# Instructions for using Scan Queries

## Introduction

This article describes the *Scan Queries* streaming interface for data access.

## Destination

The main purpose of *Scan Queries* is to run analytical ad-hoc queries against databases. The result of query execution is a data stream.

You can also use the *Scan Queries* interface to make queries to [system tables](https://cloud.yandex.com/docs/ydb/troubleshooting/system_views).

This method of query execution is different in that:
* It uses snapshot data, producing a minimum effect on the OLTP transaction flow (nothing but taking a snapshot).
* Data streaming is used internally instead of the request-response model.
* Data spilling to disk can be used if needed.
* LLVM compilation is forced to all queries.
* The query result is a data stream.

Limitations of *Scan Queries*:
* Only read-only queries are supported.
* The query duration is limited to 5 minutes.
* Many operations (including sorting) are performed entirely in-memory, which may lead to resource shortage errors when running complex queries.
* Only one strategy is currently used for table joins: *MapJoin* (a.k.a. *Broadcast Join*), where the "right" table is converted to a map to be no more than several gigabytes in size.
* Prepared form is not supported.

{% note info %}

Despite the fact that *Scan Queries* obviously don't interfere with OLTP transactions, they still use common DB resources: CPU, memory, disk, and network. Therefore, running complex queries **may lead to resource hunger**, which will affect the performance of the entire DB.

{% endnote %}

## How do I use it

Like other types of queries, *Scan Queries* are available via Web UI, CLI, or SDK.

### Web UI

To launch a query over the *Scan Query* interface, you can use both the [YQL web interface](https://yql.yandex-team.ru) and the *YQL Kit* in the [YDB web interface](https://ydb.yandex-team.ru).

Make sure to add the pragma `PRAGMA Kikimr.ScanQuery = "true";` to the query.

{% note info %}

For queries executed over the Web UI, an implicit limit of 1000 rows is set.

If the query exceeds this limit, then only the first 1000 rows are output to the client, and a comment is shown in the interface.

```
Table data is truncated.
```

{% endnote %}

### YDB CLI

To run a query via *Scan Queries* in the YDB CLI, add the `-t scan` flag to the `{{ ydb-cli }} table exec` command.

You don't have to specify any additional pragmas.

```
$ {{ ydb-cli }} -e <endpoint> -d <database> table query execute -t scan -f query.sql
```

### SDK

#### C++ SDK

To run a query using *Scan Queries*, use 2 methods from the `Ydb::TTableClient` class.

```cpp
class TTableClient {
    ...
    TAsyncScanQueryPartIterator StreamExecuteScanQuery(const TString& query,
        const TStreamExecScanQuerySettings& settings = TStreamExecScanQuerySettings());

    TAsyncScanQueryPartIterator StreamExecuteScanQuery(const TString& query, const TParams& params,
        const TStreamExecScanQuerySettings& settings = TStreamExecScanQuerySettings());
    ...
};
```

These methods return an iterator to a part of the data stream. For a use example, see basic_example.
