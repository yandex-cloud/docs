# Federated queries

Federated queries provide a way to process data from multiple data sources with a single query. Currently, federated queries can work with {{ CH }} and {{ PG }} databases and {{ objstorage-full-name }} data storages.

To work with data stored in external databases, you simply need to create a [connection](glossary.md#connection). To work with unschematized data stored in S3 buckets, you also need to create a [data binding](glossary.md#binding).

Read more about working with different data sources in these sections:
* [{{ CH }}](../sources-and-sinks/clickhouse.md).
* [{{ PG }}](../sources-and-sinks/postgresql.md).
* [S3](../sources-and-sinks/object-storage-binding.md).

Example of how to use federated queries in {{ yq-full-name }}:

@[YouTube](https://youtu.be/1EN28LVncPM?si=kmytEx5zGRTnXrJ4)
