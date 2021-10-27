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

{% if audience != "external" %}

{{ ydb-name }} serverless mode supports multiple APIs for data operations: the {{ ydb-short-name }} API and Document API (an Amazon DynamoDB-compatible API). These APIs let you make a broad variety of requests ranging from single reads and writes by a key to complex SQL queries with multi-table joins followed by grouping and sorting the result. Each of these operations consumes a certain amount of database resources depending on the operation complexity.

The concept of a request unit (RU) is used for estimating the cost of an arbitrary request. 1 RU is the reference cost of reading a table row with a size of up to 4 KB using a primary key. Request units help you abstract resources, such as the CPU, Memory, and Disk I/O used by the operation. Any request to {{ ydb-name }}, regardless of the API used, has a cost in terms of RU. Request unit per second (or RU/s) is a measure of the database throughput, resources consumed, and the cost of running the database.

{% else %}

{{ ydb-full-name }} serverless operation mode supports multiple ways to work with data:

* Document API: Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.
* The {{ ydb-short-name }} API and its implementations as the [{{ ydb-short-name }} CLI](../quickstart/yql-api/ydb-cli.md) and [{{ ydb-short-name }} SDK](../sdk/index.md) for [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk), and [Go](https://github.com/yandex-cloud/ydb-go-sdk). You can use this API to perform operations on {{ ydb-short-name }} tables.

To calculate the cost of requests in {{ ydb-short-name }}, we use a concept called **request units** (**RU**). Each executed request, depending on its type, complexity, and data size, consumes a certain amount of RUs. The total cost of all executed requests to {{ ydb-short-name }} is the sum of the RU costs for each request.

{% endif %}

#### Document API {#document-api}

{% if audience != "external" %}

Table 1 shows the RU costs of some Document API operations. A row read/write operation is an operation with a single table row using such API calls as `GetItem`/`BatchGetItem`/`PutItem`. The cost of a batch data operation (for example, `BatchGetItem`) is the sum of individual call costs. For example, the cost of `BatchGetItem` equals the total cost of `GetItem` call costs per key. A row read/write operation within a transaction is an operation ran by such API calls as `TransactGetItems`/`TransactWriteItems`. The request cost is the sum of costs for the rows involved in the operation.

{% else %}

The cost per document requested via the Document API is equal to the RU cost per unit multiplied by the document size in blocks. The size in blocks equals the size in bytes divided by the block size and rounded up. Requesting a non-existent document is the same as reading a document with a size of 1 block. If a request processes multiple documents (for example, `BatchGetItem`), the total cost is equal to the sum of costs per document.

{% endif %}

| Request type | Unit cost | Block size |
| ---------------------------------------------------------------------------------- | ----------------- | -------------- |
| Reading (`GetItem`, `BatchGetItem`, `Query`, `Scan`) | 1 RU | 4 KB |
| Reading during a transaction (`TransactGetItems`) | 2 RU | 4 KB |
| Writing (`PutItem`, `BatchWriteItem`, `UpdateItem`) | 2 RU | 1 KB |
| Writing during a transaction (`TransactWriteItems`) | 4 RU | 1 KB |
| Deleting (`DeleteItem`) | 2 RU | N/A |
| Working with the database schema (`CreateTable`, `DeleteTable`, `DescribeTable`, `ListTables`) | 0 RU | N/A |

#### {{ ydb-short-name }} API {#ydb-api}

{% if audience != "external" %}

Expressive capabilities of the {{ ydb-short-name }} API let you formulate a wide variety of requests. Data operations are not limited to single-row or row-range requests to read, write, or modify data. When executing each request, {{ ydb-name }} Serverless keeps track of the resources consumed:

* Rows read, as items and bytes.
* Rows written, as items and bytes.
* CPU usage time of the request.

Resources consumed by the operation are converted to request units as in the case of the Document API for read/write operations. Please note that besides the bytes written/read, a request unit also includes the benchmark CPU usage time. Some YQL requests might use a lot of CPU time on small amounts of data. In this case, the request cost is calculated as the maximum of:

* Request units consumed by data reads and writes.
* CPU usage time divided by the benchmark CPU usage per request unit.

Read the document <span style="color: red;">Viewing request cost (add a link)</span> to learn more about how {{ ydb-name }} Serverless users can view and evaluate the cost of a given request.

{% else %}

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

{% endif %}

{% if audience != "external" %}

#### Using set parameterized requests in the {{ ydb-short-name }} API

Set parameterized requests <span style="color: red;">link</span> let you significantly reduce request execution overhead by saving the CPU time on parsing and optimizing requests of the same type. The ```PrepareDataQuery``` call that prepares the request is billed based on the CPU resources used and measured in request units. The cost of preparing a request depends on the request complexity.

#### ReadTable operation

The `ReadTable` operation <span style="color: red;">(add a link)</span> lets you efficiently read large ranges of data from a table. The operation is charged per 1 MB of data read. The cost of reading 1 MB is 128 RU. The size of the read data is rounded up to the nearest full megabyte.

#### BulkUpsert operation

The `BulkUpsert` operation <span style="color: red;">(add a link)</span> lets you upload data to a database more efficiently. Writing data using `BulkUpsert` is 2x cheaper than writing data using the Document API and costs 1 RU per row up to 1 KB in size. If a row size is more than 1 KB, it is rounded up to the next full kilobyte and divided by 1 KB. The resulting RU amount is the request cost.

<span style="color: red;">CopyTable. What do I do with a backup?</span>

#### Operations with database schemas

Operations with a database schema, such as creating and deleting tables, changing the table schema, listing tables, and getting table descriptions, are not billed. However, there's a limit on the number of such operations. For more information about limits, see <span style="color: red;">Quotas (add link)</span>.

{% endif %}

### Amount of data stored {#rules-storage}

{% if audience != "external" %}

You don't have to explicitly allocate storage for your data in {{ ydb-name }} Serverless. The system automatically allocates data storage capacity. The data written by the user is stored in special {{ ydb-name }} data structures optimized for efficient writing, reading using a primary key, and other operations. The amount of data stored in {{ ydb-name }} Serverless is calculated as the storage allocated for the specified data structures. For example, creating a global index increases the storage size by the size of this index. {{ ydb-name }} Serverless continuously monitors the size of tables in order to promptly respond to an increase or decrease in the amount of stored data.

{% else %}

In serverless mode, data storage capacity is allocated automatically. The amount of stored data is calculated as the total amount of user and service data stored in the database. For example, creating a global index increases the total storage size by the index size.

{% endif %}

### Creating backups {#rules-backup-storage}

{% if audience != "external" %}

{{ ydb-name }} Serverless provides automatic periodic backups of the database once a day. The backup is saved in {{ objstorage-full-name }}. The system stores two of the latest database backups. If the database is deleted, its latest backup is stored for 2 days. This backup service is provided free-of-charge.

Users can run on-demand backups of their databases in {{ ydb-name }} Serverless free of charge. In this case, the backup cost is calculated based on the price per 1 GB of data exported from {{ ydb-name }} Serverless. The data size is rounded up to the next full gigabyte. Access to {{ objstorage-full-name }} is billed additionally based on the applicable prices.

If you export data using the ```ydb tools dump``` utility, billing is based on the rates for the `ReadTable` operation.

{% else %}

#### Automatic backups {#rules-auto-backup-storage}

{{ ydb-name }} automatically creates and stores two full backups for the last two days free of charge. No fee is charged for storing automatic backups.

#### On-demand backups {#rules-auto-backup-storage}

You can force a database backup with a copy saved in {{ objstorage-full-name }}. The cost of this operation depends on the amount of data copied. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you export data using the ```ydb tools dump``` utility, billing is based on the rates for the `ReadTable` operation.

{% endnote %}

{% endif %}

### Restoring data from backups {#rules-backup-restore}

{% if audience != "external" %}

{{ ydb-name }} Serverless supports restoring databases and individual tables from a backup stored in Object Storage. Backup data is recovered on demand and charged at the recovery price per 1 GB. The data size is rounded up to the next full gigabyte.

If you restore data using the ```ydb tools restore``` utility, billing is based on the cost of writing a row to the DB for each restored row.

{% else %}

You can restore databases and individual tables from the backups stored in {{ objstorage-name }}. The cost of this operation depends on the amount of data restored. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you restore data using the ```ydb tools restore``` utility, billing is based on the cost of writing a row to the DB for each restored row.

{% endnote %}

{% endif %}

## Discount for committed volumes {#cvos}

{% if audience != "external" %}

In {{ ydb-name }}, you can commit to a certain database bandwidth expressed in request units and get a fair discount compared to on-demand requests. Committed volumes are measured in database request units per second. Users can choose the committed volume in 100 RU/sec increments. A bandwidth commit of 100 RU/sec means that if the actual user's data load does not exceed 100 RU/sec, its cost is covered by the commitment. Therefore, the data load of 80 RU/sec is fully covered by the commitment. The data load in excess of the commitment is charged at the prices for on-demand requests. It means that with an actual data load of 120 RU/sec and a commitment of 100 RU/sec, the user pays for 20 RU/sec at the on-demand data operation price. If the user has not used up their commitment because the actual data load was less than the committed data load, the commitment expires. Pay-per-commitment is good for the users with a high continuous data load against their database.

Please note that the commitment is aggregated at  <span style="color: red;">5-minute</span> intervals. This means that if you pay for a commitment of 100 RU/sec, you don't have to consume 100 RU every second: the data load might fluctuate within the given interval. At one second the data load might be 150 RU, but at another second it might drop to 50 RU.

In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also forecast your monthly payments for the desired number of vCPUs and RAM.

<span style="color: red;">Deeply reflect on whether we should mention [CVoS](https://cloud.yandex.com/docs/billing/operations/purchase-cvos)</span>

{% if deploy != "arc" %}

{% include [cvos](../_includes/pricing/cvos.md) %}

{% endif %}

{% else %}

You can get a guaranteed discount on service resource usage when you commit for a month, year, or three years.

{{ ydb-name }} Serverless mode provides {% if deploy != "arc" %} [CVoS](../../billing/concepts/cvos.md) {% else %} CVoS {% endif %} for a particular amount of request units per second. You can choose the committed volume in 100 RU/sec increments.

When calculating the actual consumption, the number of requests is averaged every five minutes. This means that if the commitment is 100 RU/s, you don't have to consume 100 RU every second. Within the averaging interval, the load might vary and be 150 RU/s at one point and 50 RU/s at another.

{% endif %}

## Pricing {#prices}

{% if region == "ru" %}

{% include notitle [rub-serverless](../../_pricing/ydb/rub-serverless.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-serverless](../../_pricing/ydb/kzt-serverless.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-serverless](../../_pricing/ydb/usd-serverless.md) %}

{% endif %}

{% if region == "ru" %}

{% include notitle [rub-egress-traffic.md](../../_pricing/rub-egress-traffic.md) %}

{% endif %}

{% if region == "kz" %}

{% include notitle [kzt-egress-traffic.md](../../_pricing/kzt-egress-traffic.md) %}

{% endif %}

{% if region == "int" %}

{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

{% endif %}

{% if audience != "external" %}

## Examples of cost calculation {#simple-example}

{% list tabs %}

- Simple example

  Simple example here

- Advanced example

  Advanced example here

{% endlist %}

{% endif %}