---
title: YDBDocument integration step
description: This article describes the fields for the YDBDocument integration step.
---

# YDBDocument

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Interacting with document tables in the [{{ ydb-full-name }}](../../../../../ydb/) database. The `get`, `put`, `update`, and `scan` fields are mutually exclusive: you can use only one of them.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`database` | `string` | Yes | None | None | Database ID.
`tableName` | `string` | Yes | None | None | Table name.
`get` | [YdbDocumentGet](#YdbDocumentGet) | None | None | None | Configuring the `get` action to select an entry from the table.
`put` | [YdbDocumentPut](#YdbDocumentPut) | None | None | None | Configuring the `put` action to add an entry to the table.
`update` | [YdbDocumentUpdate](#YdbDocumentUpdate) | None | None | None | Configuring the `update` action to update an entry in the table.
`scan` | [YdbDocumentScan](#YdbDocumentScan) | None | None | None | Configuring the `scan` action to get a list of table entries.

## YdbDocumentGet {#YdbDocumentGet}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | None | Yes | Primary key value for a database item.

## YdbDocumentPut {#YdbDocumentPut}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`item` | `string` | Yes | None | Yes | JSON-serialized data item to insert into a table.

## YdbDocumentUpdate {#YdbDocumentUpdate}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`key` | `string` | Yes | None | Yes | Primary key value for a database item.
`expression` | `string` | Yes | None | Yes | Expression to describe the updates to the attributes of a database item. For more information, see [UpdateExpression](../../../../../ydb/docapi/api-ref/actions/updateItem.md).
`expressionAttributeValues` | `string` | None | `""` | Yes | Values for attributes used in the expression. For more information, see [ExpressionAttributeValues](../../../../../ydb/docapi/api-ref/actions/updateItem.md).

## YdbDocumentScan {#YdbDocumentScan}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`limit` | `string` | None | None | Yes | Maximum number of items in the list
`exclusive_start_key` | `string` | None | None | Yes | Primary key value for a database item to start the search from.