---
title: Using gp_relaccess_stats in {{ mgp-name }}
description: How to use gp_relaccess_stats in {{ mgp-full-name }}.
---

# Using gp_relaccess_stats in {{ mgp-name }}

`gp_relaccess_stats` is a {{ yandex-cloud }} extension that collects the access statistics for tables and views. It registers the read, insert, update, and delete operations, as well as the timestamp of the user's last access to the object. The collected data helps find unused or improperly used objects.

## Extension settings {#extension-settings}

| Configuration | Type | Default value | Description |
|-----------|-----|-----------------------|----------|
| `gp_relaccess_stats.enabled` | `bool` | `false` | Turns on the collection of statistics. You can enable this setting at the cluster or database level. We recommend the database level option. |
| `gp_relaccess_stats.max_tables` | `integer` | `65536` | Maximum number of tables for caching statistics. |
| `gp_relaccess_stats.dump_on_overflow` | `bool` | `false` | Decides the behavior if `gp_relaccess_stats.max_tables` is exceeded. If `true`, the statistics cache is automatically cleared via `relaccess_stats_dump()`. If `false`, you get a low-space warning. |

For more information about the extension, see [this gp_relaccess_stats guide](https://github.com/open-gpdb/gp_relaccess_stats).

## Installing gp_relaccess_stats in a {{ GP }} cluster {#extension-install}

1. [Connect](../connect/index.md) to the database as the owner or a user with the `CREATE` permission in the database and run this command:

    ```sql
    CREATE EXTENSION gp_relaccess_stats;
    ```

1. Make sure the extension has been installed:

    ```sql
    SELECT extname FROM pg_extension;
    ```

    This will bring up the list of extensions installed in the database.

## Use cases {#examples}

1. Create a statistics collection table:

    ```sql
    SELECT relaccess_stats_init();
    ```

    The `relaccess_stats` table will get new empty entries for each table and partition of the selected database.

1. Update the statistics:

    ```sql
    SELECT relaccess_stats_update();
    ```

    The `relaccess_stats` table will now be populated with statistics from the cache and the `pg_stat` folder.

1. Check the current usage of the statistics cache:

    ```sql
    SELECT relaccess.relaccess_stats_fillfactor();
    ```

    This will show the statistics cache fill percentage.

1. Query the `relaccess_stats` table for statistical data:

    ```sql
    SELECT * FROM relaccess_stats;
    ```

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}