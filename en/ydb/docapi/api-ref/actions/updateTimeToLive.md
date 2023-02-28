---
sourcePath: overlay/docapi/api-ref/actions/updateTimeToLive.md
---
# UpdateTimeToLive method

Enables or disables TTL for the specified table.

If successful, returns the current `TimeToLiveSpecification` value. The operation may take up to an hour. Additional method calls for the same table will throw a `ValidationException` error until the operation is completed.

The TTL checking mechanism compares the current time in [Unix time]{% if lang == "en" %}(https://en.wikipedia.org/wiki/Unix_time){% endif %}{% if lang == "ru" %}(https://ru.wikipedia.org/wiki/Unix-время){% endif %} format with the time stored in the TTL attribute of an item. If it's less than the current time, the item is marked as obsolete and subsequently deleted.

Items with an expired TTL are usually deleted within two days, the deletion time depends on the nature of the workload. Obsolete but not yet deleted items are displayed when reading, querying, and scanning data. When deleting items from a table, they are immediately deleted from the local and global secondary indexes the same way as a standard delete operation.

Obsolete items are deleted to provide sufficient bandwidth for other data operations.

## Request

The request contains data in JSON format.

```json
{
  "TableName": "string",
  "TimeToLiveSpecification": {
    "AttributeName": "string",
    "Enabled": boolean
  }
}
```

### Parameters

| Parameter | Description |
----- | -----
| `TableName` | Name of the table that the TTL state is requested for.<br/>May contain a path in the directory hierarchy like path/to/table.<br/><br/>**Type**: String<br/>**Length**: 3 - 255 characters.<br/>**Pattern**: [a-zA-Z0-9_.-]+<br/>**Required**: Yes |
| `TimeToLiveSpecification` | Parameters used to enable or disable TTL for the specified table.<br/><br/>**Type**: Object of the `TimeToLiveSpecification` type.<br/>**Required**: Yes |

## Response

If successful, HTTP code 200 is returned.
The response is returned in JSON format.

```json
{
  "TimeToLiveSpecification": {
    "AttributeName": "string",
    "Enabled": boolean
  }
}
```

### Parameters

| Parameter | Description |
----- | -----
| `TimeToLiveSpecification` | Operation result.<br/><br/>**Type**: Object of the `TimeToLiveSpecification` type. |

## Errors

| Parameter | Description |
----- | -----
| `InternalServerError` | An internal error occurred on the server side.<br/><br/>**HTTP status code**: 500 |
| `LimitExceededException` | Table operations limit exceeded.<br/>You can simultaneously perform up to 50 operations on tables, such as `CreateTable`, `UpdateTable`, `DeleteTable`, `UpdateTimeToLive`, `RestoreTableFromBackup`, and `RestoreTableToPointInTime`.<br/><br/>**HTTP status code**: 400 |
| `ResourceInUseException` | The resource is being used by another operation.<br/><br/>**HTTP status code**: 400<br/> |
| `ResourceNotFoundException` | The specified table doesn't exist or its state is different from `ACTIVE`.<br/><br/>**HTTP status code**: 400 |

There may be [common errors](../../common-errors.md) as well. These are errors that are common to all methods.
