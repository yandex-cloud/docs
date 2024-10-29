---
editable: false
sourcePath: en/_api-ref/logging/v1/api-ref/LogGroup/get.md
---

# Cloud Logging Service, REST: LogGroup.Get {#Get}

Returns the specified log group.

To get the list of all available log groups, make a [List](/docs/logging/api-ref/LogGroup/list#List) request.

## HTTP request

```
GET https://logging.{{ api-host }}/logging/v1/logGroups/{logGroupId}
```

## Path parameters

#|
||Field | Description ||
|| logGroupId | **string**

Required field. ID of the log group to return.

To get a log group ID make a [LogGroupService.List](/docs/logging/api-ref/LogGroup/list#List) request. ||
|#

## Response {#yandex.cloud.logging.v1.LogGroup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "cloudId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  "status": "string",
  "retentionPeriod": "string",
  "dataStream": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Log group ID. ||
|| folderId | **string**

Log group folder ID. ||
|| cloudId | **string**

Log group cloud ID. ||
|| createdAt | **string** (date-time)

Log group creation time.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Log group name. ||
|| description | **string**

Log group description. ||
|| labels | **string**

Log group labels. ||
|| status | **enum** (Status)

Status of the log group.

- `STATUS_UNSPECIFIED`: Unknown status.

  Should never occur.
- `CREATING`: Log group is creating.
- `ACTIVE`: Log group is ready to accept messages,
- `DELETING`: Log group is being deleted.

  No messages will be accepted.
- `ERROR`: Log group is in failed state. ||
|| retentionPeriod | **string** (duration)

Log group entry retention period.

Entries will be present in group during this period. ||
|| dataStream | **string**

Data stream name ||
|#