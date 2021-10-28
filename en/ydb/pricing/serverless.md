---
editable: false
---

# Pricing policy for {{ ydb-name }} serverless mode

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

When you use {{ ydb-name }} in serverless mode, you are billed for each request made to the database. Users don't have to indicate the resources they need: the database quickly adapts to changes in the user load within the [quotas](../concepts/limits.md) allocated for the user. Apart from requests, the user pays for the data stored in {{ ydb-name }} on an hourly basis. Other operations, such as restoring data from backups, are charged additionally.

## What goes into the cost of using {{ ydb-name }} serverless mode {#rules}

When using {{ ydb-name }} in serverless mode, you pay for the following:

* Data operations.
* The amount of stored data, including service data, such as indexes.
* Additional user operations, like restoring data from backups.

Other consumed resources to be additionally paid for:

* The space used in {{ objstorage-name }} to store on-demand backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Data operations and request units {#rules-ru}


{{ ydb-full-name }} serverless operation mode supports multiple ways to work with data:

* Document API: Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.
* The {{ ydb-short-name }} API and its implementations as the [{{ ydb-short-name }} CLI](../quickstart/yql-api/ydb-cli.md) and [{{ ydb-short-name }} SDK](../sdk/index.md) for [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk), and [Go](https://github.com/yandex-cloud/ydb-go-sdk). You can use this API to perform operations on {{ ydb-short-name }} tables.

To calculate the cost of requests in {{ ydb-short-name }}, we use a concept called **request units** (**RU**). Each executed request, depending on its type, complexity, and data size, consumes a certain amount of RUs. The total cost of all executed requests to {{ ydb-short-name }} is the sum of the RU costs for each request.

#### Document API {#document-api}


The cost per document requested via the Document API is equal to the RU cost per unit multiplied by the document size in blocks. The size in blocks equals the size in bytes divided by the block size and rounded up. Requesting a non-existent document is the same as reading a document with a size of 1 block. If a request processes multiple documents (for example, `BatchGetItem`), the total cost is equal to the sum of costs per document.

| Request type | Unit cost | Block size |
| ---------------------------------------------------------------------------------- | ----------------- | -------------- |
| Reading (`GetItem`, `BatchGetItem`, `Query`, `Scan`) | 1 RU | 4 KB |
| Reading during a transaction (`TransactGetItems`) | 2 RU | 4 KB |
| Writing (`PutItem`, `BatchWriteItem`, `UpdateItem`) | 2 RU | 1 KB |
| Writing during a transaction (`TransactWriteItems`) | 4 RU | 1 KB |
| Deleting (`DeleteItem`) | 2 RU | N/A |
| Working with the database schema (`CreateTable`, `DeleteTable`, `DescribeTable`, `ListTables`) | 0 RU | N/A |

#### {{ ydb-short-name }} API {#ydb-api}


Backend resources are used to execute requests over the {{ ydb-short-name }} API. Information about consumed resources is available in the request statistics.

To evaluate the {{ ydb-short-name }} API request cost, the CPU cost and the I/O cost are calculated. A maximum from the calculated values is selected.

* CPU cost.

  The CPU time spent to compile the request is added to the CPU time spent at each step of query execution. This sum is divided by the CPU time increment of 1.5 ms, rounded down and converted to RU based on the service plan from the table below.

  Cached requests aren't recompiled. To use caching, use `bind variables` in your requests and enable caching of the request execution plan.

* I/O cost.

  The following values are calculated:

  * The number of disk reads. The number of read records and data blocks is compared, and the largest of them is selected. The number of blocks is calculated by dividing the amount of bytes read by the block size of 4 KB and rounding the result up.
  * The number of disk writes. The number of written rows and data blocks is compared, and the largest of them is selected. The number of blocks is calculated by dividing the amount of bytes written by a block size of 1 KB and rounding the value up.

  This includes I/O operations on tables and indexes. Row deletes are billed based on their count.

  The number of reads and writes is converted to RU based on the service plan from the table below with the resulting costs summed up.

{% note warning %}

Some conversions involve data reads or deletes before writes, and this may affect the request cost.

{% endnote %}

Unit costs in RU:

| Estimated parameter | Cost |
| :--- | :---: |
| One CPU time increment | 1 RU |
| One read | 1 RU |
| One write | 2 RU |

The following operations are not billed:

* Creating, updating, and deleting table schemas.
* Getting a description and list of tables.
* Creating and deleting directories.

{% cut "Example of calculating the cost of a request" %}

Request statistics:

```text
query_phases {
  ...
  table_access {
    ...
    reads {
      rows: 2
      bytes: 16
    }
    ...
  }
  cpu_time_us: 475
  ...
}
query_phases {
  ...
  table_access {
    ...
    updates {
      rows: 2
      bytes: 2456
    }
    ...
  }
  cpu_time_us: 514
  ...
}
compilation {
  ...
  cpu_time_us: 4062
}
process_cpu_time_us: 870
```

Where:

* `query_phases[].cpu_time_us`: The CPU time used for executing the request, in microseconds.
* `compilation.cpu_time_us`: The CPU time used for compiling the request, in microseconds.
* `process_cpu_time_us`: The CPU time used for interaction control, in microseconds.
* `query_phases[].reads.rows`: The number of data rows read.
* `query_phases[].reads.bytes`: The number of data bytes read.
* `query_phases[].updates.rows`: The number of data rows written.
* `query_phases[].updates.bytes`: The number of data bytes written.

To evaluate the CPU cost, the request's total CPU time is divided by 1.5 ms, `( 475 + 514 + 4062 + 870 ) / 1500 = 3.95`. The result is rounded down and converted to RU:

```text
3 × 1 RU = 3 RU
```

To get the I/O cost:

* The number of disk reads of rows and blocks is calculated, and the maximum is selected:
  * 2 rows read, the number of operations is 2.
  * 16 bytes read, `16 / ( 4 × 1024 ) = 0.004`, the result is rounded up, the number of operations is 1.

  The number of read operations is 2.

* The number of disk writes for rows and blocks is calculated, and the maximum is selected:
  * 2 rows written, the number of operations is 2.
  * 2456 bytes written, `2456 / 1024 = 2.398`, the result is rounded up, the number of operations is 3.

  The number of write operations is 3.

I/O cost:

```text
2 × 1 RU + 3 × 2 RU = 8 RU
```

The request cost is 8 RU.

{% endcut %}

##### Specifics of cost calculation for certain operations

* **ReadTable**
   The `ReadTable` operation lets you efficiently read large ranges of data from a table. The request cost only depends on the amount of data read based on the rate of 128 RU per 1 MB. When calculating the cost, the amount is rounded up to a multiple of 1 MB.

* **BulkUpsert**
   `BulkUpsert` lets you efficiently upload data to the database. The cost of writing a row using the `BulkUpsert` operation is 0.5 RU per 1 KB of written data. When calculating the cost, the data amount is rounded up to a multiple of 1 KB. The total cost of the operation is calculated as the sum of costs for all rows written, with the result rounded up to the nearest integer.

   **Example of cost calculation**

   For example, as part of the `BulkUpsert` operation, you write four data items: 2500 bytes, 100 bytes, 1200 bytes, and 1024 bytes.

   The cost of this operation is:

   > 0.5 RU × 3 + 0.5 RU × 1 + 0.5 RU × 2 + 0.5 RU × 1 = 3.5 RU
   >
   > Total, rounded up to the nearest integer: 4 RU

   Where:
   * 0.5 is the RU cost per 1 KB of written data.
   * 3 is the rounded size of the first row in KB (2500 bytes = 1024 bytes + 1024 bytes + 452 bytes).
   * 1 is the rounded size of the second row in KB.
   * 2 is the rounded size of the third row in KB (1200 bytes =  1024 bytes + 176 bytes).
   * 1 is the size of the fourth row in KB.

* **Building a secondary index**
   The cost of building an index is the sum of the cost of `ReadTable` from the source table and `BulkUpsert` to the index table. The total amount of work is charged: the number and size of rows read from the source table and written to the index table. The index building process can be canceled by the user. The canceled index-building operations are also billed based on the amount of work done before the operation was canceled.


### Amount of data stored {#rules-storage}


In serverless mode, data storage capacity is allocated automatically. The amount of stored data is calculated as the total amount of user and service data stored in the database. For example, creating a global index increases the total storage size by the index size.

### Creating backups {#rules-backup-storage}


#### Automatic backups {#rules-auto-backup-storage}

{{ ydb-name }} automatically creates and stores two full backups for the last two days free of charge. No fee is charged for storing automatic backups.

#### On-demand backups {#rules-auto-backup-storage}

You can force a database backup with a copy saved in {{ objstorage-full-name }}. The cost of this operation depends on the amount of data copied. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you export data using the ```ydb tools dump``` utility, billing is based on the rates for the `ReadTable` operation.

{% endnote %}

### Restoring data from backups {#rules-backup-restore}


You can restore databases and individual tables from the backups stored in {{ objstorage-name }}. The cost of this operation depends on the amount of data restored. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you restore data using the ```ydb tools restore``` utility, billing is based on the cost of writing a row to the DB for each restored row.

{% endnote %}

## Discount for committed volumes {#cvos}


You can get a guaranteed discount on service resource usage when you commit for a month, year, or three years.

{{ ydb-name }} Serverless mode provides [CVoS](../../billing/concepts/cvos.md) for a particular amount of request units per second. You can choose the committed volume in 100 RU/sec increments.

When calculating the actual consumption, the number of requests is averaged every five minutes. This means that if the commitment is 100 RU/s, you don't have to consume 100 RU every second. Within the averaging interval, the load might vary and be 150 RU/s at one point and 50 RU/s at another.

## Pricing {#prices}




{% include notitle [usd-serverless](../../_pricing/ydb/usd-serverless.md) %}




{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

