---
title: Methods of working with Yandex Database HTTP API
description: "Yandex Database HTTP API provides the following working methods. Working with tables (CreateTable, DeleteTable, DescribeTable, ListTables). Working with items (BatchGetItem, BatchWriteItem, DeleteItem, GetItem, PutItem, Query, Scan, TransactGetItems, TransactWriteItems, UpdateItem). "
---

# All methods

{{ ydb-name }} The HTTP API provides the following methods:

## Working with tables

| Method | Description |
| ----- | ----- |
| [CreateTable](actions/createTable) | Creates a table |
| [DeleteTable](actions/deleteTable) | Deletes a table |
| [DescribeTable](actions/describeTable) | Returns information about a table |
| [ListTables](actions/listTables) | Returns a list of tables
 |

## Working with items

| Method | Description |
| ----- | ----- |
| [BatchGetItem](actions/batchGetItem) | Returns attributes of items from multiple tables |
| [BatchWriteItem](actions/batchWriteItem) | Writes or deletes table items
 |
| [DeleteItem](actions/deleteItem) | Deletes an item from a table |
| [GetItem](actions/getItem) | Returns item attributes from a single table |
| [PutItem](actions/putItem) | Overwrites table items |
| [Query](actions/query) | Returns table items |
| [Scan](actions/scan) | Returns items and attributes from a table.
 |
| [TransactGetItems](actions/transactGetItems) | Retrieves multiple items from tables |
| [TransactWriteItems](actions/transactWriteItems) | A synchronous write operation |
| [UpdateItem](actions/updateItem) | Updates table items |

