#### What types of data are available for sharding? {#available-data-types}

* Integers (`INT`, `BIGINT`).
* Strings `VARCHAR`.
* `UUID`.
* Composite keys.
* Hash functions: `CITY`, `MURMUR` (for integers only).

  {% note warning %}

  Custom hash functions are not supported.

  {% endnote %}

If you are missing any type of data, you can create an issue in the [project's Github repository](https://github.com/pg-sharding/spqr/issues).

#### What are the limits for a {{ mspqr-name }} cluster? {#cluster-limits}

The number of routers and shards in a {{ mspqr-name }} cluster is unlimited.

Learn more about [quotas and limits in {{ mspqr-name }}](../../managed-spqr/concepts/limits.md).

#### Are cross-shard JOINs supported?{#cross-shard-join-queries}

No. JOIN is only possible within a single shard. When working with linked data, use the same sharding keys for linked tables to keep the data on the same shard.

If you need cross-shard JOINs, we recommend using [{{ mgp-full-name }}](../../managed-greenplum/).

#### Are cross-shard queries supported? {#cross-shard-queries}

They are only supported for the following cases:

* Reference tables with the `/* __spqr__engine_v2: true */` virtual parameter.
* `COPY` with the `/* __spqr__allow_multishard: true */` virtual parameter.
* Transactions with DDL and the `/* __spqr__default_route_behaviour: ALLOW */` virtual parameter provided.
* Queries for which the `/* __spqr__scatter_query: true */` virtual parameter is explicitly specified.

You can set virtual parameters with comments in SQL or via `SET`.

#### What retry policy does {{ SPQR }} use? {#retry-policy}
The router does not retry user queries. The user must implement the retry policy on their own based on their business logic.

#### How does {{ SPQR }} manage connection limits? {#connection-limits}
The connection limit is set separately for each user in the `conn_limit` parameter.

#### Is there query deduplication? {#query-deduplication}

No. If the client disconnects and repeats the query, the router will process it as a new one.

#### Are DDL operations (e.g. ALTER TABLE, RENAME) allowed in transactions? {#ddl-operations}

Yes, if `/* __spqr__default_route_behaviour: ALLOW */` is enabled.

Depending on your needs, we recommend to use the following virtual parameter:

* With single-phase fixation: `/* __spqr__commit_strategy: 1pc */`.
* With two-phase fixation: `/* __spqr__commit_strategy: 2pc */`.

You can set virtual parameters with comments in SQL or via `SET`.
