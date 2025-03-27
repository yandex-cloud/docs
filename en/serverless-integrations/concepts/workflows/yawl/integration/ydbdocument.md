---
title: YDBDocument integration step
description: This article describes the fields for the YDBDocument integration step.
---

# YDBDocument

Interacting with document tables in the [{{ ydb-full-name }}](../../../../../ydb/) database. The `get`, `put`, `update`, and `scan` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`database` | `string` | Yes | No | No | Database ID.
`tableName` | `string` | Yes | No | No | Table name.
`get` | [YdbDocumentGet](#YdbDocumentGet) | No | No | No | Configuring the `get` action to select an entry from the table.
`put` | [YdbDocumentPut](#YdbDocumentPut) | No | No | No | Configuring the `put` action to add an entry to the table.
`update` | [YdbDocumentUpdate](#YdbDocumentUpdate) | No | No | No | Configuring the `update` action to update an entry in the table.
`scan` | [YdbDocumentScan](#YdbDocumentScan) | No | No | No | Configuring the `scan` action to get a list of table entries.

## YdbDocumentGet {#YdbDocumentGet}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Primary key value for a database item.

## YdbDocumentPut {#YdbDocumentPut}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`item` | `string` | Yes | No | Yes | JSON-serialized data item to insert into a table.

## YdbDocumentUpdate {#YdbDocumentUpdate}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | No | Yes | Primary key value for a database item.
`expression` | `string` | Yes | No | Yes | Expression to describe the updates to the attributes of a database item. For more information, see [UpdateExpression](../../../../../ydb/docapi/api-ref/actions/updateItem.md).
`expressionAttributeValues` | `string` | No | `""` | Yes | Values for attributes used in the expression. For more information, see [ExpressionAttributeValues](../../../../../ydb/docapi/api-ref/actions/updateItem.md).

## YdbDocumentScan {#YdbDocumentScan}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`limit` | `string` | No | No | Yes | Maximum number of items in the list
`exclusive_start_key` | `string` | No | No | Yes | Primary key value for a database item to start the search from.