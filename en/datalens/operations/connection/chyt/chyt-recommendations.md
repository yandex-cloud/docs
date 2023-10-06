
# Recommendations for creating a CHYT connection


## Distributing datasets across connections {#separation-by-connections}

* The CHYT connection includes the data about the clique and the token of the user that runs the query. For teams and departments, create a connection for each clique in the cluster using a robot's token.
* If a connection uses a private token, limit the rights for this connection by the **Execute** access. Then other users will be able to view the charts created on top of this connection, but will not be able to create new datasets.

## Creating quick dashboards {#creating-quick-dashboards}

* Try to pre-aggregate the data as much as possible. For example, if the data is in milliseconds and you need to build analytics by days, pre-aggregate the data to days.
* Cut down your on-the-fly calculations. For example, you can calculate the date by the `daytime` field, but filtering by this field will be slower.
* Try to avoid JOIN. This operator slows down queries.
* Move the data processing to an SSD disk, if [CHYT recommendations](#Recommendations-from-chyt) did not work. Tables on an SSD are processed faster.

## Caching parameters and the number of charts on the dashboard page{#caching-and-graphics-options}

* Once you open the dashboard, individual queries are sent across all selectors and charts. Multiple queries are sent one by one. The current page and one more page (web page) are sent. All charts are not loaded at the end of the dashboard. So, to accelerate the loading, optimize the clique's data and resources.
* We do not recommend creating multiple cliques.
* The cache lifetime is 5 minutes by default. If the data is updated less often, for example once a day, increase the lifetime to 1 hour.

## Recommendations from CHYT {#Recommendations-from-chyt}

Typically, query processing speed decreases when reading (not just when reading directly from the disk, but also when decompressing, converting data from {{ ytsaurus-name }} to CH format, and so on). If this is the case, increasing the number of instances does not always help, so we recommend changing the data storage format:
* To avoid reading extra columns, make sure that the tables have the attribute `optimize_for=scan`.
* If you use a set of filters to read the data, be sure to sort your tables. If you use a sort key to filter your data, redundant chunks will be filtered before reading the data from them.

{% note info %}

In some cases, when you sort a table, filtering isn't efficient. The column has a string type and the conversion `DateTime` <-> `String` isn't monotonous and has no one-to-one correspondence. The `Int` <-> `DateTime` conversion in monotonous, but generally, you can't use such an optimization with a string representation. For example, `2020-01-01 00:00:00` and `2020-01-01T00:00:00` correctly represent the same time in ClickHouse, but when sorting based on a string representation, the value `2020-01-01 00:00:01` may appear between them, hence, the `String` -> `DateTime` conversion is monotonous, and this optimization can't be used.

{% endnote %}

* Don't use erasing code. This type of code is designed for "cold" data, it increases the replication workload, so reading such tables isn't effective. Queries against the tables without `erasure_codec` run much faster than on the same tables with `erasure_codec`.

{% note warning %}

However, by simply changing from `erasure_codec` to `optimize_for` you won't modify the data format. To enforce the modification, run `merge` with the option `force_transform=%true`.

{% endnote %}

* Try to avoid dynamic tables. Any reading from a dynamic table requires reading the versions and the entire key. In this case, the readers are less parallelized, which increases the cost of conversion to {{ CH }} format, and you need to merge the rows with the same keys. As a result, reading from dynamic tables is much slower. The exact figure depends on the table and the pattern used to access it, but the difference can be as high as tenfold.
* Avoid unreasonably heavy queries. An example is sorting of 100 GB of SELECT DISTINCT or GROUP BY data by a column having millions of distinct values or using JOIN on big tables. Such queries are always slow.
* Accelerate reads by increasing the `replication_factor` on the table.

When building a dataset on a table range, {{ datalens-short-name }} uses the `concatYtTablesRange` CHYT function. The function outputs the most generic schema of all the tables. The resulting set includes the columns that are present in all the tables and have the same type in each of them. To output the data on all the columns of all the tables from the range, add the missing columns to older tables using `alter-table`.

## Useful links {#links}

* [CHYT performance](https://ytsaurus.tech/docs/ru/user-guide/data-processing/chyt/reference/performance)
* [Visualizing data from CHYT](../../../tutorials/data-from-ch-over-yt.md)
* [Managing access to {{ datalens-short-name }}](../../../security/index.md)
