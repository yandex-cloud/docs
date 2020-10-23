# Schema design

This section provides recommendations for designing a DB schema to enhance {{ ydb-short-name }} performance.

## Designing a primary key {#pk-design}

When designing a DB schema, it's important to consider expected load scenarios. One of the design steps is to select the primary keys for tables. The right choice of primary keys is important as it affects the speed of reading data from tables and writing data to them.

General recommendations for choosing a primary key:

* Avoid situations where the main load falls on one [partition](../concepts/datamodel.md#partitioning) of a table. With even load distribution, it's easier to achieve high performance.
* Reduce the number of partitions that can be affected in a single request. Moreover, if the request affects no more than one partition, it is performed using a special simplified protocol. This significantly increases the speed and saves the resources.

You should carefully choose a primary key and avoid situations where a small part of the database is much more loaded than the rest of the database.

For example, since all tables in {{ ydb-short-name }} are sorted by ascending primary key, writes in a data table with a monotonically increasing primary key cause new data to be written to the end of the table. As YDB splits table data into partitions based on key ranges, inserts are always processed by the same server that is responsible for the "last" partition. Concentrating the load on a single server results in slow data uploading and inefficient use of a distributed system.
As an example, let's take logging of user events to a table with the ```( timestamp, userid, userevent, PRIMARY KEY (timestamp, userid) )``` schema.

```timestamp``` monotonically increases, and as a result, all records are written to the end of the table and the "last" partition that is responsible for this range of keys serves all records in the table. This leads to lower writing performance.

YDB supports automatic partition splitting when the threshold size is reached (usually about 2 GB). However, in our case, after splitting, a new partition starts taking all the write load and the situation repeats.

## Techniques that let you evenly distribute the load across table partitions {#balance-shard-load}

### Changing the sequence of key components {#key-order}

Writing data to a table with the ```( timestamp, userid, userevent, PRIMARY KEY (timestamp, userid) )``` schema results in an uneven load on table partitions due to a monotonically increasing primary key. Changing the sequence of key components so that the monotonically increasing part isn't the first component can help distribute the load more evenly. If you change the table schema to ```( timestamp, userid, userevent, PRIMARY KEY (userid, timestamp) )```, then, with a sufficient number of users that generate events, writing to the database is distributed across the partitions more evenly.

### Using a hash of key column values as a primary key {#key-hash}

Let's take a table with the ```( timestamp, userid, userevent, PRIMARY KEY (userid, timestamp) )``` schema. As the entire primary key or its first component, you can use a hash of the source key. For example:

```
( HASH(timestamp, userid), timestamp, userid, userevent, PRIMARY KEY (HASH(timestamp, userid), userid, timestamp) )
```

If you select the hashing function correctly, the rows are distributed evenly enough throughout the key space, which results in an even load on the system. In this case, if the ```userid, timestamp``` fields are present in the key after ```HASH(timestamp, userid)```, this preserves data locality and sorting by time for a specific user.

### Reducing the number of partitions affected in a single query {#decrease-shards}

Let's assume that the main scenario for working with table data is to read all events by a specific ```userid```. Then, when you use the ```( timestamp, userid, userevent, PRIMARY KEY (timestamp, userid) )``` table schema, each read affects all the partitions of the table. Moreover, each partition is fully scanned, since the rows related to a specific ```userid``` are located in an order that isn't known in advance. Changing the sequence of ```( timestamp, userid, userevent, PRIMARY KEY (userid, timestamp) )``` key components causes all rows related to a specific ```userid``` to follow each other. This arrangement of rows has a positive effect on the speed of reading information on a particular ```userid```.

## NULL value in a key column {#key-null}

In {{ ydb-short-name }}, all columns, including key ones, may contain a NULL value. Using NULL as values in key columns isn't recommended. According to the SQL standard (ISO/IEC&nbsp;9075), you can't compare NULL with other values. Therefore, the use of concise SQL statements with simple comparison operators may lead, for example, to skipping rows containing NULL during filtering.

## Row size limit {#limit-string}

To achieve high performance, we don't recommend writing rows larger than 8 MB and key columns larger than 2 KB to the DB.

