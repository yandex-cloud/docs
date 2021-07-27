---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Secondary indexes

## Problem description

The [Concepts: Secondary indexes](../concepts/secondary_indexes.md) document provides a brief description of features and limitations of the current implementation of secondary indexes. Let's take a look at how you can use secondary indexes to output a list of series that meet the limit on the number of views.

## Data schema

<small>Listing 1: Query to create a ```series table```</small>

```
CREATE TABLE series
(
    series_id Uint64,
    title Utf8,
    series_info Utf8,
    release_date Uint64,
    views Uint64,
    PRIMARY KEY (series_id),
    INDEX views_index GLOBAL ON (views)
);
```

The ```series``` table has a key column named ```series_id```. A primary key index in YDB is created automatically and the stored data is sorted in order of ascending primary key values. Therefore, selections by this key will be efficient. An example of this selection is a search for all broadcasts of a series by its ```series_id``` from the ```series``` table. We also created an index named ```views_indexes``` to the ```views``` column, which will let you efficiently execute queries using the last row in the predicate.

In more complex cases, you can create multiple secondary indexes:

<small>Listing 2: Query to create a table with two indexes named ```series```</small>

```
CREATE TABLE series
(
    series_id Uint64,
    title Utf8,
    series_info Utf8,
    release_date Uint64,
    views Uint64,
    PRIMARY KEY (series_id),
    INDEX views_index GLOBAL ON (views),
    INDEX date_index GLOBAL ON (release_date)
);
```

In this example, we created two secondary indexes: to the views and release_date columns.

## Inserting data

{% note info "Prepared queries" %}

This section uses prepared queries in YQL query examples. To try running them in the YQL editor, define the values of the parameters declared at the top of the query using the operator ```DECLARE```

{% endnote %}

<small>Listing 3: Sample transaction for adding data</small>

```
DECLARE $seriesId AS Uint64;
DECLARE $title AS Utf8;
DECLARE $seriesInfo AS Utf8;
DECLARE $releaseDate AS Uint32;
DECLARE $views AS Uint64;

INSERT INTO series (series_id, title, series_info, release_date, views)
VALUES ($seriesId, $title, $seriesInfo, $releaseDate, $views);
```

You can save a new number of views for a particular series in the database with a single  ```UPSERT``` into the ```series``` table.

<small>Listing 4: Updating the table ```series```</small>

```
DECLARE $seriesId AS Uint64;
DECLARE $newViews AS Uint64;

UPSERT INTO series (series_id, views)
VALUES ($seriesId, $newViews)
```

## Data selections

Without using secondary indexes, a query to select records that satisfy a certain predicate by the number of views won't work effectively, since YDB scans all the rows of the ```series``` table to execute it. In the current version, you should explicitly specify which index to use for the optimizer.

<small>Listing 5: Query to select the ```series``` table rows satisfying the predicate by the number of views</small>

```
SELECT series_id, title, series_info, release_date, views
FROM series view views_index
WHERE views >= someValue
```

{% note info "Накладные расходы распределённых транзакций" %}

In general, transactions using a global index are distributed transactions, so they require more resources and take more time. While point reads and writes may take up to 10 ms in the 99th percentile, distributed transactions typically take from 20 to 500 ms. Note that, in some cases, a read query can be executed as a single-shard transaction:

- Point read by primary key.
- Point read by index column if requested data is a primary key (or part of it).

{% endnote %}

{% note warning "Ограничения на размер ответа" %}

A full table scan may be impossible due to internal constraints: the size of the response to a client cannot exceed 50 MB and the size of data extracted from a single table shard per YQL query cannot exceed 5 GB. For large tables and queries, these limits may make it impossible to fully scan all table rows.

{% endnote %}

