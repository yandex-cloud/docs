---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/HBARule/batchUpdate.md
---

# Managed Service for Greenplum® API, gRPC: HBARuleService.BatchUpdate {#BatchUpdate}

Modifies all HBA rules for the specified Greenplum cluster.

## gRPC request

**rpc BatchUpdate ([BatchUpdateHBARulesRequest](#yandex.cloud.mdb.greenplum.v1.BatchUpdateHBARulesRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## BatchUpdateHBARulesRequest {#yandex.cloud.mdb.greenplum.v1.BatchUpdateHBARulesRequest}

```json
{
  "clusterId": "string",
  "hbaRules": [
    {
      "priority": "int64",
      "connectionType": "ConnectionType",
      "database": "string",
      "user": "string",
      "address": "string",
      "authMethod": "AuthMethod"
    }
  ]
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Greenplum cluster.
To get the Greenplum cluster ID use a [ClusterService.List](/docs/managed-greenplum/api-ref/grpc/Cluster/list#List) request. ||
|| hbaRules[] | **[HBARule](#yandex.cloud.mdb.greenplum.v1.HBARule)**

List of new hba rules for the cluster. ||
|#

## HBARule {#yandex.cloud.mdb.greenplum.v1.HBARule}

#|
||Field | Description ||
|| priority | **int64**

Priority of the Greenplum cluster rule. ||
|| connectionType | enum **ConnectionType**

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
|| authMethod | enum **AuthMethod**

Specifies the authentication method to use when a connection matches this record.
https://gpdb.docs.pivotal.io/6-6/security-guide/topics/Authenticate.html

- `AUTH_METHOD_UNSPECIFIED`
- `MD5`: Perform SCRAM-SHA-256 or MD5 authentication to verify the user's password.
- `LDAP`: Perform LDAP authentication, if MDB_GREENPLUM_LDAP flag is set
- `REJECT`: Disable authentication ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[HBARulesMetadata](#yandex.cloud.mdb.greenplum.v1.HBARulesMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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

## HBARulesMetadata {#yandex.cloud.mdb.greenplum.v1.HBARulesMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Greenplum cluster which HBA rules was affected. ||
|#