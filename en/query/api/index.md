# Working with the {{ yq-full-name }} HTTP API

With the {{ yq-name }} HTTP API, you can both perform one-time operations and automate routine tasks, e.g., querying data from scripts or programs on a schedule.

The {{ yq-name }} HTTP API [methods](methods/index.md) allow you to create, run, and stop queries, as well as retrieve their statuses and results. To make API requests, first you need to [authenticate](auth.md).

Below are the common approaches to working with the {{ yq-name }} HTTP API:

* [Headers](#headers)
* [Errors](#errors)

## Headers {#headers}

When working with the HTTP API, some headers are mandatory while others are optional.

### Mandatory headers {#mandatory-headers}

| Header | Description |
| --- | --- |
| `Authorization` | [Authentication parameters](auth.md).<br>Type: String.<br>Example: `Authorization: Bearer <IAM token>`. |

### Optional headers {#optional-headers}

| Header | Description |
| --- | --- |
| `x-request-id` | This header is used for query diagnostics. You can specify an arbitrary string as its value. We recommend using unique values, e.g., GUIDs, to avoid collisions with diagnostic identifiers of other requests.<br>Type: String.<br>Example: `c8b4c0aa-8fc2-4159-8870-f4cb********`. |
| `Idempotency-Key` | [Idempotency key](../../api-design-guide/concepts/idempotency.md). This header is used in write operations to prevent duplicate actions and side effects when the same request is submitted multiple times.<br>Type: String,UUID.<br>Example: `Idempotency-Key: c1700de3-b8cb-4d8a-9990-e4eb********`. |

## Errors {#errors}

When an error occurs, {{ yq-full-name }} returns a detailed error description in a JSON object, e.g.:

```json
{
    "message": "Failed to parse query",
    "details": [
        {
        "position": {
            "row": 0,
            "column": 0
        },
        "message": "string",
        "end_position": {
            "row": 0,
            "column": 0
        },
        "issue_code": 0,
        "severity": "FATAL",
        "issues": [
            "string"
        ]
        }
    ]
}
```

Error JSON object fields:

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| `message` | String | Error overview | "Failed to parse query" |
| `details` | Array of [`Issue`](#issue) objects | Detailed error description | |

### Issue object {#issue}

When an error occurs, {{ yq-full-name }} returns detailed information about its location, context, and the line numbers of the SQL query containing the error. This information is wrapped in an `Issue` object instance.

Error information may be hierarchical, i.e., a higher-level `Issue` may contain multiple lower-level `Issue` objects with more detailed descriptions, etc.

{% cut "Error hierarchy example" %}

```json
{
"issues": [
    {
    "issues": [
        {
        "position": {
            "column": 1,
            "row": 1
        },
        "severity": 1,
        "endPosition": {
            "column": 1,
            "row": 1
        },
        "message": "Column references are not allowed without FROM"
        },
        {
        "position": {
            "column": 8,
            "row": 1
        },
        "severity": 1,
        "endPosition": {
            "column": 8,
            "row": 1
        },
        "message": "Column reference 'x'"
        }
    ],
    "severity": 1,
    "message": "Parse Sql"
    },
    {
    "issues": [
        {
        "position": {
            "column": 1,
            "row": 1
        },
        "severity": 1,
        "endPosition": {
            "column": 1,
            "row": 1
        },
        "message": "Column references are not allowed without FROM"
        },
        {
        "position": {
            "column": 8,
            "row": 1
        },
        "severity": 1,
        "endPosition": {
            "column": 8,
            "row": 1
        },
        "message": "Column reference 'x'"
        }
    ],
    "severity": 1,
    "message": "Parse Sql"
    }
],
"severity": 1,
"message": "Failed to parse query"
}
```

{% endcut %}

`Issue` object fields:

| Field | Type | Description | Example |
| --- | --- | --- | --- |
| `message` | String | Error overview | "Failed to parse query" |
| `severity` | Number | Error severity. The possible values are `Info`, `Warn`, `Error`, or `Fatal` | `Warn` |
| `position.row` | Number | The starting line number of the code block that triggered the error | 1 |
| `position.column` | Number | The character position in the `position.row` line | 1 |
| `endPosition.row` | Number | The ending line number of the code block that triggered the error | 1 |
| `endPosition.column` | Number | The character position in the `endPosition.row` line | 1 |
| `Issues` | Array | An array of nested `Issue` objects containing error details | |