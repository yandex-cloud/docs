[Документация Yandex Cloud](../../../../../index.md) > [Yandex Identity Hub](../../../../index.md) > Справочник API > gRPC (англ.) > [Identity Provider API](../index.md) > [User](index.md) > GetPasswordChanges

# Identity Provider API, gRPC: UserService.GetPasswordChanges

Streams password changes for a IdentityHub sync agent to process.

## gRPC request

**rpc GetPasswordChanges (stream [GetPasswordChangesRequest](#yandex.cloud.organizationmanager.v1.idp.GetPasswordChangesRequest)) returns (stream [GetPasswordChangesResponse](#yandex.cloud.organizationmanager.v1.idp.GetPasswordChangesResponse))**

## GetPasswordChangesRequest {#yandex.cloud.organizationmanager.v1.idp.GetPasswordChangesRequest}

```json
{
  "userpool_id": "string",
  "agent_id": "string",
  "offset": "int64"
}
```

Request from a IdentityHub sync agent to receive pending password changes.

#|
||Field | Description ||
|| userpool_id | **string**

Required field. ID of the userpool to receive password changes for.

The maximum string length in characters is 50. ||
|| agent_id | **string**

Required field. ID of the IdentityHub sync agent.

The maximum string length in characters is 50. ||
|| offset | **int64**

Offset of the last successfully processed change. ||
|#

## GetPasswordChangesResponse {#yandex.cloud.organizationmanager.v1.idp.GetPasswordChangesResponse}

```json
{
  "external_user_id": "string",
  "password": "string",
  "modifying_operation_id": "string",
  "need_change": "bool",
  "offset": "int64",
  "expires_at": "google.protobuf.Timestamp",
  "operation_expires_at": "google.protobuf.Timestamp",
  "generated": "bool",
  "old_password": "string"
}
```

A pending password change to be processed by a IdentityHub sync agent.

#|
||Field | Description ||
|| external_user_id | **string**

External identifier of the user whose password changed. ||
|| password | **string**

The new password to write back to the directory. ||
|| modifying_operation_id | **string**

ID of the operation that triggered this password change. ||
|| need_change | **bool**

Whether the user must change their password on next login. ||
|| offset | **int64**

Offset of this change in the stream. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the password expires. ||
|| operation_expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the writeback operation expires. ||
|| generated | **bool**

Whether the password was system-generated. ||
|| old_password | **string**

The user's previous password. Present only for user-initiated changes
(empty for administrative resets and system-generated passwords). It lets
the sync agent perform a policy-enforcing change (LDAP DELETE old + ADD new)
instead of a reset (REPLACE), so the directory enforces minimum password
age and password history. ||
|#