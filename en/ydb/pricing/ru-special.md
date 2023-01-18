# Rules for estimating the cost of queries to {{ ydb-short-name }} via ad-hoc APIs

## ReadTable

The `ReadTable` operation lets you efficiently read large ranges of data from a table. The request cost only depends on the amount of data read based on the rate of 128 RU per 1 MB. When calculating the cost, the amount is rounded up to a multiple of 1 MB.

## BulkUpsert

`BulkUpsert` lets you efficiently upload data to the database. The cost of writing a row using the `BulkUpsert` operation is 0.5 RU per 1 KB of written data. When calculating the cost, the data amount is rounded up to a multiple of 1 KB. The total cost of the operation is calculated as the sum of costs for all rows written, with the result rounded up to the nearest integer.

**Example of cost calculation **

For example, as part of the `BulkUpsert` operation, you write four data items of 2500 bytes, 100 bytes, 1200 bytes, and 1024 bytes.

The cost of this operation is:
> 0.5 RU × 3 + 0.5 RU × 1 + 0.5 RU × 2 + 0.5 RU × 1 = 3.5 RU
>
> Total, rounded up to the nearest integer: 4 RU

Where:
* 0.5 is the cost in request units per 1 KB of written data.
* 3 is the rounded up size of the first item in KB (2500 bytes = 1024 bytes + 1024 bytes + 452 bytes).
* 1 is the rounded up size of the second item in KB.
* 2 is the rounded up size of the third item in KB (1200 bytes = 1024 bytes + 176 bytes).
* 1 is the size of the fourth item in KB.

## Building a secondary index {#secondary-index}

The cost of building an index is the sum of the cost of `ReadTable` from the source table and `BulkUpsert` to the index table. The total amount of work is charged: the number and size of rows read from the source table and written to the index table. The index building process can be canceled by the user. The canceled index-building operations are also billed based on the amount of work done before the operation was canceled.