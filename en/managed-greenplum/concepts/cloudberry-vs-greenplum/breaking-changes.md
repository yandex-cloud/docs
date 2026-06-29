---
title: Breaking changes in {{ CB }} as compared to {{ GP }} in {{ mgp-full-name }}
description: In this article, you will learn about breaking changes in {{ CB }} as compared to {{ GP }} in {{ mgp-full-name }}.
---

# Breaking changes in {{ CB }} as compared to {{ GP }} in {{ mgp-full-name }}

{{ CB }} is different from {{ GP }} in a number of aspects. Many differences come from the {{ PG }} version change, since {{ GP }} is based on version 9.4.26 and {{ CB }}, on version 14.4. There are also differences in system-specific features.

This article covers the key differences and helps you get ready for migrating from {{ GP }} to {{ CB }} in advance.

## Upgrade challenges {#update-limitations}

### Breaking change in the internal `jsonb` type format {#internal-jsonb}

In {{ PG }} versions above 9.4, changes to the internal `jsonb` type broke backward compatibility.

**How to detect**

Find all tables that use `jsonb`:

  ```sql
  SELECT n.nspname, c.relname, a.attname
  FROM pg_attribute a
      JOIN pg_class c ON c.oid = a.attrelid
      JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE a.atttypid = 'jsonb'::regtype
      AND a.attnum > 0;
  ```

**How to fix**

Recreate the affected columns, replacing `jsonb` with `json` or `text`. Migrate the data before dropping the column with `jsonb` as required.

### Removal of the `abstime`, `reltime`, `tinterval`, and `unknown` types {#type-deletion}

Starting from {{ PG }} 10, `unknown` became a pseudo-type.
Starting from {{ PG }} 12, `abstime`, `reltime`, and `tinterval` were removed.

In {{ GP }}, the following queries run without errors:

```sql
CREATE TABLE example_abstime (x abstime);

CREATE TABLE example_reltime (x reltime);

CREATE TABLE example_tinterval (x tinterval);

CREATE TABLE example_unknown (x unknown);
WARNING:  column "x" has type "unknown"
```

In {{ CB }}, the same queries return an error:

```sql
CREATE TABLE example_abstime (x abstime);
ERROR:  type "abstime" does not exist

CREATE TABLE example_reltime (x reltime);
ERROR:  type "reltime" does not exist

CREATE TABLE example_tinterval (x tinterval);
ERROR:  type "tinterval" does not exist

CREATE TABLE example_unknown (x unknown);
ERROR:  column "x" has pseudo-type unknown
```

**How to detect**

All data types have been completely removed and are no longer available for use in:

  * SQL queries
  * Table definitions
  * PL/pgSQL functions


To find tables that use removed types, you can run the following query:

  ```sql
  SELECT n.nspname, c.relname, a.attname, t.typname
  FROM pg_attribute a
      JOIN pg_class c ON c.oid = a.attrelid
      JOIN pg_namespace n ON n.oid = c.relnamespace
      JOIN pg_type t ON t.oid = a.atttypid
  WHERE t.typname IN ('abstime', 'reltime', 'tinterval', '_abstime', '_reltime', '_tinterval', 'unknown')
      AND a.attnum > 0
      AND NOT a.attisdropped;
  ```

You should also separately check user-defined types, views, and PL/pgSQL functions.

**How to fix**

Replace every occurrence of the deprecated type with its current equivalent:

  * `abstime` → `timestamp` / `timestamptz`
  * `reltime` → `interval`
  * `tinterval` → `timestamp`/`timestamptz`, or `text`
  * `unknown` → best matching type depending on the data, or `text`

### No `pg_` prefix in role names {#pg-prefix}

Starting from {{ PG }} 9.6, the `pg_` prefix is reserved for system roles and users and is no longer available.

In {{ GP }}, the following query runs without errors:

```sql
CREATE ROLE pg_example;
```

Running this query in {{ CB }} returns an error:

```sql
CREATE ROLE pg_example;
ERROR:  role name "pg_example" is reserved
DETAIL:  Role names starting with "pg_" are reserved.
```

**How to detect**

  ```sql
  SELECT rolname FROM pg_catalog.pg_roles WHERE rolname ~ '^pg_';
  ```

**How to fix**

  ```sql
  ALTER ROLE pg_example RENAME TO another_example;
  ```
You can fix the issue before the upgrade.

 
### Removal of the `tsearch2` and `timetravel` extensions {#extenstion-deletion}

{{ CB }} no longer includes the following extensions:

- `tsearch2`
- `timetravel`

**How to detect**

Check whether these extensions are installed and used in your codebase:

  ```sql
  SELECT extname, extversion
  FROM pg_extension
  WHERE extname IN ('tsearch2', 'timetravel');
  ```

**How to fix**

Stop using the removed extensions.

### Removed support for tables created with `WITH OIDS` {#table-deletion}

Starting with {{ PG }} 12, support for tables.
created with `WITH OIDS` was discontinued.

In {{ GP }}, the following query runs without errors:

```sql
CREATE TABLE example (value text) with oids;
```

Running this query in {{ CB }} returns an error:

```sql
CREATE TABLE example (value text) with oids;
ERROR:  syntax error at or near "oids"
```

**How to detect**

You can find all tables defined with `WITH OIDS` by running the following query:

  ```sql
  SELECT n.nspname, c.relname
  FROM pg_class c
      JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE c.relhasoids
      AND n.nspname NOT IN ('pg_catalog', 'information_schema');
  ```

**How to fix**

Run `ALTER TABLE ... SET WITHOUT OIDS;` for each table found. If the OID was used as a business key, add a `bigserial` column (or any other appropriate column).

 
## Function and operator behavior changes {#function-change}

### Changes in set-returning functions' behavior {#set-function-change}

Starting from {{ PG }} 10, `Set Returning Functions`, such as `generate_series`, `unnest`, `regexp_split_to_table`, `json_each`, and `json_array_elements`, behave differently in the `SELECT` clause.

The following example demonstrates the difference.

{{ GP }}:

```sql
SELECT 'example' AS value, generate_series(1, 3), generate_series(1, 2);
  value  | generate_series | generate_series
---------+-----------------+-----------------
 example |               1 |               1
 example |               2 |               2
 example |               3 |               1
 example |               1 |               2
 example |               2 |               1
 example |               3 |               2
(6 rows)
```

{{ CB }}:

```sql
SELECT 'example' AS value, generate_series(1, 3), generate_series(1, 2);
  value  | generate_series | generate_series
---------+-----------------+-----------------
 example |               1 |               1
 example |               2 |               2
 example |               3 |
(3 rows)
```

**How to detect**

Check whether the application codebase uses `Set Returning Functions` in the `SELECT` clause.

**How to fix**

Replace `Set Returning Functions` calls in the `SELECT` clause with the equivalent `CROSS JOIN LATERAL` construct.

### `extract()` now returns a `numeric`-type value {#extract-type}

Starting from {{ PG }} 14, the `extract()` function returns a value of the `numeric` type, not `double precision`.

Example for {{ GP }}:

```sql
SELECT pg_typeof(extract(epoch FROM now()));
     pg_typeof
------------------
 double precision
```

Example for {{ CB }}:

```sql
SELECT pg_typeof(extract(epoch FROM now()));
 pg_typeof
-----------
  numeric
```

If the application expects `double precision`, it may behave unpredictably.

**How to detect**

Check whether the application codebase uses the `extract()` function.

**How to fix**

Modify the application or affected queries to include an explicit type cast using `::double precision`.

### Fixed format handling in the `to_number()` function {#to-number}

In {{ GP }}, the `to_number()` function was stripping extra characters:

```sql
SELECT to_number('1234', '9,999');
 to_number
-----------
       134
(1 row)
```

In {{ CB }}, this issue has been fixed:

```sql
SELECT to_number('1234', '9,999');
 to_number
-----------
      1234
(1 row)
```

**How to detect**

Check whether the application codebase uses the `to_number()` function that strips extra characters.

**How to fix**

Adapt the application to the new correct behavior of the `to_number()` function.

### Change in the evaluation order for some operators {#operator-order-change}

{{ CB }}, as compared to {{ GP }}, uses the updated evaluation order for `<=`, `>=`, `<>`, `IS`, `NOT BETWEEN`, and other compound operators.

For example, running the following query in {{ GP }} returns an error:

```sql
SELECT 1 <> 2 IS TRUE;
ERROR:  argument of IS TRUE must be type boolean, not type integer
```

In {{ CB }}, this query works as expected:

```sql
SELECT 1 <> 2 IS TRUE;
?column?
----------
t
(1 row)
```

**How to detect**

Check the application codebase for expressions with an ambiguous operator evaluation order.

**How to fix**

Use parentheses to explicitly define the operator evaluation order.

### Changes in `SIMILAR TO` with `ESCAPE NULL` {#similar-to-escape-null}

Starting from {{ PG }} 13, the `SIMILAR TO ... ESCAPE NULL` construct behaves differently.

Example for {{ GP }}:

```sql
SELECT 'abc' SIMILAR TO 'abc' ESCAPE NULL;
?column?
----------
t
(1 row)
```

Example for {{ CB }}:

```sql
SELECT 'abc' SIMILAR TO 'abc' ESCAPE NULL;
?column?
----------

(1 row)
```

**How to detect**

Check whether the application codebase uses the `ESCAPE NULL` construct.

**How to fix**

Replace `ESCAPE NULL` with `ESCAPE <some value>`.

## Syntax changes and removed constructs {#syntax}

### Requirement for an explicit `ROW()` in `UPDATE` statements with row constructors {#row-constructor}

Starting from {{ PG }} 10, updating a single column via a `ROW` constructor requires explicit use of the `ROW` keyword.

In {{ GP }}, the following query runs without errors:

```sql
CREATE TABLE example (value text);

INSERT INTO example (value) VALUES ('a');

-- this query
UPDATE example SET (value) = (value || '_updated');
```

Running this query in {{ CB }} returns an error:

```sql
CREATE TABLE example (value text);

INSERT INTO example (value) VALUES ('a');

-- this query
UPDATE example SET (value) = (value || '_updated');
ERROR:  source for a multiple-column UPDATE item must be a sub-SELECT or ROW() expression
```

**How to detect**

Check whether the application codebase uses a `ROW` constructor for a single column.

**How to fix**

Modify the affected queries so that they either do not use a `ROW` constructor, e.g., `UPDATE ... SET col = expr`, or explicitly specify the `ROW` keyword: `UPDATE ... SET (col) = ROW(expr)`.

### No support for statement-level triggers {#unsupported-triggers}

As opposed to {{ GP }}, {{ CB }} does not support `statement-level triggers`.

The following queries run correctly in {{ GP }}:

```sql
CREATE TABLE example (
    id bigserial,
    value text
) DISTRIBUTED BY (id);

CREATE OR REPLACE FUNCTION example_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER example_trigger
    AFTER INSERT OR UPDATE ON example
    FOR EACH STATEMENT
    EXECUTE PROCEDURE example_trigger_func();
```

Still, they do not work for {{ CB }}:

```sql
CREATE TABLE example (
    id bigserial,
    value text
) DISTRIBUTED BY (id);

CREATE OR REPLACE FUNCTION example_trigger_func()
RETURNS TRIGGER AS $$
BEGIN
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER example_trigger
    AFTER INSERT OR UPDATE ON example
    FOR EACH STATEMENT
    EXECUTE PROCEDURE example_trigger_func();

ERROR:  Triggers for statements are not yet supported
```

**How to detect**

You can find all `statement-level triggers` by running the following query:

  ```sql
  SELECT n.nspname, c.relname, tgname
  FROM pg_trigger t
      JOIN pg_class c ON t.tgrelid = c.oid
      JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE tgtype & 1 = 0 AND NOT tgisinternal;
  ```

**How to fix**

Avoid `statement-level triggers` by moving the logic to the application layer or using `row-level triggers`.

### Functions with `EXECUTE ON` must return sets (`SETOF`) {#execute-on-return-setof}

In {{ CB }}, functions with the `EXECUTE ON ALL SEGMENTS`/`COORDINATOR`/`INITPLAN` attributes now must return `SETOF`.

Here is a valid example for {{ GP }}:

```sql
CREATE OR REPLACE FUNCTION example_func()
RETURNS integer
AS $$
BEGIN
    RETURN 42;
END;
$$ LANGUAGE plpgsql
EXECUTE ON ALL SEGMENTS;
```

It no longer works in {{ CB }}:

```sql
CREATE OR REPLACE FUNCTION example_func()
RETURNS integer
AS $$
BEGIN
    RETURN 42;
END;
$$ LANGUAGE plpgsql
EXECUTE ON ALL SEGMENTS;

ERROR:  EXECUTE ON ALL SEGMENTS is only supported for set-returning functions
```

**How to detect**

You can find functions with the `EXECUTE ON ALL SEGMENTS`/`COORDINATOR`/`INITPLAN` attributes that do not return `SETOF` by running the following query:

  ```sql
  SELECT n.nspname, p.proname
  FROM pg_proc p
      JOIN pg_language l ON l.oid = p.prolang
      JOIN pg_type t ON t.oid = p.prorettype
      JOIN pg_namespace n ON n.oid = p.pronamespace
  WHERE NOT proretset
      AND proexeclocation IN ('s', 'm', 'i')
      AND l.lanname NOT IN ('internal')
      AND t.typname NOT IN ('record');
  ```

**How to fix**

Recreate the affected functions with `RETURNS SETOF ...` and `RETURN NEXT`.

### Removed support for postfix operators {#postfix-operator-deletion}

Starting from {{ PG }} 14, postfix operators, both system-defined and user-defined, are no longer supported.

In {{ GP }}, the following query runs without errors:

```sql
SELECT 5! AS factorial;
 factorial
-----------
       120
```

Running this query in {{ CB }} returns an error:

```sql
SELECT 5! AS factorial;
ERROR:  syntax error at or near "AS"
LINE 1: SELECT 5! AS factorial;
```

**How to detect**

{{ GP }} only uses one single postfix operator, `!`. However, user-defined operators are allowed as well. To get the full list of postfix operators, run the following query:

  ```sql
  SELECT o.oid, n.nspname, o.oprname, o.oid < 16384 AS is_system
  FROM pg_operator o
      JOIN pg_namespace n ON o.oprnamespace = n.oid
  WHERE o.oprright = 0;
  ```

**How to fix**

* Replace `!` with an explicit call of the `factorial(...)` function.
* Replace user-defined postfix operators with prefix operators or explicit calls to the relevant functions.

## Partitioning changes {#partitioning-changes}

### Requirement to include all partitioning keys in unique indexes {#partition-key-in-unique-index}

As opposed to {{ GP }}, a unique index in {{ CB }} must include **all** `statement-level triggers`.

Here is an example of a query that runs correctly in {{ GP }}:

```sql
CREATE TABLE sales (
    id int NOT NULL,
    region text,
    amount decimal(10, 2)
)
    DISTRIBUTED BY (id)
    PARTITION BY LIST (region)
    (
        VALUES ('Asia'),
        VALUES ('Europe')
    );

INSERT INTO sales (id, region, amount)
VALUES
    (1, 'Asia', 100.00),
    (1, 'Europe', 150.00),
    (2, 'Asia', 200.00);

CREATE UNIQUE INDEX sales_id_idx ON sales (id);
```

In {{ CB }}, the same query returns an error:

```sql
CREATE TABLE sales (
    id int NOT NULL,
    region text,
    amount decimal(10, 2)
)
    DISTRIBUTED BY (id)
    PARTITION BY LIST (region)
    (
        VALUES ('Asia'),
        VALUES ('Europe')
    );

INSERT INTO sales (id, region, amount)
VALUES
    (1, 'Asia', 100.00),
    (1, 'Europe', 150.00),
    (2, 'Asia', 200.00);

CREATE UNIQUE INDEX sales_id_idx ON sales (id);
ERROR:  unique constraint on partitioned table must include all partitioning columns
DETAIL:  UNIQUE constraint on table "sales" lacks column "region" which is part of the partition key.
```

**How to detect**

You can find all unique indexes that do not include **all** `partition keys` by running the following query:

  ```sql
  WITH partitions AS (
  SELECT DISTINCT n.nspname, c.relname, c.oid, p.paratts
  FROM pg_partition p
      JOIN pg_class c ON p.parrelid = c.oid
      JOIN pg_namespace n ON n.oid = c.relnamespace
  )
  SELECT p.nspname, p.relname, ir.relname AS indexname
  FROM pg_index i
      JOIN partitions p ON p.oid = i.indrelid
      JOIN pg_class ir ON ir.oid = i.indexrelid
  WHERE (i.indisunique OR i.indisprimary)
      AND NOT (p.paratts <@ i.indkey);
  ```

**How to fix**

Recreate the indexes found so that they include `partition keys`.

### Limitation on multi-column list partitioning {#list-partitioning-limit}

In {{ CB }}, multi-column `list partitioning` is implemented via `subpartitioning`, since the standard syntax assumes a single column or expression at each level.

This limitation is due to the fact that multi-column list partitioning, such as `PARTITION BY LIST (col1, col2)`, often prevents the use of the GPORCA optimizer.

The following example works for {{ GP }}:

```sql
CREATE TABLE example (a int, b int, c int)
    PARTITION BY LIST (b, c)
    (
        DEFAULT PARTITION other
    );
```

Still, it does not work for {{ CB }}:

```sql
CREATE TABLE example (a int, b int, c int)
    PARTITION BY LIST (b, c)
    (
        DEFAULT PARTITION other
    );
ERROR:  cannot use "list" partition strategy with more than one column
```

**How to detect**

You can find tables with multi-column list partitioning by running the following query:

  ```sql
  SELECT n.nspname, c.relname
  FROM pg_partition p
      JOIN pg_class c ON p.parrelid = c.oid
      JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE parkind = 'l'
      AND parnatts > 1;
  ```

**How to fix**

In {{ CB }}, use `subpartitioning`:

  ```sql
  CREATE TABLE example (a int, b int, c int)
  PARTITION BY LIST (b)
      SUBPARTITION BY LIST (c)
      SUBPARTITION TEMPLATE (
          DEFAULT SUBPARTITION other_c
      )
      (
          DEFAULT PARTITION other
      );
  ```

### Removed support for `FOR (RANK(...))` in partition DDLs {#for-rank-deletion}

{{ CB }} does not support the `FOR (RANK(...))` construct when working with partitions.

Here is a valid example for {{ GP }}:

```sql
CREATE TABLE sales (
    id int,
    date date,
    amount decimal(10, 2)
)
WITH (appendoptimized = true, compresstype = zstd, compresslevel = 1)
DISTRIBUTED BY (id)
PARTITION BY RANGE (date) (
    START ('2026-01-01') END ('2027-01-01') EVERY (INTERVAL '1 month')
);

ALTER TABLE sales
    ALTER PARTITION FOR (RANK(2))
    TRUNCATE PARTITION FOR (RANK(2));
```

Still, it does not work for {{ CB }}:

```sql
CREATE TABLE sales (
    id int,
    date date,
    amount decimal(10, 2)
)
WITH (appendoptimized = true, compresstype = zstd, compresslevel = 1)
DISTRIBUTED BY (id)
PARTITION BY RANGE (date) (
    START ('2026-01-01') END ('2027-01-01') EVERY (INTERVAL '1 month')
);

ALTER TABLE sales
    ALTER PARTITION FOR (RANK(2))
    TRUNCATE PARTITION FOR (RANK(2));
ERROR:  addressing partition by RANK is no longer supported
HINT:  Use partition name or FOR (<partition key value>) instead.
```

**How to detect**

Check whether the application codebase or scripts use the `FOR (RANK(...))` construct.

**How to fix**

Replace `FOR (RANK(...))` with `FOR (VALUE ...)` or `FOR VALUES`.

### Changes in storage parameter inheritance for AO tables {#ao-tables}

If an AO parameter is not explicitly specified for a partition, the inheritance behavior differs:

* {{ GP }} uses the default value.
* {{ CB }} inherits the parameter from the parent table.

The following query works for {{ GP }}:

```sql
CREATE TABLE sales
(
    id int,
    date date,
    region text,
    amount decimal(10, 2)
)
    WITH (appendoptimized = true, compresstype = zstd, compresslevel = 1)
    DISTRIBUTED BY (id)
    PARTITION BY LIST (region)
        (
        PARTITION asia VALUES ('Asia')
            WITH (appendoptimized = true, compresslevel = 0),
        PARTITION europe VALUES ('Europe')
        );
```

Still, it does not work for {{ CB }}:

```sql
CREATE TABLE sales
(
    id int,
    date date,
    region text,
    amount decimal(10, 2)
)
    WITH (appendoptimized = true, compresstype = zstd, compresslevel = 1)
    DISTRIBUTED BY (id)
    PARTITION BY LIST (region)
        (
        PARTITION asia VALUES ('Asia')
            WITH (appendoptimized = true, compresslevel = 0),
        PARTITION europe VALUES ('Europe')
        );
ERROR:  compresstype "zstd" can't be used with compresslevel 0
```

**How to detect**

You can find partitions created without explicit options by running the following query:

  ```sql
  SELECT
      schemaname,
      tablename,
      partitionschemaname,
      partitiontablename,
      par.reloptions AS parent_options,
      c.reloptions AS child_options,
      po AS parent_option
  FROM pg_partitions p
      JOIN pg_class par ON par.oid = format('%s.%s', schemaname, tablename)::regclass
      JOIN pg_class c ON c.oid = format('%s.%s', partitionschemaname, partitiontablename)::regclass
      JOIN unnest(par.reloptions) po ON TRUE
      LEFT JOIN unnest(c.reloptions) co ON split_part(po, '=', 1) = split_part(co, '=', 1)
  WHERE co IS NULL;
  ```

**How to fix**

Create a copy of the affected partition with explicitly specified options, transfer the data to it, and replace the original partition with the updated one.

### Limitations on using `EXCLUSIVE`/`INCLUSIVE` bounds with `float`/`numeric`/`text` types {#exclusive-inclusive-limit}

As opposed to {{ GP }}, `START EXCLUSIVE`/`END INCLUSIVE` constructs in {{ CB }} only work for data types with the `+` operator, e.g., `integer` and `timestamp`, but not for `float`, `numeric`, or `text`.

Here is a valid example for {{ GP }}:

```sql
CREATE TABLE sales
(
    id int,
    date date,
    amount decimal(10, 2)
)
    WITH (appendoptimized = true)
    DISTRIBUTED BY (id)
    PARTITION BY RANGE (amount)
        (
        START (0) EXCLUSIVE
            END (1000)
            EVERY (250)
        );
```

Still, it does not work for {{ CB }}:

```sql
CREATE TABLE sales
(
    id int,
    date date,
    amount decimal(10, 2)
)
    WITH (appendoptimized = true)
    DISTRIBUTED BY (id)
    PARTITION BY RANGE (amount)
        (
        START (0) EXCLUSIVE
            END (1000)
            EVERY (250)
        );
ERROR:  START EXCLUSIVE not supported for partition key data type: numeric
HINT:  Specify an inclusive START value and remove the EXCLUSIVE keyword
```

**How to detect**

You can find tables that use `START EXCLUSIVE`/`END INCLUSIVE` with unsupported types by running the following query:

  ```sql
  SELECT n.nspname, c.relname, t.typname, pr.parchildrelid::regclass
  FROM pg_partition p
      JOIN pg_partition_rule pr ON p.oid = pr.paroid
      JOIN pg_class c ON p.parrelid = c.oid
      JOIN pg_namespace n ON n.oid = c.relnamespace
      JOIN pg_attribute a ON a.attrelid = c.oid AND a.attnum = ANY(p.paratts)
      JOIN pg_type t ON t.oid = a.atttypid
  WHERE t.typname IN ('text', 'float8', 'float4', 'numeric')
      AND (NOT pr.parrangestartincl OR pr.parrangeendincl);
  ```

**How to fix**

Recreate the affected tables without `EXCLUSIVE`/`INCLUSIVE` for these data types.

### Changes in the partitioning hierarchy {#pg-partition-tree}

In {{ GP }}, `immediate child` partitions have `pg_partition.parlevel = 0`. In {{ CB }}, immediate child partitions have `pg_partition_tree().level = 1`. {{ CB }} does not support the `pg_partition` view, so use the `pg_partition_tree()` function instead.

This change may break queries relying on partition-level information.

**How to detect**

Check whether the application codebase or scripts use partition levels.

**How to fix**

Adapt the application codebase and scripts to align with the changes in partition levels and the removal of the `pg_partition` view. Use the `pg_partition_tree()` function or `pg_partitioned_table` view instead of `pg_partition`.

### Moved partitioning constraints from `pg_constraint` {#move-patition-pg-constraint}

In {{ GP }}, partition bounds are shown as `CHECK CONSTRAINT`s in the `pg_constraint` system view.

In {{ CB }}, partition bounds are no longer `CHECK CONSTRAINT`s and are not shown in `pg_constraint`. You can now get similar information from `gp_toolkit.gp_partitions`.

**How to detect**

Check whether the application codebase or scripts use `pg_constraint` for working with partitioning constraints.

**How to fix**

Use the `gp_toolkit.gp_partitions` view instead of `pg_constraint` when working with partitioning constraints.

## Changes in the system catalog and metadata {#metadata-change}

### Removal and renaming of columns in system catalog views and tables {#columns}

When migrating to {{ CB }} (along with upgrades of the {{ PG }} and {{ GP }} versions), the following columns in system catalog views and tables were removed or renamed:

| Old column                                                             | New column                                                       |
|----------------------------------------------------------------------------|---------------------------------------------------------------------|
| `pg_class.relhasoids`                                                      | Removed                                                             |
| `pg_class.relhaspkey`                                                      | `EXISTS (SELECT FROM pg_index WHERE indrelid=... AND indisprimary)` |
| `pg_class.relstorage`                                                      | `pg_class.relam`                                                    |
| `pg_proc.proisagg`                                                         | `pg_proc.prokind = 'a'`                                             |
| `pg_proc.proiswindow`                                                      | `pg_proc.prokind = 'w'`                                             |
| `pg_proc.protransform`                                                     | `pg_proc.prosupport`                                                |
| `pg_attrdef.adsrc`                                                         | `pg_get_expr(adbin, adrelid)`                                       |
| `pg_constraint.consrc`                                                     | `pg_get_constraintdef(oid)`                                         |
| `pg_stat_activity.waiting`                                                 | `wait_event_type`, `wait_event`                                     |
| `pg_am.*` (dozens of columns)                                                | The access method API has been significantly reworked. No direct equivalent is available.    |
| `gp_distributed_log.distributed_id`, `gp_distributed_xacts.distributed_id` | Removed                                                             |
| `gp_stat_replication.*_location`                                           | Renamed to `*_lsn`                                             |
| `information_schema.routines.result_cast_character_set_name`               | Renamed to `result_cast_char_set_name`                         |

**How to detect**

Check whether the application codebase uses any removed or renamed columns.

**How to fix**

Modify the application codebase accordingly.

### Removal of system tables and views {#system-table-deletion}

As opposed to {{ GP }}, {{ CB }} no longer includes the following system tables and views:

* `pg_catalog.pg_partition`
* `pg_catalog.pg_partition_columns`
* `pg_catalog.pg_partition_encoding`
* `pg_catalog.pg_partition_rule`
* `pg_catalog.pg_partitions`
* `pg_catalog.pg_partition_templates`
* `pg_catalog.pg_stat_partition_operations`

**How to detect**

Check whether the application codebase uses any removed system tables and views.

**How to fix**

Modify the application codebase accordingly.
 
To work with partitioned tables in {{ CB }}, use the `pg_partitioned_table` view and the `pg_partition_tree()`, `pg_partition_ancestors()`, and `pg_partition_root()` functions.

### Removal and renaming of system functions {#sysmtem-functions}

As opposed to {{ GP }}, {{ CB }} no longer includes the following system functions:

* `pg_get_partition_def`, `pg_get_partition_rule_def`, `pg_get_partition_template_def`.
* `gp_elog`, `gp_fault_inject`, `gp_update_ao_master_stats`.

Functions matching the `pg_*_xlog*` pattern have been renamed to follow the `pg_*_wal*` pattern, e.g., `pg_switch_xlog()` → `pg_switch_wal()`.
Some functions have been removed.

**How to detect**

Check whether the application codebase uses any removed or renamed system functions.

**How to fix**

Modify the application codebase accordingly.

### Changes in the display of sequence metadata {#seq-name}

Starting from {{ PG }} 10, sequence metadata is now displayed differently.
`SELECT * FROM <seq_name>` queries now return only `last_value`, `log_cnt`, and `is_called`. Other properties are available via `pg_sequence` or `pg_sequences`.

Example for {{ GP }}:

```sql
CREATE SEQUENCE example_seq
    START WITH 100
    INCREMENT BY 1;

SELECT * FROM example_seq;
 sequence_name    | last_value | start_value | increment_by |      max_value      | min_value | cache_value | log_cnt | is_cycled | is_called
------------------+------------+-------------+--------------+---------------------+-----------+-------------+---------+-----------+-----------
 example_seq      |        100 |         100 |            1 | 9223372036854775807 |         1 |           1 |       0 | f         | f
```

Example for {{ CB }}:

```sql
CREATE SEQUENCE example_seq
    START WITH 100
    INCREMENT BY 1;

SELECT * FROM example_seq;
 last_value | log_cnt | is_called
------------+---------+-----------
        100 |       0 | f

SELECT * FROM pg_sequence WHERE seqrelid = 'example_seq'::regclass;
 seqrelid | seqtypid | seqstart | seqincrement |       seqmax        | seqmin | seqcache | seqcycle
----------+----------+----------+--------------+---------------------+--------+----------+----------
    17186 |       20 |      100 |            1 | 9223372036854775807 |      1 |       20 | f

SELECT * FROM pg_sequences WHERE sequencename = 'example_seq';
 schemaname | sequencename    | sequenceowner | data_type | start_value | min_value |      max_value      | increment_by | cycle | cache_size | last_value
------------+-----------------+---------------+-----------+-------------+-----------+---------------------+--------------+-------+------------+------------
 public     | example_seq     | user1         | bigint    |         100 |         1 | 9223372036854775807 |            1 | f     |         20 |
```

**How to detect**

Check whether the application codebase uses `SELECT * FROM <seq_name>` queries with fields other than `last_value`, `log_cnt`, or `is_called`.

**How to fix**

Modify the application codebase accordingly, using `pg_sequence` or `pg_sequences`.

### Changes in the internal representation of external tables {#external-tables}

In {{ CB }},`EXTERNAL TABLES` are implemented as `FOREIGN TABLES`, which leads to the following differences compared to {{ GP }}:

* The `pg_tables` system view no longer displays external tables.
* `pg_class.relkind` for external tables is now set to `'f'` rather than `'r'`.
* The `pg_exttable` system table is now a view.
* `EXPLAIN` now outputs `Foreign Scan` instead of `External Scan`.

**How to detect**

Check whether the application codebase or scripts use external table metadata.

You can get the list of external tables by running the following query:

  ```sql
  SELECT n.nspname, c.relname, c.relkind, e.urilocation, e.execlocation, e.fmttype, e.fmtopts
  FROM pg_exttable e
      JOIN pg_class c ON c.oid = e.reloid
      JOIN pg_namespace n ON n.oid = c.relnamespace;
  ```

**How to fix**

Modify the application codebase and scripts accordingly.

### `gp_toolkit` is now implemented as an extension {#gp-toolkit}

As opposed to {{ GP }}, {{ CB }} provides the `gp_toolkit` schema as an extension.
Nothing changes in terms of installation: when you create a database, `gp_toolkit` is automatically enabled.

The following views are no longer available:

* `gp_toolkit.gp_size_of_partition_and_indexes_disk`
* `gp_toolkit.__gp_user_data_tables`

The signatures of the following functions have been modified:

* `gp_toolkit.__gp_aoseg*`
* `gp_toolkit.__gp_aocsseg*`
* `gp_dist_wait_status`
* `gp_execution_segment`
* `gp_request_fts_probe_scan`
* `gp_tablespace_segment_location`

The following columns have been removed from existing views:

* `gp_toolkit.gp_locks_on_resqueue.lorwaiting`
* `gp_toolkit.gp_resgroup_config.cpu_rate_limit`
* `gp_toolkit.gp_resgroup_config.memory_auditor`
* `gp_toolkit.gp_resgroup_config.memory_shared_quota`
* `gp_toolkit.gp_resgroup_config.memory_spill_ratio`
* `gp_toolkit.gp_resgroup_status.cpu_usage`
* `gp_toolkit.gp_resgroup_status.memory_usage`
* `gp_toolkit.gp_resgroup_status_per_host.cpu`
* `gp_toolkit.gp_resgroup_status_per_host.memory_available`
* `gp_toolkit.gp_resgroup_status_per_host.memory_quota_available`
* `gp_toolkit.gp_resgroup_status_per_host.memory_quota_used`
* `gp_toolkit.gp_resgroup_status_per_host.memory_shared_available`
* `gp_toolkit.gp_resgroup_status_per_host.memory_shared_used`
* `gp_toolkit.gp_resgroup_status_per_host.memory_used`
* `gp_toolkit.gp_resgroup_status_per_host.rsgname`
* `gp_toolkit.gp_resgroup_status_per_segment.cpu`
* `gp_toolkit.gp_resgroup_status_per_segment.hostname`
* `gp_toolkit.gp_resgroup_status_per_segment.memory_available`
* `gp_toolkit.gp_resgroup_status_per_segment.memory_quota_available`
* `gp_toolkit.gp_resgroup_status_per_segment.memory_quota_used`
* `gp_toolkit.gp_resgroup_status_per_segment.memory_shared_available`
* `gp_toolkit.gp_resgroup_status_per_segment.memory_shared_used`
* `gp_toolkit.gp_resgroup_status_per_segment.memory_used`
* `gp_toolkit.gp_resgroup_status_per_segment.rsgname`
* `gp_toolkit.gp_resgroup_status.rsgname`
* `gp_toolkit.__gp_user_tables.autrelstorage`

**How to detect**

Check whether the application codebase or scripts use modified or removed objects.

**How to fix**

Modify the application codebase and scripts to remove all references to removed objects and account for changes to existing ones.

## Configuration and resource management changes {#config-updates}

### Removal of configuration parameters {#config-params}

As opposed to {{ GP }}, {{ CB }} no longer includes the following configuration parameters:

* `wal_keep_segments` (renamed to `wal_keep_size`)
* `memory_spill_ratio`
* `gp_resource_group_memory_limit`
* `gp_resource_group_enable_recalculate_query_mem`
* `gp_resource_group_cpu_ceiling_enforcement`
* `gp_enable_gpperfmon`
* `gp_gpperfmon_send_interval`
* `gpperfmon_log_alert_level`
* `gpperfmon_port`
* `gp_log_resqueue_priority_sleep_time`
* `dev_opt_unsafe_truncate_in_subtransaction`
* `gp_add_column_inherits_table_setting`
* `gp_allow_rename_relation_without_lock`
* `gp_count_host_segments_using_address`
* `gp_eager_agg_distinct_pruning`
* `gp_eager_one_phase_agg`
* `gp_eager_preunique`
* `gp_enable_exchange_default_partition`
* `gp_enable_mk_sort`
* `gp_enable_motion_mk_sort`
* `gp_enable_sort_distinct`
* `gp_ignore_window_exclude`
* `gp_indexcheck_vacuum`
* `gp_partitioning_dynamic_selection_log`
* `gp_safefswritesize`
* `gp_use_synchronize_seqscans_catalog_vacuum_full`
* `optimizer_analyze_enable_merge_of_leaf_stats`
* `optimizer_enable_dml_triggers`
* `optimizer_enable_partial_index`
* `optimizer_prune_unused_columns`

**How to detect**

Check whether the application codebase uses any of the above configuration parameters.

**How to fix**

Modify the application codebase to remove all references to removed configuration parameters.

### Changes in the valid values for the `password_encryption` parameter {#password_encryption}

Starting from {{ PG }} 10, the `password_encryption` parameter uses a different data type and supports different values.

In {{ GP }}, the parameter type and valid values are as follows:

```sql
SELECT vartype, enumvals FROM pg_settings WHERE name = 'password_encryption';
 vartype | enumvals
---------+----------
 bool    |
(1 row)
```

In {{ CB }}, the parameter type and valid values are as follows:

```sql
SELECT vartype, enumvals FROM pg_settings WHERE name = 'password_encryption';
 vartype |      enumvals
---------+---------------------
 enum    | {md5,scram-sha-256}
(1 row)
```
**How to detect**

Check whether the application codebase uses the `password_encryption` parameter and update it accordingly.

**How to fix**

Replace the `password_encryption` value with `md5` wherever applicable. `scram-sha-256` is a valid value as well, but its support in the current service version is limited.

You can only fix the issue after the upgrade.

### Default parameter value changes {#default-parameters}

Compared to{{ GP }}, {{ CB }} uses different default values for the following parameters:

| Argument                       |    {{ GP }} |           {{ CB }} |
|--------------------------------|------------:|---------------------:|
| `wal_level`                    | `archive` | `replica` |
| `autovacuum_vacuum_cost_delay` | `20ms` | `2ms` |
| `checkpoint_completion_target` | 0.5 | 0.9 |
| `extra_float_digits` | 0 | 1 |
| `gp_interconnect_address_type` | `wildcard` | `unicast` |
| `autovacuum` | `off` | `on` for `template0` |
| `optimizer_enable_orderedagg`  |       `off` |                 `on` |
| `vacuum_cost_page_miss`        |          10 |                    2 |

**How to detect**

Most parameters are system-level and only have an indirect effect. `extra_float_digits` is an exception and may affect query results.

**How to fix**

Wherever the new `extra_float_digits` value affects query execution, explicitly set `extra_float_digits = 0` at the session or transaction level.

### Possible changes in query plans {#query-plan}

{{ CB }} introduces numerous changes and improvements to the GPORCA optimizer that may affect query plans. Queries remain logically correct, but their execution may change.

Points to keep in mind:

* There are new parameters affecting query plan generation:

  * `enable_partitionwise_aggregate`
  * `enable_partitionwise_join`
  * `enable_parallel`
  * `enable_parallel_dedup_semi_join`
  * `enable_parallel_hash`
  * `enable_parallel_append`
  * `enable_parallel_dedup_semi_reverse_join`
  * `enable_parallel_semi_join`
  * `jit`
  * `jit_above_cost`
  * `jit_dump_bitcode`
  * `jit_expressions`
  * `jit_inline_above_cost`
  * `jit_optimize_above_cost`
  * `jit_tuple_deforming`

* GPORCA does not support `multi-level partitioned tables`.

**How to detect**

Capture baseline plans for critical queries before migrating to {{ CB }}:

  ```sql
  EXPLAIN (ANALYZE, VERBOSE, COSTS, BUFFERS) <query>;
  ```

**How to fix**

Based on the nature and severity of plan changes, rewrite the affected query or configure the parameters.

### Extensions integrated into the core system {#extenstions}

The following extensions have been removed from {{ CB }}, with their features integrated into the core system:

* `gp_parallel_retrieve_cursor`
* `gp_array_agg`
* `gp_percentile_agg`

**How to detect**

Check whether these extensions are installed and used in your codebase:

  ```sql
  SELECT extname, extversion
  FROM pg_extension
  WHERE extname IN ('gp_parallel_retrieve_cursor', 'gp_array_agg', 'gp_percentile_agg');
  ```

**How to fix**

Adapt the application codebase and scripts to work with the built-in features if required.

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}

{% include [cloudberry-trademark](../../../_includes/mdb/mgp/trademark-cloudberry.md) %}