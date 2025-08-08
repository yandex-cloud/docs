---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/User/getSelfPasswordMetadata.md
---

# Identity Provider API, gRPC: UserService.GetSelfPasswordMetadata

Returns metadata about the authenticated user's password.

## gRPC request

**rpc GetSelfPasswordMetadata ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)) returns ([PasswordMetadata](#yandex.cloud.organizationmanager.v1.idp.PasswordMetadata))**

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#

## PasswordMetadata {#yandex.cloud.organizationmanager.v1.idp.PasswordMetadata}

```json
{
  "id": "string",
  "type": "PasswordType",
  "created_at": "google.protobuf.Timestamp",
  "expires_at": "google.protobuf.Timestamp",
  "last_usage": {
    "used_at": "google.protobuf.Timestamp",
    "ip_address": "string"
  }
}
```

Metadata about a user's password.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the password. ||
|| type | enum **PasswordType**

Type of the password.

- `PASSWORD_TYPE_UNSPECIFIED`: The password type is not specified.
- `TEMPORARY`: Temporary password that must be changed on first use.
- `PERMANENT`: Permanent password. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the password was created. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the password expires. ||
|| last_usage | **[PasswordUsage](#yandex.cloud.organizationmanager.v1.idp.PasswordMetadata.PasswordUsage)**

Information about the last usage of the password. ||
|#

## PasswordUsage {#yandex.cloud.organizationmanager.v1.idp.PasswordMetadata.PasswordUsage}

Information about password usage.

#|
||Field | Description ||
|| used_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the password was last used. ||
|| ip_address | **string**

IP address from which the password was used. ||
|#