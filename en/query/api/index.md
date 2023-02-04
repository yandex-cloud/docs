# How to work with the HTTP API

Below are common approaches to working with the {{ yq-full-name }} HTTP API:

* [Headers](#headers)
* [Errors](#errors)

## Headers {#headers}

When using the HTTP API, some headers are required and others are not.

### Required headers {#mandatory-headers}

| Name | Description |
| --- | --- |
| `Authorization` | [Authentication parameters](auth.md).<br>Type: String.<br>Example: `Authorization: Bearer <IAM token>`. |

### Optional headers {#optional-headers}

| Name | Description |
| --- | --- |
| `x-request-id` | Used for query diagnostics. Specify any string as a value. We recommend using highly unique values, such as GUID, to avoid collisions with IDs used to diagnose other queries.<br>Type: String.<br>Example: `c8b4c0aa-8fc2-4159-8870-f4cb40b73aae`. |
| `Idempotency-Key` | [Idempotency key](../../api-design-guide/concepts/idempotency.md). Used in modifying operations. We recommend specifying this parameter to avoid unexpected situations.<br>Type: String, UUID.<br>Example: `Idempotency-Key: c1700de3-b8cb-4d8a-9990-e4ebf052e9aa`. |

## Errors {#errors}

If an error occurs, {{ yq-full-name }} returns a detailed error description in a JSON object, such as:

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

Incorrect JSON object fields:

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| `message` | String | Error overview | "Failed to parse query" |
| `details` | An array of [`Issue`](#issue) objects | Detailed description of an incorrect string | |

### Issue object {#issue}

If an error occurs, {{ yq-full-name }} returns detailed information specifying the error location and context, and the numbers of incorrect SQL query strings. The result is returned as an instance of the `Issue` object.

Error details may be represented as a hierarchy, meaning that a more general `Issue` may contain a number of detailed `Issues` with a more detailed description, and so on.

{% cut "Sample hierarchy error" %}

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

| Name | Type | Description | Example |
| --- | --- | --- | --- |
| `message` | String | Error overview | "Failed to parse query" |
| `severity` | Number | Error severity. Possible values: `Info`, `Warn`, `Error`, and `Fatal`. | `Warn` |
| `position.row` | Number | Number of the code block start string causing the error | 1 |
| `position.column` | Number | Number of the character in the `position.row` string. | 1 |
| `endPosition.row` | Number | Number of the code block end string causing the error | 1 |
| `endPosition.column` | Number | Number of the character in the `endPosition.row` string. | 1 |
| `Issues` | Array | An array of nested `Issues` with error details | |
