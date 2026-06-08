---
title: Tips for creating a CHYT connection in {{ datalens-full-name }}
description: In this article, you will learn how to streamline operations with CHYT connections in {{ datalens-full-name }}.
---


# Tips for creating a CHYT connection in {{ datalens-full-name }}


## Distributing datasets across connections {#separation-by-connections}

* The CHYT connection includes the clique data and the token of the user running the query. For teams and departments, create a connection for each clique in the cluster using a robot's token.
* If a connection uses a user token, limit the permissions for this connection by the **Execution** access. Thus, other users will be able to view charts created on top of this connection, but will not be able to create new datasets.

## Creating quick dashboards {#creating-quick-dashboards}

* Try to pre-aggregate data as much as possible. For example, if data is in milliseconds and you need to build analytics by days, pre-aggregate the data to days.
* Cut down your on-the-fly calculations. For example, you can calculate the date by the `datetime` field, but filtering by this field will be slower.
* Try to avoid the JOIN operator as it slows down queries.
* Try to process data on an SSD, if [these CHYT recommendations](#Recommendations-from-chyt) do not work. On SSDs, tables are processed faster.

## Caching parameters and the number of charts on the dashboard page {#caching-and-graphics-options}

* Once you open the dashboard, individual queries are sent across all selectors and charts. Multiple queries are sent one by one. The current page and one more page (web page) are sent. All charts are not loaded at the end of the dashboard. So, to accelerate the loading, optimize the clique's data and resources.
* We do not recommend creating multiple cliques.
* The default cache lifetime is five minutes. If data is updated less often, e.g., once a day, extend the lifetime to one hour.

## CHYT recommendations {#Recommendations-from-chyt}

Typically, query processing rate decreases when reading (not only when reading directly from the disk, but also when decompressing, converting data from {{ ytsaurus-name }} to CH format, and so on). If this is the case, increasing the number of instances does not always help, so we recommend changing the data storage format:
* To avoid reading excessive columns, make sure the tables have the `optimize_for=scan` attribute.
* If you use a set of filters to read data, make sure to sort your tables. If you use a sort key to filter your data, redundant chunks will be filtered before reading data from them. 

{% note info %}

In some cases, when you sort a table, filtering is not efficient. The column has the string type and the `DateTime` <-> `String` conversion is not monotonous and has no one-to-one correspondence. The `Int` <-> `DateTime` conversion is monotonous, but generally, you cannot use such an optimization with a string representation. For example, `2020-01-01 00:00:00` and `2020-01-01T00:00:00` correctly represent the same time in {{ CH }}, but when sorting based on a string representation, the `2020-01-01 00:00:01` value may appear between them, hence, the `String` -> `DateTime` conversion is not monotonous, and this optimization cannot be used.

{% endnote %}

* Do not use erasure coding. This type of code is designed for "cold" data, as it increases the replication workload, so reading such tables is not efficient. Queries against a table without `erasure_codec` run much faster than queries against the same table with `erasure_codec`. 

{% note warning %}

However, replacing the `erasure_codec` attribute with `optimize_for` will not change the data format. To force the change, run `merge` with the `force_transform=%true` option.

{% endnote %}

* Try to avoid dynamic tables. Reads from a dynamic table require reading the versions and the entire key. In this case, readers are less parallelized, which increases the cost of conversion to the {{ CH }} format, and you need to merge rows with the same keys. As a result, reading from dynamic tables is much slower. The exact figure depends on the table and its access pattern, but the difference can be as high as tenfold.
* Avoid unreasonably heavy queries, e.g., sorting 100 GB of SELECT DISTINCT or GROUP BY data by a column having millions of distinct values or using a JOIN on big tables. Such queries will be processed more slowly.
* Accelerate reads by increasing `replication_factor` on the table.

When building a dataset on a range of tables, {{ datalens-short-name }} uses the `concatYtTablesRange` CHYT function to output the most generic schema of all the tables. The final set includes the columns that are present in all the tables and have the same type in each of them. To output the data on all the columns of all the tables from the range, add the missing columns to older tables using `alter-table`.

## Useful links {#links}

* [CHYT performance](https://ytsaurus.tech/docs/ru/user-guide/data-processing/chyt/reference/performance)
* [Visualizing data from CHYT](../../../tutorials/data-from-ch-over-yt.md)
* [Managing access to {{ datalens-short-name }}](../../../security/index.md)

{% include [clickhouse-disclaimer](../../../../_includes/clickhouse-disclaimer.md) %}
