---
editable: false
---
# Pricing policy for serverless mode {{ ydb-name }}

{% include [currency-choice](../_includes/pricing/currency-choice.md) %}

When using {{ ydb-name }} in serverless mode, a fee is charged for each request made to the database. You don't need to specify what resources are required, as the database quickly adapts to changes in the user load within the [quotas](../concepts/limits.md) allocated to the user. Apart from requests, the user pays for the data stored in {{ ydb-name }} on an hourly basis. Other operations, such as restoring data from backups, are charged additionally.

## What goes into the cost of using serverless mode {{ ydb-name }} {#rules}

When using {{ ydb-name }} in serverless mode, you pay for the following:

* Data operations.
* The amount of stored data, including service data, such as indexes.
* Additional user operations, like restoring data from backups.

Other consumed resources to be additionally paid for:

* The space used in {{ objstorage-name }} to store on-demand backups.
* Outgoing traffic from {{ yandex-cloud }} to the internet.

{% include [pricing-gb-size](../_includes/pricing/pricing-gb-size.md) %}

### Data operations and the request unit {#rules-ru}

{{ ydb-full-name }} serverless operation mode supports multiple ways to work with data:

* Document API: Amazon DynamoDB-compatible HTTP API. You can use this API to perform operations on document tables.
* The YDB API and its implementations like the [YDB CLI](../quickstart/examples-ydb-cli.md) and [YDB SDK](../sdk/index.md) for [Java](https://github.com/yandex-cloud/ydb-java-sdk), [Python](https://github.com/yandex-cloud/ydb-python-sdk), [Node.js](https://github.com/yandex-cloud/ydb-nodejs-sdk), [PHP](https://github.com/yandex-cloud/ydb-php-sdk), and [Go](https://github.com/yandex-cloud/ydb-go-sdk). You can use this API to perform operations on YDB tables.

To calculate the cost of requests in {{ ydb-short-name }}, we use a concept called **request units** (**RU**). Each executed request, depending on its type, complexity, and data size, consumes a certain number of RU. The total cost of all executed requests to {{ ydb-short-name }} is the sum of the cost of each request in RU.

#### Document API

The cost of requests to the Document API depends on the type of DB operations that are performed within the request and the amount of data that the operation is performed on. If the request consists of multiple operations (for example, BatchWriteItem), its cost is the sum of operation costs.

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

The cost of a request to the YDB API factors in the following:

* **CPU usage time**

   The CPU time used for parsing and compiling a request is taken into account. The CPU usage time is rounded down to a multiple of 1.5 ms.

* **Read operations**

   The cost of read operations is assessed three ways:
   * The total amount of data read. The amount is rounded up to a multiple of 4 KB.
   * Number of rows read.
   * The CPU time used for read operations. The CPU usage time is rounded down to a multiple of 1.5 ms.

   All values are converted to RU.  The total cost of read operations is assumed to be equal to the largest of these values.

* **Write operations**

   The cost of write operations is assessed three ways:
   * The total amount of data written. The amount is rounded up to a multiple of 1 KB.
   * Number of rows written.
   * The CPU time used for write operations. The CPU usage time is rounded down to a multiple of 1.5 ms.

   All values are converted to RU.  The total cost of write operations is assumed to be equal to the largest of these values.

* **Delete operations**

   The cost of delete operations is assessed three ways:
   * The total amount of data deleted. The amount is rounded up to a multiple of 1 KB.
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

   For example, as part of a BulkUpsert operation, you write four rows of data of 2500 bytes, 100 bytes, 1200 bytes, and 1024 bytes.

   The cost of such an operation is:
   > 0.5 RU × 3 + 0.5 RU × 1 + 0.5 RU × 2 + 0.5 RU × 1 = 3.5 RU
   >
   > Total, after rounding up: 4 RU

   Where:
   * 0.5 is the cost in request units per 1 KB of written data.
   * 3 is the first row size in KB after rounding up (2500 bytes = 1024 bytes + 1024 bytes + 452 bytes).
   * 1 is the second row size in KB after rounding up.
   * 2 is the third row size in KB after rounding up (1200 bytes = 1024 bytes + 176 bytes).
   * 1 is the fourth row size in KB.

* **Building a secondary index**
The cost of building an index is the sum of the cost of ReadTable from the source table and BulkUpsert to the index table. The total amount of work is charged: the number and size of rows read from the source table and written to the index table. The index building process can be canceled by the user. The canceled index-building operations are also charged based on the amount of work done before the operation was canceled.

### The amount of stored data {#rules-storage}

In serverless mode, data storage capacity is allocated automatically. The amount of stored data is calculated as the total amount of user and service data that is stored in the database. For example, creating a global index increases the storage size by the size of this index.

### Creating backups {#rules-backup-storage}

#### Automatic backups {#rules-auto-backup-storage}

{{ ydb-name }} automatically creates and stores two full backups for the last two days for free. No fee is charged for storing automatic backups.

#### On-demand backups {#rules-auto-backup-storage}

You can force a database backup with a copy saved in {{ objstorage-full-name }}. The cost of this operation depends on the amount of data copied. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{{ objstorage-full-name }}. The cost of storing backups is calculated according to the [pricing policy](../../storage/pricing.md) for {{ objstorage-full-name }}.

{% note warning %}

If you upload data using the ```ydb tools dump``` utility, billing is based on the rates for the ReadTable operation.

{% endnote %}

### Restoring data from backups {#rules-backup-restore}

You can restore databases and individual tables from backups that are stored in {{ objstorage-name }}. The cost of this operation depends on the amount of data restored. When calculating the cost, the actual amount is rounded up to a multiple of 1 GB.

{% note warning %}

If you restore data using the ```ydb tools restore``` utility, billing is based on the cost of writing a row to the DB for each restored row.

{% endnote %}

## Discount for committed volumes of services (CVoS) {#cvos}

You can get a guaranteed discount on service resource usage when you plan for a month, a year, or three years ahead.

{{ ydb-name }} serverless mode provides a [CVoS](../../billing/concepts/cvos.md) for a particular number of requests in RU per second. You can choose the committed volume in 100 RU/s increments.

When calculating the actual consumption, the number of requests is averaged every five minutes. That is, for example, if the committed volume is 100 RU/s, it isn't necessary to consume 100 RUs per second. Within the averaging interval, the load may change and amount to 150 RU/s during one minute and 50 RU/s another.

## Pricing {#prices}




{% include notitle [usd-serverless](../../_pricing/ydb/usd-serverless.md) %}




{% include notitle [usd-egress-traffic.md](../../_pricing/usd-egress-traffic.md) %}

