# OLTP or OLAP operating modes

When working with databases, there are two main scenarios: On-line Transaction Processing (OLTP) and On-line Analytical Processing (OLAP).

OLTP is focused on quick execution of a large stream of transactions, each of which processes a relatively small amount of data. OLAP is mainly designed to analyze data with a lower number of transactions relative to OLTP, but with a much higher volume of processed data.

## Analytics β {#beta-analytics}

{{ ydb-full-name }} Serverless OLTP capabilities are utilized in the production phase by large numbers of users. The OLAP scenario's capabilities are currently at the {{ preview-stage }} stage. To reduce the mutual influence of workload types, a separate database type for OLAP workloads is deployed called `Analytics β`.

`Analytics β` databases are fully managed ([serverless](serverless-and-dedicated.md)) {{ ydb-short-name }} databases designed for analytical data processing. With their help, you can conveniently address periodic data analysis tasks, build data marts, or perform any other types of analysis.


{% note info %}

There is currently no charge for using `Analytics β` databases. You only pay for using data storage space based on [{{ ydb-full-name }} Serverless](../pricing/serverless.md#rules-storage) pricing plans.

{% endnote %}


## {{ ydb-full-name }} dedicated databases {#olap}

OLAP data processing is available at {{ preview-stage }} stage in {{ ydb-full-name }} dedicated databases.

{% note warning %}

When operating within the same database, OLAP and OLTP workloads share common database resources. Yet the database resource utilization profiles for OLAP and OLTP workloads differ considerably. It is not recommended to combine production workloads of different types within the same database because of the mutual influence of the workload profiles.

{% endnote %}

## Column-oriented tables {#column_table}

It is recommended to store the data used in OLAP workloads in [column tables]({{ ydb.docs }}/concepts/datamodel/table#column-tables).

{{ ydb-short-name }} column tables store the data of each column separately (independently) from other columns. This data storage principle is optimized for use in OLAP scenarios, as oftentimes only a few columns of source data are used to build analytical reports, and columnar storage allows reading from disks only the columns directly involved in the request. Another benefit of this approach lies in the high degree of data compression, since columns often store repetitive or similar data. The downside is that operations on full rows become costlier due to the need to reconstruct them on the fly from individual cells.

The current basic use case of {{ ydb-short-name }} column tables is writing data with increasing primary key (e.g., event time), analyzing such data, and deleting obsolete data based on TTL. The optimal way to add data to {{ ydb-short-name }} column tables is batch writing in blocks of several megabytes.

{% note info %}

Currently, managing column table data through `INSERT INTO`, `UPSERT`, `UPDATE`, `REPLACE`, `DELETE` SQL constructions is not supported. To record data, use data delivery from external systems ([ydb import]({{ ydb.docs }}/reference/ydb-cli/export-import/import-file), [Data Transfer](../../data-transfer/transfer-matrix.md), [Fluent Bit]({{ ydb.docs }}/integrations/fluent-bit), [Logstash](https://github.com/ydb-platform/ydb-logstash-plugins)), or the [BulkUpsert]({{ ydb.docs }}/reference/ydb-sdk/recipes/bulk-upsert) SDK API method. To delete data, use [TTL]({{ ydb.docs }}/concepts/ttl).

{% endnote %}

## See also {#see-also}

* [Description of column tables]({{ ydb.docs }}/concepts/datamodel/table#column-tables)
* [Selecting a primary key of a column table]({{ ydb.docs }}/best_practices/pk-olap-scalability)
