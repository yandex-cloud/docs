---
sourcePath: overlay/docapi/api-ref/index.md
---

# All methods

The {{ ydb-name }} HTTP API provides the following methods:

## Working with tables

| Method | Description |
| ----- | ----- |
| [CreateTable](actions/createTable.md) | Creates a table. |
| [DeleteTable](actions/deleteTable.md) | Deletes a table. |
| [DescribeTable](actions/describeTable.md) | Returns information about a table. |
| [DescribeTimeToLive](actions/describeTimeToLive.md) | Returns information about the time-to-live (TTL) status in the specified table. |
| [ListTables](actions/listTables.md) | Returns a list of tables.
 |
| [UpdateTimeToLive](actions/updateTimeToLive.md) | Enables or disables TTL for the specified table. |

## Working with items

| Method | Description |
| ----- | ----- |
| [BatchGetItem](actions/batchGetItem.md) | Returns attributes of items from multiple tables. |
| [BatchWriteItem](actions/batchWriteItem.md) | Writes items to or deletes them from tables. |
| [DeleteItem](actions/deleteItem.md) | Deletes an item from a table. |
| [GetItem](actions/getItem.md) | Returns attributes of an item from a single table. |
| [PutItem](actions/putItem.md) | Replaces a table item with a new one. |
| [Query](actions/query.md) | Returns table items. |
| [Scan](actions/scan.md) | Returns table items and attributes. |
| [TransactGetItems](actions/transactGetItems.md) | Retrieves multiple items from tables. |
| [TransactWriteItems](actions/transactWriteItems.md) | Performs a synchronous write operation. |
| [UpdateItem](actions/updateItem.md) | Updates table items. |
