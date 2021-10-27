---
title: YQL. Frequently asked questions
keywords:
  - yql
  - faq yql
  - questions and answers yql
---

# Questions and answers about {{ ydb-short-name }}

{% if audience == "external" %}

## General questions {#common}

{% include notitle [common](faq/common.md) %}

## YQL {#yql}

{% include notitle [yql](faq/yql.md) %}

## Errors {#errors}

{% include notitle [errors](faq/errors.md) %}

## Serverless {#serverless}

{% include notitle [serverless](faq/serverless.md) %}

{% else %}

## General questions {#common}

#### How many records can be returned in a result set when making a single query to {{ ydb-short-name }}?

The results of read queries are limited to 1000 rows or 50 MB.

#### What limitations are imposed on full scan tables?

Each shard may return no more than 50 MB. For example, if filtering is enabled, shards are filtered by the predicate and more data can be read.

#### How do I use a JOIN effectively?

Only INDEX LOOKUP JOIN works effectively.

For a Join to be rewritten in INDEX LOOKUP JOIN, make sure to meet the following requirements:

* Use one of the following Join types: inner, full, left, left semi, or left only.
* The right part of a Join is a table and not the result of a subquery.
* The Join operation key is the prefix of the right table's primary key (PK).
* A selection in the left table should be relatively small.

#### What queries can be performed on a single table within a single transaction?

Transactions <q>cannot see</q> their own changes. Therefore, you can make any number of reads followed by any number of UPDATE ON/DELETE ON.

#### How do I get the number of updated rows in a transaction?

You can count the number of updated rows using a query:

```yql
$data = (
    SELECT
        Id,
        $x_new AS X,
        $rev + 1 AS Rev
    FROM Table
    WHERE Id = $id AND Rev = $rev
);

UPSERT INTO Table
SELECT * FROM $data;

SELECT COUNT(*) FROM $data;
```

#### What should I do if I frequently get the error <q>Transaction locks invalidated</q>?

If you get this error, repeat a transaction, as {{ ydb-short-name }} uses optimistic locking. If a large number of rows are scanned during reading and this error occurs frequently, split reads into parts.

#### Why does the error <q>Exceeded maximum allowed number of active transaction</q> occur?

The logic on the client side should try to keep transactions as short as possible.
No more than 10 active transactions are allowed per session. When starting a transaction, use either the commit flag for autocommit or an explicit commit/rollback.

#### When can I set a transaction's isolation level?

The isolation level is set for the entire transaction.

#### What is the computational complexity of a select count(*) query?

Q: There is a table with primary_key (puid, photo_id). Will the ```yql select count(*) where puid == my_puid``` run quickly?

A: O(number of rows with puid == my_puid)

#### Which is faster: String::StartsWith or LIKE 'something%'?

A specialized function is faster.

#### Does String::Substring copy the source string?

No, it doesn't.

#### Which is better?  Small and frequent or infrequent but long transactions?

Q: What is the best way to write? Small and frequent transactions (upsert 50-100 rows), 300 ms each, or long but infrequent transactions (upsert 1000-3000 rows), 5 sec each?  Transactions are not competing so there's no transaction lock invalidation.

A: It's better to use small transactions.

#### Examples of YQL queries for IN and prepare

https://st.yandex-team.ru/YDBREQUESTS-14

#### What's the right way to migrate a production table? If I run ALTER TABLE ADD COLUMN on a table with 4K records, it won't greatly affect the current queries, will it?

It won't, about 30 seconds if there is any load.

In other words: new transactions affecting the table will be rejected for about 30 seconds.

During the alter operation:

<main>: Error: Execution, code: 1060
    <main>: Error: Transaction rolled back., code: 2007
        <main>: Error: Kikimr cluster or one of its subsystems was unavailable., code: 2005
            <main>: Error: Error executing transaction (ProxyShardNotAvailable): One or more of affected datashards not available, request execution cancelled
                <main>: Error: Data shard errors: [SHARD_IS_BLOCKED] Can't propose tx. Shard is blocked.

#### How to run {{ ydb-short-name }} locally

https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/tools/ydb_recipe

## FAQ about the SDK for C++

#### What may cause the error <q>Status: OVERLOADED Error: Pending previous query completion</q>?

Q: When running two queries, I try to get a response from the future method of the second one. It returns: ```Status: OVERLOADED Why: <main>: Error: Pending previous query completion```

A: Sessions in the SDK are single-threaded. To run multiple queries at once, you need to create multiple sessions.

{% endif %}
