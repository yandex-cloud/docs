---
title: Rules for estimating the cost of queries to {{ ydb-full-name }} via ad-hoc APIs
description: In this tutorial, you will learn how to calculate the cost of queries to {{ ydb-short-name }} via ad-hoc APIs.
editable: false
---

# Rules for estimating the cost of queries to {{ ydb-short-name }} via ad-hoc APIs



## ReadTable {#read-table}

The `ReadTable` operation allows you to efficiently read large ranges of data from a table. The request cost only depends on the amount of data read based on the rate of 128 RU per 1 MB. For the purpose of cost calculation, the amount is rounded up to a multiple of 1 MB.

## BulkUpsert {#bulk-upsert}

`BulkUpsert` allows you to efficiently upload data to your database. The cost of writing a row using the `BulkUpsert` operation is 0.5 RU per 1 KB of written data. For the purpose of cost calculation, the data amount is rounded up to a multiple of 1 KB. The total cost of the operation is calculated as the sum of costs for all rows written, with the result rounded up to the nearest integer.

**Cost calculation example**

For example, as part of the `BulkUpsert` operation, you write four data rows of 2,500 bytes, 100 bytes, 1,200 bytes, and 1,024 bytes.

The cost of this operation is:
> 0.5 RU × 3 + 0.5 RU × 1 + 0.5 RU × 2 + 0.5 RU × 1 = 3.5 RU
>
> Total, rounded up to the nearest integer: 4 RU

Where:
* 0.5 is the cost in request units per 1 KB of written data.
* 3 is the rounded up size of the first row in KB (2,500 bytes = 1,024 bytes + 1,024 bytes + 452 bytes).
* 1 is the rounded up size of the second row in KB.
* 2 is the rounded up size of the third row in KB (1,200 bytes = 1,024 bytes + 176 bytes).
* 1 is the size of the fourth row in KB.

## Building a secondary or vector index {#build-index}

The cost of building an index is made up of the total cost of the following operations:

- I/O operations whose cost is comprised of:
  - Reading data from indexed and intermediate tables: [`ReadTable`](#read-table).
  - Writing data to indexed and intermediate tables: [`BulkUpsert`](#bulk-upsert).
- For vector indexes, the consumption of CPU computing resources is charged separately.

The index building process can be canceled by the user, in which case the cost will be based on actual processed data volume and resources consumed up to the cancellation.

### Building a secondary index {#secondary-index}

For a secondary index, the cost is calculated as the sum of charges for read operations from the indexed table and write operations to the index table.

### Building a vector index {#vector-index}

For a vector index, its building nuances and increased consumption of computing resources are additional factors to consider.

For the [`vector_kmeans_tree`](https://ydb.tech/docs/ru/dev/vector-indexes?version=main#kmeans-tree-type) type of vector index:

- The total amount of read data is approximately $5 * ${levels} of the indexed table size (`levels` is the number of index tree levels).
- The total amount of written data is approximately $${levels} of the indexed table size.
- Computing resource consumption includes all CPU usage time during all index building stages.

The final cost is determined as follows: you calculate the sum of data read/write (IO) operation costs and, separately, the CPU consumption cost, and then take the maximum one of these two values as the final cost of building the index.

