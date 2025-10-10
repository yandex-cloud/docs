# OLTP or OLAP operating modes

When working with databases, there are two main scenarios: On-line Transaction Processing (OLTP) and On-line Analytical Processing (OLAP).

OLTP is focused on quick execution of a large stream of transactions, each of which processes a relatively small amount of data. OLAP is mainly designed to analyze data with a lower number of transactions relative to OLTP, but with a much higher volume of processed data.

OLTP and OLAP modes are available in both serverless and dedicated instance modes in {{ ydb-full-name }}.

## OLTP mode

We recommend to store data used in OLTP workloads in [row-oriented tables]({{ ydb.docs }}/concepts/datamodel/table#row-oriented-tables).

Row-oriented tables are best suited for OLTP workloads with a large number of short transactions and a high number of concurrent users, when you need to quickly read or modify entire entities (rows) by key, with extensive use of `INSERT`/`UPDATE`/`DELETE`. This format minimizes I/O when accessing a full record and works well with indexes, limitations, and transactions (ACID), ensuring low latency and data integrity. It is optimal for operational systems, including online stores, banking and billing applications, CRM/ERP, booking systems, where typical queries involve few rows but many columns.

OLTP mode is identical in serverless mode and dedicated instance mode in {{ ydb-full-name }}.

{% note warning %}

In {{ ydb-full-name }} databases running in OLTP mode, you cannot create column-oriented tables.

{% endnote %}

## OLAP mode

OLAP databases are designed for analytical data processing. With their help, you can conveniently address periodic data analysis tasks, build data marts, or perform any other types of analysis.

{% note warning %}

When operating within the same database, OLAP and OLTP workloads share common database resources. Yet the database resource utilization profiles for OLAP and OLTP workloads differ considerably. It is not recommended to combine production workloads of different types within the same database because of the mutual influence of the workload profiles.

{% endnote %}

We recommend you use [column tables]({{ ydb.docs }}/concepts/datamodel/table#column-oriented-tables) to store data used in OLAP workloads.

{{ ydb-short-name }} column tables store the data of each column separately (independently) from other columns. This data storage principle is optimized for use in OLAP scenarios, as oftentimes only a few columns of source data are used to build analytical reports, and columnar storage allows reading from disks only the columns directly involved in the request. Another benefit of this approach lies in the high degree of data compression, since columns often store repetitive or similar data. The downside is that operations on full rows become costlier due to the need to reconstruct them on the fly from individual cells.

OLAP mode is available in both serverless and dedicated instance modes in {{ ydb-full-name }}. For dedicated instances, OLAP is available at the [General Availability](../../overview/concepts/launch-stages.md) stage. For serverless mode, OLAP is implemented as an experimental beta feature (OLAP/Analytics β) and is at the Preview stage.

In OLAP mode, each {{ ydb-short-name }} node is allocated a larger amount of RAM than in OLTP mode, which is necessary for running analytical queries with large amounts of data. If the amount of data processed in a query exceeds the amount of RAM, {{ ydb-short-name }} uses [spilling](./resources.md#spilling): writes intermediate results of running analytical queries to disk.

{% note warning %}

- Serverless `OLAP (Analytics β)` databases are currently free of charge. You only pay for the amount used to store data based on [Serverless {{ ydb-full-name }}](../pricing/serverless.md#rules-storage) pricing plans.
- Temporary storage (spilling) in dedicated databases is charged separately. See [{#T}](../pricing/dedicated.md).
- The default maximum number of parallel queries run in dedicated databases in OLAP mode is 10. This limitation is set by the `CONCURRENT_QUERY_LIMIT` parameter in the `olap` [resource pool]({{ ydb.docs }}/concepts/glossary#resource-pool). You can edit it yourself. For more information on managing resource consumption in {{ ydb-short-name }}, see [this guide]({{ ydb.docs }}/dev/resource-consumption-management).

{% endnote %}

## See also {#see-also}

* [Description of row-oriented tables]({{ ydb.docs }}/concepts/datamodel/table#row-oriented-tables)
* [Description of column-oriented tables]({{ ydb.docs }}/concepts/datamodel/table#column-oriented-tables)
* [Selecting a primary table key]({{ ydb.docs }}/dev/primary-key)
