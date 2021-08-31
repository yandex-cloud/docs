---
editable: false
---
# Pricing policy for {{ ydb-name }} serverless mode

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

When using {{ ydb-name }} in serverless mode, a fee is charged for each request made to the database. Users don't have to specify the resources they need: the database quickly adapts to changes in the user load within the [quotas](../concepts/limits.md) allocated for the user. Apart from requests, the user pays for the data stored in {{ ydb-name }} on an hourly basis. Other operations, such as restoring data from backups, are charged additionally.

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

{{ ydb-name }} serverless mode supports multiple APIs for data operations: YDB API and Document API (an Amazon DynamoDB-compatible API). These APIs let you express a broad variety of requests, ranging from single reads and writes using a key to complex SQL requests with multi-table joins followed by the grouping and sorting of the result. Each of these operations consumes a certain amount of database resources depending on the operation complexity.

The concept of a request unit (RU) is used for estimating the cost of an arbitrary request. 1 RU is the reference cost of reading a table row with a size of up to 4KB using a primary key. Request units help you abstract resources, such as the CPU, Memory, and Disk I/O used by the operation. Any request to {{ ydb-name }}, regardless of the API used, has a cost in terms of RU. Request unit per second (or RU/s) is a measure of the database throughput, amount of resources consumed, and the cost of running the database.

{% else %}

{{ ydb-full-name }} serverless operation mode supports multiple ways to work with data:

* Document API: Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.
* The YDB API and its implementations like the [YDB CLI](../quickstart/examples-ydb-cli.md) and [YDB SDK](../sdk/index.md) for [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk), and [Go](https://github.com/yandex-cloud/ydb-go-sdk). You can use this API to perform operations on YDB tables.

To calculate the cost of requests in {{ ydb-short-name }}, we use a concept called **request units** (**RU**). Each executed request, depending on its type, complexity, and data size, consumes a certain amount of RUs. The total cost of all executed requests to {{ ydb-short-name }} is the sum of the cost of each request in RU.

{% endif %}

#### Document API

{% if audience != "external" %}

Table 1 shows the costs of some Document API operations in terms of request units. A row read/write operation is an operation involving a single table row within such API calls as GetItem/BatchGetItem/PutItem. The cost of a composite data operation (for example, BatchGetItem) is the sum of individual call costs. For example, the cost of BatchGetItem equals the total cost of GetItem call costs per key. An item read/write operation within a transaction is an operation that is part of such API calls as TransactGetItems/TransactWriteItems. The request cost is the sum of costs for the items involved in the operation.

{% else %}

The cost of requests to the Document API depends on the type of DB operations that are performed within the request and the amount of data that the operation is performed on. If the request consists of multiple operations (for example, BatchWriteItem), its cost is the sum of operation costs.

{% endif %}

| Operation type | Data size | Cost in request units (RU) |
| ------------------------------------------ | ------------- | ------------------- |
| Item read operation (GetItem, BatchGetItem, Query, and Scan methods) | 4 KB | 1 |
| Item read operation performed within a transaction (TransactGetItems) | 4 KB | 2 |
| Item write operation (PutItem, BatchWriteItem, and UpdateItem) | 1 KB | 2 |
| Item write operation performed within a transaction (TransactWriteItems) | 1 KB | 4 |
| Item delete operation (DeleteItem) | ignored | 2 |
| DB schema operation (CreateTable, DeleteTable, DescribeTable, and ListTables) | Free | Free |

When estimating the cost of a request:

* A read request that returned no result is always valued at 1 RU.
* An item write request that returned no results is always valued at 2 RU.
* An item write request within a transaction that returned no result is always valued at 4 RU.
* Read requests are rounded up to a multiple of 4 KB.
* Write requests are rounded up to a multiple of 1 KB.

#### YDB API

{% if audience != "external" %}

Expressive capabilities of the YDB API let you formulate a wide variety of requests. Data operations are not limited to single-row or row-range requests to read, write, or modify data. When executing each request, {{ ydb-name }} Serverless keeps track of the resources consumed:

* Rows read, as items and bytes.
* Rows written, as items and bytes.
* CPU usage time of the request.

Resources consumed by the operation are converted to request units as in the case of the Document API for read/write operations. Please note that besides the bytes written/read, request unit also includes the benchmark CPU usage time. Some YQL requests might use a lot of CPU time on small data amounts. In this case, the request cost is calculated as the maximum of:

* Request units consumed by data reads and writes.
* CPU usage time divided by the benchmark CPU usage per request unit.

Read the document <span style="color: red;">Viewing request cost (add a link)</span> to learn more about how {{ ydb-name }} Serverless users can view and evaluate the cost of executing a specific request.

{% else %}

The cost of a request to the YDB API factors in the following:

* **CPU time**

   Includes the CPU time used for parsing and building a request. The CPU usage time is rounded down to a multiple of 1.5 ms.

* **Read operations**

   The cost of read operations is assessed three ways:
   * The total amount of data read. The amount is rounded up to a multiple of 4 KB.
   * Number of rows read.
   * The CPU time used for read operations. The CPU usage time is rounded down to a multiple of 1.5 ms.

   All values are converted to RU. The total cost of read operations is assumed to be equal to the largest of these values.

* **Write operations**

   The cost of write operations is assessed three ways:
   * The total amount of data written. The data amount is rounded up to a multiple of 1 KB.
   * Number of rows written.
   * The CPU time used for write operations. The CPU usage time is rounded down to a multiple of 1.5 ms.

   All values are converted to RU. The total cost of write operations is assumed to be equal to the largest of these values.

* **Delete operations**

   The cost of delete operations is assessed three ways:
   * The total amount of data deleted. The data amount is rounded up to a multiple of 1 KB.
   * Number of rows deleted.
   * The CPU time used for delete operations. The CPU usage time is rounded down to a multiple of 1.5 ms.

The total cost of the request is calculated as the sum of all components.

| Estimated parameter | Unit size | Cost in request units (RU) |
| ------------------------------------------ | ----------------- | ------------------- |
| Amount of data read | 4 KB | 1 |
| Amount of data written | 1 KB | 2 |
| Amount of data deleted | 1 KB | 2 |
| Item read operation | 1 item | 1 |
| Item write operation | 1 item | 2 |
| Item delete operation | 1 item | 2 |
| CPU usage time | 1.5 ms | 4 |
| Creating, updating, and deleting table schemas, getting a table description, getting a list of tables, creating and deleting directories | Free | Free |

##### Specifics of cost calculation for certain operations

* **ReadTable**
The ReadTable operation lets you efficiently read large ranges of data from a table. The cost of the query only depends on the amount of data read and is 128 RU per 1 MB. When calculating the cost, the amount is rounded up to a multiple of 1 MB.

* **BulkUpsert**
BulkUpsert lets you efficiently upload data to the database. The cost of writing a row using the BulkUpsert operation is 0.5 RU per 1 KB of written data. When calculating the cost, the data amount is rounded up to a multiple of 1 KB. The total cost of the operation is calculated as the sum of the cost of all rows written, rounded up to the nearest integer.

   **Example of cost calculation**

   For example, as part of the BulkUpsert operation, you write four data items of 2500 bytes, 100 bytes, 1200 bytes, and 1024 bytes.

   The cost of this operation is:

   > 0.5 RU × 3 + 0.5 RU × 1 + 0.5 RU × 2 + 0.5 RU × 1 = 3.5 RU
   > Total, rounded up to the nearest integer: 4 RU

   Where:
   * 0.5 is the cost in request units per 1 KB of written data.
   * 3 is the rounded up size of the first item in KB (2500 bytes = 1024 bytes + 1024 bytes + 452 bytes).
   * 1 is the rounded up size of the second item in KB.
   * 2 is the rounded up size of the third item in KB (1200 bytes = 1024 bytes + 176 bytes).
   * 1 is the size of the fourth item in KB.

* **Building a secondary index**
The cost of building an index is the sum of the cost of ReadTable from the source table and BulkUpsert to the index table. The total amount of work is charged: the number and size of rows read from the source table and written to the index table. The index building process can be canceled by the user. The canceled index-building operations are also charged based on the amount of work done before the operation was canceled.

{% endif %}

{% if audience != "external" %}

#### Using parameterized prepared requests in the YDB API

Parameterized prepared requests <span style="color: red;">link</span> let you significantly reduce the overhead of request execution by saving the CPU time on parsing and optimizing requests of the same type. The ```PrepareDataQuery``` call that prepares the request is rated based on the CPU resources used and measured in request units. The cost of preparing a request depends on the request complexity.

#### ReadTable operation

The ReadTable operation <span style="color: red;">(add a link)</span> lets you efficiently read large ranges of data from a table. The operation is rated per 1 MB of the data read. The cost of reading 1 MB is 128 RU. The size of the read data is rounded up to integer megabytes.

#### BulkUpsert operation

The BulkUpsert operation <span style="color: red;">(add a link)</span> lets you upload data to a database more efficiently. Writing data using BulkUpsert is 2 times cheaper than writing data using the Document API, costing you 1 RU per row up to 1 KB in size. If a row size is more than 1 KB, the row size is rounded up to the next integer kilobyte and divided by 1 KB. The resulting RU amount is the cost of the request.

<span style="color: red;">CopyTable. What do I do with a backup???</span>

#### Operations with database schema

Operations with a database schema, such as creating and deleting tables, changing the table schema, listing tables, and getting table descriptions, are not rated. However, there's a limit on the number of such operations. For more information about limits, see <span style="color: red;">Quotas (add a link)</span>.

{% endif %}

### Amount of data stored {#rules-storage}

{% if audience != "external" %}

You don't have to explicitly allocate storage for your data in {{ ydb-name }} Serverless. Data storage capacity is allocated automatically by the system. The data written by the user is stored in special {{ ydb-name }} data structures optimized for efficient writing, reading using a primary key, and other operations. The amount of data stored in {{ ydb-name }} Serverless is calculated as the storage allocated for the specified data structures. For example, creating a global index increases the storage size by the size of this index. {{ ydb-name }} Serverless continuously monitors the size of tables in order to promptly respond to the decreased or increased stored data size.

{% else %}

In serverless mode, data storage capacity is allocated automatically. The amount of stored data is calculated as the total amount of user and service data that is stored in the database. For example, creating a global index increases the storage size by the size of this index.

{% endif %}

### Creating backups {#rules-backup-storage}

{% if audience != "external" %}

{{ ydb-name }} Serverless provides automatic periodic backups of the database once a day. The backup is saved in {{ objstorage-full-name }}. The system stores the 2 latest database backups. If the database is deleted, its latest backup is stored for 2 days. This backup service is provided free-of-charge.

Users can run on-demand backups of their databases in {{ ydb-name }} Serverless free-of-charge. In this case, the backup cost is calculated based on the price per 1 GB of the data exported from {{ ydb-name }} Serverless. The data size is rounded up to the next integer GB. Access to {{ objstorage-full-name }} is paid additionally based on the applicable prices.

If you upload data using the ```ydb tools dump``` utility, billing is based on the rates for the ReadTable operation.

{% else %}

#### Automatic backups {#rules-auto-backup-storage}

{{ ydb-name }} automatically creates and stores two full backups for the last two days free-of-charge. No fee is charged for storing automatic backups.

#### On-demand backups {#rules-auto-backup-storage}

You can force a database backup with a copy saved in {{ objstorage-full-name }}. The cost of this operation depends on the amount of data copied. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you upload data using the ```ydb tools dump``` utility, billing is based on the rates for the ReadTable operation.

{% endnote %}

{% endif %}

### Restoring data from backups {#rules-backup-restore}

{% if audience != "external" %}

{{ ydb-name }} Serverless supports restoring databases and individual tables from a backup stored in Object Storage. Backup data is recovered on demand and rated at the recovery price per 1 GB. The data size is rounded up to the next integer GB.

If you restore data using the ```ydb tools restore``` utility, billing is based on the cost of writing a row to the DB for each restored row.

{% else %}

You can restore databases and individual tables from the backups stored in {{ objstorage-name }}. The cost of this operation depends on the amount of data restored. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you restore data using the ```ydb tools restore``` utility, billing is based on the cost of writing a row to the DB for each restored row.

{% endnote %}

{% endif %}

## Discount for committed volumes {#cvos}

{% if audience != "external" %}

In {{ ydb-name }}, you can commit to a certain database bandwidth expressed in request units and get a decent discount compared to on-demand requests. Commits are measured in request units per second against a database. Users can select a commit amount with a step of 100 RU/sec. A bandwidth commit of 100 RU/sec means that if the actual user's data load does not exceed 100 RU/sec, its cost is covered by the commit. Therefore, the data load of 80 RU/sec is fully covered by the commit. The data load in excess of the commit is charged at the prices for on-demand requests. It means that with an actual data load of 120 RU/sec and a commit of 100 RU/sec, the user pays for 20 RU/sec at the on-demand data operation price. If the user has not used up their commitment because the actual data load was less than the committed data load, the commitment expires. Pay-per-commitment is good for the users with a high continuous data load against their database.

Please note that the commitment is aggregated in a <span style="color: red;">5-minute</span> window. It means that if you pay for a commitment of 100 RU/sec, you don't have to consume 100 RU every second: the data load might fluctuate within the specified window. One second the data load might be 150 RU, and another second it might drop to 50 RU.

In the management console, you can see potential savings from using a CVoS at the current resource usage. You can also pre-estimate your monthly payments for the desired number of vCPUs and RAM.

<span style="color: red;">Strongly consider the necessity to refer to [CVoS](https://cloud.yandex.com/docs/billing/operations/purchase-cvos)</span>

{% if deploy != "arc" %}{% include [cvos](../_includes/pricing/cvos.md) %}{% endif %}

{% else %}

You can get a guaranteed discount on service resource usage when you plan for a month, a year, or three years ahead.

{{ ydb-name }} serverless mode provides {% if deploy != "arc" %} [CVoS](../../billing/concepts/cvos.md) {% else %} CVoS {% endif %}  for a particular amount of request units per second. You can choose the committed volume in 100 RU/s increments.

When calculating the actual consumption: the number of requests is averaged every five minutes. It means, for example, that if the commitment is 100 RU/s, you don't have to consume 100 RUs every second. Within the averaging interval, the load might vary and be 150 RU/s at one point and 50 RU/s at another.

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