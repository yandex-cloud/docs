---
title: What objects can be transferred
description: '{{ data-transfer-full-name }} makes it easy to migrate table data, empty objects, and views.'
---
# What objects can be transferred

The main objects transferred are tables and data schemas.

In addition, certain types of endpoints support a transfer of [empty objects](#features-common-processing-of-empty-objects) or [views](#features-common-processing-of-views). There are also limits on [complex data types](#features-common-processing-complex-data-types).

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

## Processing a `VIEW` {#features-common-processing-of-views}

In general, {{ data-transfer-full-name }} transfers `VIEW` (from databases where such objects can exist) with some limitations:

* The {{ dt-type-repl }} transfers do not replicate changes made to `VIEW` data.
* The {{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (at the copy stage) _between same-type endpoints_, e.g., from {{ PG }} to {{ PG }}, transfer `VIEW` only a as part of a schema. The data (rows) in `VIEW` is not transferred. Schema transfers are governed by the _Schema transfer_ setting and related settings available in some source endpoints.
* The {{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (at the copy stage) _between endpoints of different types_, e.g., from {{ PG }} to {{ CH }}, transfer `VIEW` as regular tables (not as views). This feature allows converting and exporting data to external databases and can be helpful when making regular transfers of the {{ dt-type-copy }} type.

Some sources may impose additional restrictions on transfers of `VIEW` and similar objects. For more information on how to work with views from particular sources, see [{{ data-transfer-full-name }} workflow for sources and targets](work-with-endpoints.md).

## Processing complex data types {#features-common-processing-complex-data-types}

In transfers _between endpoints of different types_ (e.g., from {{ PG }} to {{ CH }}), it is not recommended to transfer data of complex types (e.g., arrays of numbers). {{ data-transfer-name }} does not support the conversion of such data, because each DBMS has limitations and rules of its own for data types. When using complex types, the transfer may not work correctly.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
