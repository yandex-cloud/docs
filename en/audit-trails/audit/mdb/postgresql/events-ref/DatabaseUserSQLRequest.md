---
editable: false
---

# Managed Service for PostgreSQL Audit Trails Events: DatabaseUserSQLRequest

## Event JSON schema {#yandex.cloud.audit.mdb.postgresql.DatabaseUserSQLRequest2-schema}

```json
{
  "eventId": "string",
  "eventSource": "string",
  "eventType": "string",
  "eventTime": "string",
  "authentication": {
    "authenticated": "boolean",
    // Includes only one of the fields `subjectType`
    "subjectType": "string",
    // end of the list of possible fields
    // Includes only one of the fields `subjectId`
    "subjectId": "string"
    // end of the list of possible fields
  },
  "authorization": {
    "authorized": "boolean"
  },
  "resourceMetadata": {
    "path": [
      {
        "resourceType": "string",
        "resourceId": "string",
        // Includes only one of the fields `resourceName`
        "resourceName": "string"
        // end of the list of possible fields
      }
    ]
  },
  "requestMetadata": {
    "remoteAddress": "string",
    "userAgent": "string",
    "requestId": "string",
    // Includes only one of the fields `remotePort`
    "remotePort": "string"
    // end of the list of possible fields
  },
  "eventStatus": "string",
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "details": {
    "clusterId": "string",
    "clusterName": "string",
    "dbName": "string",
    "userName": "string",
    "pgAuditTime": "string",
    "pgAuditClass": "string",
    "pgAuditType": "string",
    "pgAuditCommand": "string",
    "pgAuditStatementId": "string",
    "pgAuditSubstatementId": "string",
    "pgAuditStatement": "string",
    "pgAuditObjectType": "string",
    "pgAuditObjectName": "string",
    "pgAuditStatementParams": "string"
  }
}
```

## Field description {#yandex.cloud.audit.mdb.postgresql.DatabaseUserSQLRequest2}

#|
||Field | Description ||
|| eventId | **string** ||
|| eventSource | **string** ||
|| eventType | **string** ||
|| eventTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| authentication | **[DatabaseAuthentication](#yandex.cloud.audit.DatabaseAuthentication)** ||
|| authorization | **[Authorization](#yandex.cloud.audit.Authorization)** ||
|| resourceMetadata | **[ResourceMetadata](#yandex.cloud.audit.ResourceMetadata)** ||
|| requestMetadata | **[RequestMetadata](#yandex.cloud.audit.RequestMetadata)** ||
|| eventStatus | **enum** (EventStatus)

- `STARTED`
- `ERROR`
- `DONE`
- `CANCELLED`
- `RUNNING` ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation. ||
|| details | **[PGAuditEventDetails](#yandex.cloud.audit.mdb.postgresql.PGAuditEventDetails)** ||
|#

## DatabaseAuthentication {#yandex.cloud.audit.DatabaseAuthentication}

#|
||Field | Description ||
|| authenticated | **boolean** ||
|| subjectType | **enum** (DatabaseSubjectType)

Includes only one of the fields `subjectType`.

- `DB_NATIVE_USER` ||
|| subjectId | **string**

Includes only one of the fields `subjectId`. ||
|#

## Authorization {#yandex.cloud.audit.Authorization}

#|
||Field | Description ||
|| authorized | **boolean** ||
|#

## ResourceMetadata {#yandex.cloud.audit.ResourceMetadata}

#|
||Field | Description ||
|| path[] | **[Resource](#yandex.cloud.audit.Resource)** ||
|#

## Resource {#yandex.cloud.audit.Resource}

#|
||Field | Description ||
|| resourceType | **string** ||
|| resourceId | **string** ||
|| resourceName | **string**

Includes only one of the fields `resourceName`. ||
|#

## RequestMetadata {#yandex.cloud.audit.RequestMetadata}

#|
||Field | Description ||
|| remoteAddress | **string** ||
|| userAgent | **string** ||
|| requestId | **string** ||
|| remotePort | **string** (int64)

Includes only one of the fields `remotePort`. ||
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

## PGAuditEventDetails {#yandex.cloud.audit.mdb.postgresql.PGAuditEventDetails}

#|
||Field | Description ||
|| clusterId | **string** ||
|| clusterName | **string** ||
|| dbName | **string** ||
|| userName | **string** ||
|| pgAuditTime | **string** ||
|| pgAuditClass | **enum** (PGAuditClass)

- `PG_AUDIT_CLASS_READ`
- `PG_AUDIT_CLASS_WRITE`
- `PG_AUDIT_CLASS_FUNCTION`
- `PG_AUDIT_CLASS_ROLE`
- `PG_AUDIT_CLASS_DDL`
- `PG_AUDIT_CLASS_MISC`
- `PG_AUDIT_CLASS_MISC_SET` ||
|| pgAuditType | **enum** (PGAuditType)

- `PG_AUDIT_TYPE_SESSION`
- `PG_AUDIT_TYPE_OBJECT` ||
|| pgAuditCommand | **string** ||
|| pgAuditStatementId | **string** (int64) ||
|| pgAuditSubstatementId | **string** (int64) ||
|| pgAuditStatement | **string** ||
|| pgAuditObjectType | **string** ||
|| pgAuditObjectName | **string** ||
|| pgAuditStatementParams | **string** ||
|#