# Create table

Welcome to YQL tutorial for {{ ydb-short-name }}! Example queries provide an overview of how to perform simple DDL and DML operations in {{ ydb-short-name }} using YQL.

Let's start with creating tables for demo data.

[CREATE TABLE](../../yql/reference/syntax/create_table.md) will create a new, initially empty table in the current database inside the TablePathPrefix path. The name of the table must be unique within the current folder. Table is described with the pairs of column name and column type, and mandatory PRIMARY KEY at the end. If the specified table name starts with the "/", or the "TablePathPrefix" Pragma is omitted, it will be interpreted as absolute path from the root "/".

```sql
CREATE TABLE series          -- We are using short table names in the example.
                             -- Table will be placed inside the TablePathPrefix.
(
    series_id Uint64,
    title Utf8,
    series_info Utf8,
    release_date Uint64,
    PRIMARY KEY (series_id)  -- The PRIMARY KEY constraint comprises a column or
                             -- combination of columns that uniquely identifies
                             -- every row in the table (contains only
                             -- non-duplicate values). Only one primary key can
                             -- be specified for a table. Exactly one PRIMARY
                             -- KEY must be specified for every YDB table.
);

CREATE TABLE seasons
(
    series_id Uint64,
    season_id Uint64,
    title Utf8,
    first_aired Uint64,
    last_aired Uint64,
    PRIMARY KEY (series_id, season_id)
);

CREATE TABLE episodes
(
    series_id Uint64,
    season_id Uint64,
    episode_id Uint64,
    title Utf8,
    air_date Uint64,
    PRIMARY KEY (series_id, season_id, episode_id)
);

COMMIT;

```

By the way, all the keywords in this tutorial are in CAPS LOCK just for demonstration purposes, in fact they are case insensitive.