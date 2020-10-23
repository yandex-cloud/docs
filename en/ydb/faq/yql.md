# YQL

## General questions {#common}

### How do I select table rows by a given list of keys? {#explicit-keys}

You can select table rows from the specified list of values of the table's primary key (or key prefix) using the IN operator:

```sql
DECLARE $keys AS List<UInt64>;

SELECT * FROM some_table
WHERE Key1 IN $keys;
```

If a selection is made using a composite key, the query parameter must have the type of a list of tuples:

```sql
DECLARE $keys AS List<Tuple<UInt64, String>>;

SELECT * FROM some_table
WHERE (Key1, Key2) IN $keys;
```

To select rows effectively, make sure that the value types in the parameters match the key column types in the table.

### Is a search by index performed for conditions containing the LIKE operator? {#like-index}

You can only use the LIKE operator to search by table index if it sets the row prefix:

```sql
SELECT * FROM string_key_table
WHERE Key LIKE "some_prefix%";
```

### Why does a query return only 1000 rows? {#result-rows-limit}

1000 rows is the response size limit per YQL query. If a response is shortened, it is flagged as `Truncated`. To output more table rows, you can use [paginated output](../best_practices/paging.md) or the `ReadTable` operation.

### What should I do if I get the error "Datashard: Reply size limit exceeded"? {#reply-size-exceeded}

This error means that, when executing the query, an attempt was made to return more than 50 MB of data from one of the involved datashards, which exceeds the allowed limit.

Recommendations:

* A general recommendation is to reduce the amount of data processed in a transaction.
* If a Join operation is running, make sure that its method is [Index Lookup Join](#index-lookup-join).
* If a simple selection is performed, make sure that it is done by keys, or add `LIMIT` in the query.

### How do I update only those values whose keys are not in the table? {#update-non-existent}

You can use LEFT JOIN to mark the keys that are missing from the table and then update their values:

```sql
DECLARE $values AS List<Struct<Key: UInt64, Value: String>>;

UPSERT INTO kv_table
SELECT v.Key AS Key, v.Value AS Value
FROM AS_TABLE($values) AS v
LEFT JOIN kv_table AS t
ON v.Key = t.Key
WHERE t.Key IS NULL;
```

## Join operations {#joins}

### Are there any specific features of Join operations? {#join-operations}

Join operations in {{ ydb-short-name }} are performed in one of two ways:

* Common Join
* Index Lookup Join

#### Common Join {#common-join}

The contents of both tables (the left and right parts of a Join) are sent to the node executing the query, where the operation is performed on the entire data. This is a universal way to perform a Join operation, which is used when more optimal methods are not applicable. For large tables, this method is either slow or doesn't work in general due to exceeding the data transfer limits.

#### Index Lookup Join {#index-lookup-join}

For rows from the left part of a Join operation, a lookup is performed for the corresponding values in the right part. This method is used when the right part is a table and the Join operation key is the prefix of its primary key or of the secondary index key. In this method, limited selections are made from the right table instead of full reads. This lets you use it when working with large tables.

{% note info %}

For most OLTP queries, we recommend using Index Lookup Join with a small size of the left part. These operations read little data and can be performed efficiently.

{% endnote %}

### How do I make a Join with data from query parameters? {#constant-table-join}

You can use query parameter data as a constant table. To do this, use the `AS_TABLE` modifier with a parameter whose type is a list of structures:

```sql
DECLARE $data AS List<Struct<Key1: UInt64, Key2: String>>;

SELECT * FROM AS_TABLE($data) AS d
INNER JOIN some_table AS t
ON t.Key1 = d.Key1 AND t.Key2 = d.Key2;
```

There is no explicit limit on the number of entries in the constant table, but mind the standard limit on the total size of query parameters (50 MB).

## Transactions {#transactions}

### How efficient is it to run multiple queries in a transaction? {#transaction-queries}

When multiple queries are run sequentially, the total transaction latency may be greater than when the same operations are executed within a single query. This is primarily due to additional network latency for each query. Therefore, if a transaction doesn't need to be interactive, we recommend formulating all operations in a single YQL query.

### Is a separate query atomic? {#atomic-query}

In general, YQL queries can be executed in multiple consecutive phases. For example, a Join query can be executed in two phases: reading data from the left and right table, respectively. This aspect is important when you run a query in a transaction with a low isolation level (`online_read_only`), as in this case, data in-between its execution phases can be updated by other transactions.

