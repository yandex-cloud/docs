---
title: Estimating the cost of requests to {{ ydb-full-name }} via ad-hoc APIs
description: In this article, you will learn how to calculate the cost of requests to {{ ydb-short-name }} via ad-hoc APIs.
editable: false
---

# Estimating the cost of requests to {{ ydb-short-name }} via ad-hoc APIs



## ReadTable {#read-table}

The `ReadTable` operation allows you to efficiently read large ranges of data from a table. The request cost only depends on the amount of read data based on the rate of 128 request units (RUs) per MB. For cost calculation, the amount is rounded up to a multiple of 1 MB.

## BulkUpsert {#bulk-upsert}

`BulkUpsert` allows you to efficiently upload data to your database. The cost of writing a row using the `BulkUpsert` operation is 0.5 RUs per KB of written data. For cost calculation, the data amount is rounded up to a multiple of 1 KB. The total cost of the operation is calculated as the sum of costs for all written rows, with the result rounded up to the nearest integer.

**Cost calculation example**

Let’s assume you are writing 4 data rows of 2,500 bytes, 100 bytes, 1,200 bytes, and 1,024 bytes with the `BulkUpsert` operation.

The cost of such an operation is:
> 0.5 RUs × 3 + 0.5 RUs × 1 + 0.5 RUs × 2 + 0.5 RUs × 1 = 3.5 RUs
>
> Total, rounded up to the nearest integer: 4 RUs

Where:
* 0.5: Cost in RUs per KB of written data.
* 3: Size of the first row in KB, rounded up (2,500 bytes = 1,024 bytes + 1,024 bytes + 452 bytes).
* 1: Size of the second row in KB, rounded up.
* 2: Size of the third row in KB, rounded up (1,200 bytes = 1,024 bytes + 176 bytes).
* 1: Size of the fourth row in KB.

## Building a secondary or vector index {#build-index}

The cost of building an index equals the total cost of the following operations:

- I/O operations whose cost includes the following:
  - Reading data from indexed and intermediate tables: [`ReadTable`](#read-table).
  - Writing data to indexed and intermediate tables: [`BulkUpsert`](#bulk-upsert).
- For vector indexes, the cost also includes the consumption of CPU computing resources.

You can cancel index building, in which case the cost will include the actual processed data amount and resources consumed before the cancellation.

### Building a secondary index {#secondary-index}

For a secondary index, the cost is calculated as the sum of costs for read operations from the indexed table and write operations to the index table.

### Building a vector index {#vector-index}

For a vector index, the cost also accounts for its building nuances and increased consumption of computing resources.

For the [`vector_kmeans_tree`](https://ydb.tech/docs/ru/dev/vector-indexes?version=main#kmeans-tree-type) type of vector index:

- The total amount of read data is approximately $5 * ${levels} of the indexed table size, where `levels` is the number of index tree levels.
- The total amount of written data is approximately $${levels} of the indexed table size.
- Computing resource consumption includes all CPU usage time during all index building stages.

The final cost is determined as follows: you calculate the sum of data read/write (IO) operation costs and, separately, the CPU consumption cost, and then take the maximum one of these two values as the final cost of building the index.

