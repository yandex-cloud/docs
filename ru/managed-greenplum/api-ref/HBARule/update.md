---
editable: false
sourcePath: en/_api-ref/mdb/greenplum/v1/api-ref/HBARule/update.md
---

# Managed Service for Greenplum® API, REST: HBARule.Update

Update specified HBA rule for the specified Greenplum cluster without changind it order.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-greenplum/v1/clusters/{clusterId}/hbaRules
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum cluster.
To get the Greenplum cluster ID use a [ClusterService.List](/docs/managed-greenplum/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.greenplum.v1.UpdateHBARuleRequest}

```json
{
  "hbaRule": {
    "priority": "string",
    "connectionType": "string",
    "database": "string",
    "user": "string",
    "address": "string",
    "authMethod": "string"
  }
}
```

#|
||Field | Description ||
|| hbaRule | **[HBARule](#yandex.cloud.mdb.greenplum.v1.HBARule)**

Required field. Updated hba rule for the cluster. ||
|#

## HBARule {#yandex.cloud.mdb.greenplum.v1.HBARule}

#|
||Field | Description ||
|| priority | **string** (int64)

Priority of the Greenplum cluster rule. ||
|| connectionType | **enum** (ConnectionType)

- `CONNECTION_TYPE_UNSPECIFIED`
- `HOST`: Matches connection attempts made using TCP/IP.
- `HOSTSSL`: Matches connection attempts made using TCP/IP, but only when the connection is made with SSL encryption.
- `HOSTNOSSL`: Matches connection attempts made over TCP/IP that do not use SSL. ||
|| database | **string**

Required field. Specifies which database names this record matches. ||
|| user | **string**

Required field. Specifies which database role names this user matches. ||
|| address | **string**

Required field. Specifies the client machine addresses that this record matches. ||
|| authMethod | **enum** (AuthMethod)

Specifies the authentication method to use when a connection matches this record.
https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html

- `AUTH_METHOD_UNSPECIFIED`
- `MD5`: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.
- `LDAP`: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set
- `REJECT`: Disable authentication ||
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
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

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
|| metadata | **[HBARulesMetadata](#yandex.cloud.mdb.greenplum.v1.HBARulesMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## HBARulesMetadata {#yandex.cloud.mdb.greenplum.v1.HBARulesMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Greenplum cluster which HBA rules was affected. ||
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