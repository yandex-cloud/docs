---
title: "What objects can be transferred"
description: "With {{ data-transfer-full-name }}, you can easily transfer table data, empty objects, and views."
---
# What objects can be transferred

The main objects transferred are tables and data schemas.

In addition, certain types of endpoints support a transfer of [empty objects](#features-common-processing-of-empty-objects) or [views](#features-common-processing-of-views).

## Processing empty objects {#features-common-processing-of-empty-objects}

Transfers _between endpoints of different types_ (such as from {{ PG }} to {{ CH }}) only move non-empty objects. For example, tables (in relational DBs) that don't contain tuples or contain zero number of fields aren't transferred.

Transfers _between same-type endpoints_ (such as from {{ PG }} to {{ PG }}) move empty objects as part of a schema.

## Processing `VIEWs` {#features-common-processing-of-views}

In general, {{ data-transfer-full-name }} transfers `VIEWs` (from databases where these objects may exist) with some restrictions:

* {{ dt-type-repl }} transfers don't replicate `VIEW` data changes.
* {{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (in the copy step) _between same-type endpoints_, such as from {{ PG }} to {{ PG }}, only move a `VIEW` as part of a schema. `VIEW` data (strings) aren't transferred. Schema transfers are configured by the "Schema transfer" setting and related settings available in some source endpoints.
* {{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (in the copy step) _between endpoints of different types_, such as from {{ PG }} to {{ CH }}, move `VIEW` as regular tables and not as regular views. This feature allows converting and exporting data to external databases and can be helpful when making regular transfers of the {{ dt-type-copy }} type.

Some sources may impose additional restrictions on transfers of `VIEW` and similar objects. For more information about how to work with views from particular sources, see [{{ data-transfer-full-name }} specifics for sources and targets](work-with-endpoints.md).