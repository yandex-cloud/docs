---
title: How to use gp_relsizes_stats in {{ mgp-full-name }}
description: Follow this guide to use the gp_relsizes_stats extension in {{ mgp-name }}.
---

# Using gp_relsizes_stats in {{ mgp-name }}

The `gp_relsizes_stats` extension is designed to collect statistics on the physical sizes of files and tables across all {{ GP }} cluster segments.

Key features:

* Automatic statistics collection via a background worker.
* Simultaneous monitoring of all cluster segments.
* Flexible performance settings to control system load.
* Tracking the history of table size changes.
* Option to manually run statistics collection when needed.

Extension components:

* Main background worker, which, if enabled, collects statistics on a regular basis. The worker runs in the `postgres` database.
* Workers for specific databases.
* Statistics collection function which scans the file system to calculate file sizes. The function runs on each segment.

## Data schema {#data-schema}

[Installing the extension](#extension-install) creates a schema named `relsizes_stats_schema` with the following tables.

Main tables:

| Table | Description | Structure |
|---------|----------|-----------|
| `segment_file_map` | Mapping of table IDs (reloid) to their corresponding file names on the disk (relfilenode) for each segment. | `segment`, `reloid`, `relfilenode` |
| `segment_file_sizes` | Sizes of files on individual segments. | `segment`, `relfilenode`, `filepath`, `size`, `mtime` |
| `table_sizes_history` | History of table sizes. | `insert_date`, `nspname`, `relname`, `size`, `mtime` |

Views for analysis:

| Table | Description |
|---------|----------|
| `table_files` | Detailed information about table files with their types (main, toast, ao, etc.). |
| `table_sizes` | Aggregated sizes of tables across all segments. |
| `namespace_sizes` | Sizes of database schemas. |

## Extension settings {#extension-settings}

| Configuration | Default value | Description |
|-----------|-----------------------|----------|
| `relsizes_stats.on` | True | If the setting is enabled, the extension is available for installation in a database. |
| `relsizes_stats.enable` | False | Enabling this setting creates the main background worker which collects statistics across the entire cluster on a regular basis.<br>If you prefer to collect statistics manually, we recommend disabling this setting to avoid background load. |
| `relsizes_stats.restart_naptime` | 21,600,000 ms | Sets the statistics collection frequency across the entire cluster. |
| `relsizes_stats.database_naptime` | 0 ms | Sets the wait time between statistics collection for different databases. |
| `relsizes_stats.file_naptime` | 1 ms | Sets the wait time between processing of different files. This allows you to minimize the background load associated with statistics collection by distributing it over time. |

To update these settings, contact [support]({{ link-console-support }}).

## Installing gp_relsizes_stats in a {{ GP }} cluster {#extension-install}

1. [Connect](../connect.md) to the database as the owner or a user with the `CREATE` permission in the database and run this command:

    ```sql
    CREATE EXTENSION gp_relsizes_stats;
    ```

1. Make sure the extension has been installed:

    ```sql
    SELECT extname FROM pg_extension;
    ```

    This will display a list of extensions installed in the DB:

    ```text
          extname
    -------------------
     ...
     gp_relsizes_stats
    ```

## Use cases {#examples}

As an example, let’s collect statistics for a call center’s database. To do this, prepare the source data:

1. Create a schema named `call_center`:

    ```sql
    CREATE SCHEMA call_center;
    ```

1. Create a table named `operators` in the `call_center` schema:

    ```sql
    CREATE TABLE call_center.operators (
        id INTEGER PRIMARY KEY,
        operator_name varchar (20),
        operator_id INTEGER
    );
    ```

1. Insert the generated data into the `operators` table:

    ```sql
    INSERT INTO call_center.operators (id, operator_name, operator_id)
    SELECT 
        generate_series(1, 1000) AS id,
        'Operator ' || generate_series(1, 1000) AS operator_name,
        10000 + generate_series(1, 1000) AS operator_id;
    ```

1. Run statistics collection manually:

    ```sql
    SELECT relsizes_stats_schema.relsizes_collect_stats_once();
    ```

### Table sizes

To output the 20 largest tables in the database, run this command:

```sql
SELECT nspname, relname,
       pg_size_pretty(size) as size_pretty,
       mtime
FROM relsizes_stats_schema.table_sizes
ORDER BY size DESC
LIMIT 20;
```

To output the size of the `operators` table, run this command:

```sql
SELECT relname, pg_size_pretty(size) as size_pretty
FROM relsizes_stats_schema.table_sizes
WHERE nspname='call_center' AND relname='operators';
```

### Schema sizes

To output all schema sizes in the database, run this command:

```sql
SELECT nspname, pg_size_pretty(size) as size_pretty
FROM relsizes_stats_schema.namespace_sizes
ORDER BY size DESC;
```

To output the size of the `call_center` schema, run this command:

```sql
SELECT nspname, pg_size_pretty(size) as size_pretty
FROM relsizes_stats_schema.namespace_sizes
WHERE nspname='call_center';
```

### Table growth history

To output the history of the `operators` table size changes, run this command:

```sql
SELECT insert_date, pg_size_pretty(size) as size_pretty
FROM relsizes_stats_schema.table_sizes_history
WHERE nspname='call_center' AND relname='operators'
ORDER BY insert_date;
```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
