---
title: "What objects can be transferred"
description: "With {{ data-transfer-full-name }}, you can easily transfer table data, empty objects, and views."
---
# What objects can be transferred

The main objects transferred are tables and data schemas.

In addition, certain types of endpoints support a transfer of [empty objects](#features-common-processing-of-empty-objects) or [views](#features-common-processing-of-views).

## Processing empty objects {#features-common-processing-of-empty-objects}

You can only transfer non-empty tables and their data but not other schema elements (indexes, external keys, etc.) _between endpoints of different types_ (e.g., from {{ PG }} to {{ CH }}).
Auto incremental fields are also transferred, but `AUTO_INCREMENT` is not.

> For example, the following table

> ```sql
> CREATE TABLE `sometable` (
> `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT
> ```

> will be transferred as

> ```sql
> CREATE TABLE "sometable" (
> "id" int8 NOT NULL
> ```

Transfers _between same-type endpoints_ (such as from {{ PG }} to {{ PG }}) transfer empty objects as part of a schema.

## Processing `VIEW` objects {#features-common-processing-of-views}

In general, {{ data-transfer-full-name }} transfers `VIEW` objects (from databases where they may exist) with some restrictions:

* {{ dt-type-repl }} transfers do not replicate `VIEW` data changes.
* {{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (in the copy step) _between same-type endpoints_, such as from {{ PG }} to {{ PG }}, only transfer a `VIEW` as part of a schema. `VIEW` data (rows) are not transferred. Schema transfers are configured by the _Schema transfer_ setting and related settings available in some source endpoints.
* {{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (in the copy step) _between endpoints of different types_, such as from {{ PG }} to {{ CH }}, transfer `VIEW` objects as regular tables and not as regular views. This feature allows converting and exporting data to external databases and can be helpful when making regular transfers of the {{ dt-type-copy }} type.

Some sources may impose additional restrictions on transfers of `VIEW` and similar objects. For more information about how to work with views from particular sources, see [{{ data-transfer-full-name }} specifics for sources and targets](work-with-endpoints.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}