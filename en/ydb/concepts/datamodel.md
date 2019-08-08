# Data model and schema

{% if audience == "internal" %}

Key {{ ydb-short-name }} entities:

* *A table* is an entity used for storing typed data rows.
* *A directory* is a structure that lets you order and systematize data.
* *A persistent queue* (or PQ) is an implementation of the [message queue](https://en.wikipedia.org/wiki/Message_queue) concept.
* *A network block store volume* is an implementation of the high-performance, fault-tolerant network block storage concept.

{% else if audience == "external" %}

Key {{ ydb-short-name }} entities:

* *A table* is a table used for storing typed data rows.
* *A directory* is a structure that lets you order and systematize data.

{% endif %}

## Table {#table}

[A *table*](https://en.wikipedia.org/wiki/Table_(database)) is a collection of related data organized in rows and columns. Each row is a set of cells that are used for storing specific types of values according to the data schema. The data schema defines the names and types of table columns.

{% if audience == "internal" %}

An example of a data schema is shown below.

![Datamodel_of_a_relational_table](../_assets/datamodel_rtable.png)

The picture shows the schema of a ```Series``` table with four columns, named ```SeriesId```, ```ReleaseDate```, ```SeriesInfo```, and ```Title```, with the ```Uint64?``` data type for the first two columns and ```String?``` for the others. The ```SeriesId``` column is declared the primary key.

{{ ydb-short-name }} uses [YQL](datatypes.md) data types. [Simple YQL data types](https://yql.yandex-team.ru/docs/ydb/types/primitive/) can be used as column types. All columns can contain a special NULL value to indicate a missing value.

{% endif %}

{{ ydb-short-name }} uses [YQL](datatypes.md) data types. Simple data types can be used as column types. All columns can contain a special NULL value to indicate a missing value.

{{ ydb-short-name }} tables always have one or more columns that make up the key ([primary key](https://en.wikipedia.org/wiki/Unique_key)). Each table row has a unique key value, so there can be no more than one row per key value. {{ ydb-short-name }} tables are always ordered by key. This means that you can efficiently read rows by a single key value or key range (actually using an index). Tables consisting only of key columns are supported. However, you can't create tables without a primary key.

Often, when you design a table schema, you already have a set of fields, which can naturally serve as the primary key. Be careful when selecting the key to avoid hotspots.
For example, if you insert data into a table with a monotonously incrementing key, you write to the end of the table. But since {{ ydb-short-name }} splits table data by key ranges, your inserts are always processed by the same server, so you lose the main benefits of the distributed database.
To distribute the load evenly across different servers and avoid hotspots when working with large tables, we recommend you hash the natural key and use the hash as the first component of the primary key, as well as change the order of the primary key components.

### Table sharding {#table-sharding}

A database table can be sharded by primary key value ranges. Each shard of the table is responsible for a specific range of primary keys. Key ranges served by different shards do not overlap. Different table shards can be served by different distributed database servers (including ones in different locations). They can also move independently between servers to enable rebalancing or ensure shard operability if servers or network equipment go offline.

If there is not a lot of data, the table may consist of a single shard. As the amount of data served by the shard grows, {{ ydb-short-name }} automatically splits the shard into two shards. The data is split by the median value of the primary key, depending on the amount of data: as soon as the shard exceeds the set data volume, it is split in two.

The shard split threshold and automatic splitting can be configured (enabled/disabled) individually for each database table.

In addition to automatically splitting shards, you can create an empty table with a predefined number of shards. You can manually set the exact shard key split range or evenly split into a predefined number of shards. In this case, ranges are created based on the first component of the primary key. You can set even splitting for tables that have an integer as the first component of the primary key.

{% if audience == "internal" %}

{% note important %}

When you create a table in the current version, you can only configure the sharding model (or Partitioning Policy) from the SDK for [C++](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/cpp/client/ydb_table.h), [Java](https://a.yandex-team.ru/arc/trunk/arcadia/kikimr/public/sdk/java/table/src/settings/PartitioningPolicy.java), or [Python](https://a.yandex-team.ru/arc//trunk/arcadia/kikimr/public/sdk/python/client/table.py).

{% endnote %}

{% else if audience == "external" %}

{% note important %}

In the current version, when you create a table, you can only configure the sharding model (or Partitioning Policy) from the SDK for Java and Python.

{% endnote %}

{% endif %}

{% if audience == "internal" %}

## Persistent queue {#pq}

A persistent queue consists of one or more partitions, where each partition is a [FIFO](https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)) [message queue](https://en.wikipedia.org/wiki/Message_queue) ensuring reliable delivery between two or more components. Data messages are untyped and constitute a data blob. Partitioning is a parallel processing tool that helps ensure high queue bandwidth. Mechanisms are provided to implement at least once and exactly once persistent queue delivery guarantees. A persistent queue in {{ ydb-short-name }} is similar to a topic in [Apache Kafka](https://en.wikipedia.org/wiki/Apache_Kafka).

{% note important %}

In the current version, only tables and directories can be used from {{ ydb-short-name }} databases. Persistent queues are available in Logbroker.

{% endnote %}

## Network block store volume {#nbd}

{{ ydb-short-name }} can be used as a platform for creating a wide range of data storage and processing systems, for example, by implementing a [network block device](https://en.wikipedia.org/wiki/Network_block_device) on {{ ydb-short-name }}. Network block devices implement an interface for a local block device, as well as ensure fault-tolerance (through redundancy) and good scalability in terms of volume size and the number of input/output operations per unit of time. The downside of a network block device is that any input/output operation on such device requires network interaction, which might increase the latency of the network device compared to the local device. You can deploy a common file system on a network block device and/or run an application directly on the block device, such as a database management system.

{% note important %}

In the current version, only tables and directories can be used from {{ ydb-short-name }} databases. Network block device volumes are available from the Network Block Store, which is similar to [Amazon EBS](https://en.wikipedia.org/wiki/Amazon_Elastic_Block_Store).

{% endnote %}

{% endif %}

## Entity hierarchy {#hierarchy}

{% if audience == "internal" %}

To make it easier to organize the aforementioned database entities (tables, persistent queues, and network block store volumes), the system lets you create directories like in a file system: the database constitutes a directory tree, while tables, persistent queues, and network block devices are the leaves (just like files in a file system). A directory can host multiple subdirectories and several other types of entities. The names of directories and the entities they contain are unique.

{% else if audience == "external" %}

To make it easier to organize tables, directories can be created like in the file system. The database constitutes a directory tree, while tables are the leaves (just like files in a file system) A directory can host multiple subdirectories and several other types of entities. The names of directories and the entities they contain are unique.

{% endif %}

