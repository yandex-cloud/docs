---
title: What objects can be transferred
description: '{{ data-transfer-full-name }} makes it easy to migrate table data, various objects, and views. The specific objects you can transfer may vary based on the transfer type and endpoints.'
---
# What objects can be transferred

Tables and data schemas are the main objects moved during a transfer. Some types of transfers and endpoints are subject to [limits on transferred objects](#non-transferable-objects). The specific objects you can transfer may vary based on the [transfer type](transfer-lifecycle.md#transfer-types) and endpoints.

Some endpoint types also support transferring [empty objects](#features-common-processing-of-empty-objects) or [views](#features-common-processing-of-views). Limitations also apply to [complex data types](#features-common-processing-complex-data-types).

## Non-transferable objects {#non-transferable-objects}

The list of non-transferable objects depends on the type of transfer and endpoints.

### Objects unsupported by all or some transfer types {#transfer-type-related}

* All transfers _between different endpoint types_, such as from {{ PG }} to {{ CH }}, only support non-empty tables. Other objects, including indexes, external keys, constraints, triggers, and other schema elements, are not transferred. Such transfers do not preserve the `AUTO_INCREMENT` attribute: columns are copied as standard numeric or integer types.
* Grants are never transferred, regardless of the transfer type.
* {{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (while in the {{ dt-status-copy }} status) between endpoints of different types transfer `VIEW` as ordinary tables.
* Data changes in views (`VIEW`) are not transferred during {{ dt-type-repl }} transfers.
* Array conversion, as well as the migration of complex and composite data types, is not guaranteed during transfers between different endpoint types. This data may fail to copy or may be copied incorrectly.
* During {{ dt-type-repl }} transfers, the replication of fields added to the schema after the cluster transitions to the {{ dt-status-repl }} status is not guaranteed.

### Objects unsupported for specific endpoint types {#endpoint-related}

##### **{{ PG }}** {#posgresql}

For transfers from a {{ PG }} endpoint to a target endpoint of a different type:
* `DOMAIN` and `large objects` are not transferred.
* Data from `MATERIALIZED VIEW` is not transferred.
* Tables containing generated columns, e.g., calculated columns or `GENERATED ... AS IDENTITY`, are not transferred.
* For {{ dt-type-repl }} and {{ dt-type-copy-repl }} transfers, tables without primary keys are not transferred if no `REPLICA IDENTITY` is specified for them.
* `FOREIGN TABLE` objects are treated and processed as views.
* When transferring a `VIEW` containing a `VOLATILE` function call, data consistency between that `VIEW` and other transferred objects is not guaranteed.
* Transfers of partitioned tables do not support selective migration of child tables.

For transfers between {{ PG }} endpoints:

* Schemas are not transferred (unlike the tables they contain).
* Objects from the `pg_catalog` and `information_schema` service schemas are not transferred.
* If specific tables are explicitly selected for migration in the source endpoint or transfer settings, user-defined data types from these tables are not transferred.
* {{ dt-type-repl }} and {{ dt-type-copy-repl }} transfers do not support the following objects:

  * Tables without primary keys are not transferred if no `REPLICA IDENTITY` is specified for them.
  * Tables and transactions with `DEFERRABLE` constraints.

* {{ dt-type-repl }} and {{ dt-type-copy-repl }} transfers from {{ PG }} version `14` or lower do not replicate transactions nested more than 1,024 times and containing replicable changes at each nesting level.

* For {{ dt-type-repl }} transfers:

  * Tables added to the source after switching to the {{ dt-status-repl }} status are not transferred.
  * For declaratively partitioned tables, any new partitions created on the source after the transfer transitions to the {{ dt-status-repl }} status are not transferred.
  * For declaratively partitioned tables, partitions created on the source after the transfer transitions to the {{ dt-status-repl }} status are not transferred.
  * For tables without primary keys, row changes (`UPDATE`, `DELETE`) are not replicated if no `REPLICA IDENTITY` is specified.

##### **{{ mgp-name}}/{{ GP }}** {#greenplum}

For transfers from a {{ mgp-name }} or {{ GP }} endpoint to an endpoint of a different type:

* Data from `MATERIALIZED VIEW` is not transferred.
* For transfers with parallel copy on, only `TABLE` objects are transferred; this excludes tables with the `DISTRIBUTED REPLICATED` allocation policy.
* `FOREIGN TABLE` or `EXTERNAL TABLE` objects are treated and processed as views.
* For transfers to {{ PG }}, the database schema, including any user-defined data types, is not transferred.

Transfers from a {{ GP }} or {{ mgp-name }} endpoint to a {{ GP }} or {{ mgp-name }} endpoint do not support the following objects:

* Functions.
* Sequences.
* External tables and views.
* Schemas, including user-defined data types.

##### **{{ CH }}** {#clickhouse}

Transfers from a {{ CH }} endpoint to an endpoint of a different type do not support the following objects:

* Dictionaries.
* Databases with a hyphen in their name.
* Tables containing columns of the following types:
  * `Int128`
  * `Int256`
  * `UInt128`
  * `UInt256`
  * `Bool`
  * `Date32`
  * `JSON`
  * `Array(Date)`
  * `Array(DateTime)`
  * `Array(DateTime64)`
  * `Map(,)`

When transferring data from a {{ CH }} endpoint to a different target type, or from another source type to a {{ CH }} endpoint, date values that fall outside the ranges supported by the [Datetime](https://clickhouse.com/docs/sql-reference/data-types/datetime) and [DateTime64](https://clickhouse.com/docs/sql-reference/data-types/datetime64) fields are not transferred. 

For transfers between {{ CH }} endpoints:

* Tables with unsupported engines, e.g., those outside the `MergeTree` family, as well as views associated with such tables are not transferred.
* `VIEW` objects are not transferred during {{ dt-type-copy }} transfers.
* Transfer of `Distributed` tables is not guaranteed. We recommend transferring only the underlying tables and creating `Distributed` tables on the target manually.
* Transfer of `MATERIALIZED VIEW` objects is not guaranteed.

##### **{{ mmg-name }}/{{ MG }}** {#mongodb}

Transfers from a {{ mmg-name }} or {{ MG }} endpoint to an endpoint of a different type do not support the following objects:

* `Timeseries` collections.
* Collections containing data of different types in the `id` field.
* Binary data of the `unsigned_byte(2) Binary` and `unsigned_byte(3) UUID` types.

For transfers to a {{ mmg-name }} or {{ MG }} endpoint from a different endpoint type, indexes are not transferred.

{{ dt-type-repl }} transfers between {{ mmg-name }} and/or {{ MG }} endpoints do not support the following objects:

* Objects within a collection that exceed 16 MB in size.
* Collections if their key size exceeds 5 MB.

##### **{{ MY }}** {#mysql}

For transfers from a {{ MY }} endpoint to a target endpoint of a different type:

* Tables without primary keys and unique indexes are not transferred.
* `DECIMAL` fields are not transferred.
* For the `DATETIME` data type, time zones are not transferred. All data is assigned the time zone specified in the source endpoint’s **Time zone for connecting to the database** setting.
* For transfers to {{ CH }}, the `TIME` type data is transferred as strings, while time zones are not transferred.

Transfers to a {{ MY }} endpoint from an endpoint of a different type do not support the following objects:

* Schema names.
* Tables with primary keys represented by strings of unlimited length.
* Values larger than 2^31 if the target table has a data type with the `unsigned smallint` property.
* Values larger than 2^63 if the target table has a data type with the `unsigned bigint` property.

##### **{{ OS }}** {#opensearch}

Transfers to an {{ OS }} endpoint from an endpoint of a different type do not support objects with keys that are invalid for {{ OS }}. Keys are considered invalid if they are empty or:
* Consisting only of whitespace.
* Consisting only of periods.
* Beginning or ending with a period.
* Containing multiple periods in a row.
* Containing periods separated by spaces.

##### **Other endpoint types** {#other}

* If the target supports adding new data only to the end of an existing structure, updates to existing rows are not replicated during {{ dt-type-repl }} transfers. This applies to targets such as {{ OS }}, {{ ES }}, {{ KF }}, and S3 storages, including {{ objstorage-full-name }}.

* When using {{ objstorage-name }} as the source, file delete operations are not transferred.

* When using Oracle as the source, `VIEW` and `MATERIALIZED VIEW` are not transferred.

* If {{ ytsaurus-name }} is the target, and dynamic tables are used, tables without primary keys are not transferred.

## Object processing highlights {#objects-processing}

### Processing empty objects {#features-common-processing-of-empty-objects}

You can only transfer non-empty tables and their data but not other schema elements (indexes, external keys, etc.) _between endpoints of different types_ (e.g., from {{ PG }} to {{ CH }}).
Auto incremental fields are also transferred, but `AUTO_INCREMENT` is not.

> For example, the following table
>
> ```sql
> CREATE TABLE `sometable`  (
> `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT
> ```
>
> will be transferred as
>
> ```sql
> CREATE TABLE "sometable" (
> "id" int8 NOT NULL
> ```

Transfers _between same-type endpoints_ (such as from {{ PG }} to {{ PG }}) transfer empty objects as part of a schema.

### Processing a `VIEW` {#features-common-processing-of-views}

In general, {{ data-transfer-full-name }} transfers `VIEW` (from databases where such objects can exist) with some limitations:

* {{ dt-type-repl }} transfers do not replicate changes made to `VIEW` data.
* During {{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (at the copy stage) between endpoints of the same type, views are migrated only as part of a schema. The data (rows) within a `VIEW` is not transferred. Schema transfers are governed by the _Schema transfer_ setting and related settings available in some source endpoints.
* {{ dt-type-copy }} and {{ dt-type-copy-repl }} transfers (at the copy stage) between endpoints of different types migrate views as regular tables (not as views). This feature allows converting and exporting data to external databases and can be helpful when making regular transfers of the {{ dt-type-copy }} type.

Some sources may impose additional restrictions on transfers of `VIEW` and similar objects. For more information on how to work with views from particular sources, see [{{ data-transfer-full-name }} workflow for sources and targets](work-with-endpoints.md).

### Processing complex data types {#features-common-processing-complex-data-types}

In transfers _between endpoints of different types_ (e.g., from {{ PG }} to {{ CH }}), it is not recommended to transfer data of complex types (e.g., arrays of numbers). {{ data-transfer-name }} does not support the conversion of such data, because each DBMS has limitations and rules of its own for data types. When using complex types, the transfer may not work correctly.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
