[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for MySQL®](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [BackupRetentionPolicy](index.md) > Create

# Managed Service for MySQL API, REST: BackupRetentionPolicy.Create

Add a new retention policy.

## HTTP request

```
POST https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/retention_policies
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MySQL cluster.
To get the MySQL cluster ID use a [ClusterService.List](../Cluster/list.md#List) request.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.mdb.mysql.v1.CreateBackupRetentionPolicyRequest}

```json
{
  "cron": {
    "dayOfMonth": "string",
    "month": "string",
    "dayOfWeek": "string"
  },
  "retainForDays": "string",
  "description": "string",
  "policyName": "string"
}
```

#|
||Field | Description ||
|| cron | **[CronTab](#yandex.cloud.mdb.v1.CronTab)**

CronTab schedule. ||
|| retainForDays | **string** (int64)

Retention duration.

Acceptable values are 7 to 1095, inclusive. ||
|| description | **string**

Policy description. ||
|| policyName | **string**

Required field. Required. Policy name. ||
|#

## CronTab {#yandex.cloud.mdb.v1.CronTab}

Message to describe a crontab schedule.

#|
||Field | Description ||
|| dayOfMonth | **string**

Day of month in cron format. Valid values: 1-31, *, ranges (1-15), steps (*/2, 1-15/3), lists (1,15,28).
Defaults to "*". ||
|| month | **string**

Month in cron format. Valid values: 1-12, *, ranges (1-6), steps (*/3), lists (1,6,12).
Defaults to "*". ||
|| dayOfWeek | **string**

Day of week in cron format. Valid values: 0-7 (0 and 7 both mean Sunday), *, ranges (1-5), steps (0-6/2), lists (1,3,5).
Defaults to "*". ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#