---
title: '{{ CB }} is a modern, actively developed alternative to {{ GP }}'
description: Learn how {{ CB }} measures up to {{ GP }} as the best alternative DBMS.
---

# Why choose {{ CB }}

{{ CB }} is a {{ GP }} fork managed by Apache Software Foundation. {{ CB }} version 2.x is built on the modern PostgreSQL 14.x, while {{ GP }} is based on PostgreSQL 9.4 whose support was discontinued in February, 2020. The upcoming major Apache Cloudberry™ 3.x release will upgrade to PostgreSQL 16.

Migrating from {{ GP }} to {{ CB }} is straightforward: {{ CB }} is almost fully compatible with {{ GP }}, so you do not need to retrain your team or rewrite your applications. For the full list of incompatible changes, which are mostly minor and isolated, see [this article](./breaking-changes.md). These changes affect very few workflows.

## Benefits {{ CB }}

### Faster analytics

To a large extent, the speed of analytical database engines depends on their data storage format. {{ CB }} uses a hybrid data storage format called [PAX (Partition Attributes Across)](https://cloudberry.apache.org/docs/operate-with-data/pax-table-format/). It combines the convenience of row-oriented tables with the fast read speeds of column-oriented tables, automatically skips irrelevant sections, and supports modern compression codecs.

### Query optimization

{{ CB }} features native query optimization tools:

* [RuntimeFilter](https://cloudberry.apache.org/docs/performance/optimize-queries/use-runtimefilter-to-optimize-queries/): Filters out excessive tuples before JOIN operations using bloom filters.
* [Aggregation Pushdown](https://cloudberry.apache.org/docs/performance/optimize-queries/use-aggre-pushdown-to-speed-up-queries/): Performs aggregations closer to the data, reducing the amount of network-transmitted data.
* [Parallel query execution](https://cloudberry.apache.org/docs/performance/optimize-queries/parallel-query-execution/) while dynamically adjusting the number of workers.
* New [BRIN](https://cloudberry.apache.org/docs/operate-with-data/operate-with-db-objects/brin-indexes/) index type that supports the `multi-minmax` and `bloom` options.
* PostgreSQL 14 query optimizer, upgraded and improved.

### Near-real-time analytics and AI integration

* [Dynamic tables](https://cloudberry.apache.org/docs/performance/use-dynamic-tables/): Query results are updated on a schedule.
* [Incremental materialized views](https://cloudberry.apache.org/docs/performance/optimize-queries/use-incremental-materialized-view/): Only modified data is updated.
* [Automatic matrialized views (AQUMV)](https://cloudberry.apache.org/docs/performance/optimize-queries/use-auto-materialized-view-to-answer-queries/): Optimizer automatically substitutes tables with the relevant materialized views when generating a query plan.
* [Directory tables](https://cloudberry.apache.org/docs/advanced-analytics/directory-tables/): Manage unstructured data residing in a local or object storage directly via SQL.
* [MCP server](https://github.com/apache/cloudberry/tree/main/mcp-server): Manage your database using AI agents and LLM tools.

### Corporate security

* [Password policies based on profiles](https://cloudberry.apache.org/docs/security/set-password-profile), including lockouts after multiple failed login attempts.
* [Row level security](https://cloudberry.apache.org/docs/security/configure-row-level-security-policy/) to restrict access to specific rows without view-based workarounds.
* [SCRAM-SHA-256](https://cloudberry.apache.org/docs/security/protect-passwords/), channel binding, TCP/IP encryption with GSSAPI, and trusted extensions.

### Vendor-neutral governance model

* The project was developed in the Apache Software Foundation Incubator which guarantees vendor neutrality.
* Development decisions are taken by the Project Management Committee (PMC), which includes developers from various companies and countries.
* Active community and fast development.
