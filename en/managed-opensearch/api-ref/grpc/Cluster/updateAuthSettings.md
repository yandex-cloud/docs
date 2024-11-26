---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/updateAuthSettings.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.UpdateAuthSettings

Updates auth settings for specified cluster.

## gRPC request

**rpc UpdateAuthSettings ([UpdateAuthSettingsRequest](#yandex.cloud.mdb.opensearch.v1.UpdateAuthSettingsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateAuthSettingsRequest {#yandex.cloud.mdb.opensearch.v1.UpdateAuthSettingsRequest}

```json
{
  "cluster_id": "string",
  "settings": {
    "saml": {
      "enabled": "bool",
      "idp_entity_id": "string",
      "idp_metadata_file": "bytes",
      "sp_entity_id": "string",
      "dashboards_url": "string",
      "roles_key": "string",
      "subject_key": "string",
      "jwt_default_expiration_timeout": "google.protobuf.Int64Value"
    }
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the OpenSearch cluster. ||
|| settings | **[AuthSettings](#yandex.cloud.mdb.opensearch.v1.AuthSettings)**

Required. Auth settings. ||
|#

## AuthSettings {#yandex.cloud.mdb.opensearch.v1.AuthSettings}

#|
||Field | Description ||
|| saml | **[SAMLSettings](#yandex.cloud.mdb.opensearch.v1.SAMLSettings)**

SAML settings ||
|#

## SAMLSettings {#yandex.cloud.mdb.opensearch.v1.SAMLSettings}

#|
||Field | Description ||
|| enabled | **bool** ||
|| idp_entity_id | **string**

Required. The entity ID of your IdP. ||
|| idp_metadata_file | **bytes**

Required. The SAML 2.0 metadata file of your IdP. ||
|| sp_entity_id | **string**

Required. The entity ID of the service provider. ||
|| dashboards_url | **string**

Required. The OpenSearch Dashboards base URL. ||
|| roles_key | **string**

Optional. The attribute in the SAML response where the roles are stored. If not configured, no roles are used. ||
|| subject_key | **string**

Optional. The attribute in the SAML response where the subject is stored. If not configured, the NameID attribute is used. ||
|| jwt_default_expiration_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

default jwt expiration timeout. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "saml": {
      "enabled": "bool",
      "idp_entity_id": "string",
      "idp_metadata_file": "bytes",
      "sp_entity_id": "string",
      "dashboards_url": "string",
      "roles_key": "string",
      "subject_key": "string",
      "jwt_default_expiration_timeout": "google.protobuf.Int64Value"
    }
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateAuthSettingsMetadata](#yandex.cloud.mdb.opensearch.v1.UpdateAuthSettingsMetadata)**

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
|| response | **[AuthSettings](#yandex.cloud.mdb.opensearch.v1.AuthSettings2)**

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

## UpdateAuthSettingsMetadata {#yandex.cloud.mdb.opensearch.v1.UpdateAuthSettingsMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the OpenSearch cluster. ||
|#

## AuthSettings {#yandex.cloud.mdb.opensearch.v1.AuthSettings2}

#|
||Field | Description ||
|| saml | **[SAMLSettings](#yandex.cloud.mdb.opensearch.v1.SAMLSettings2)**

SAML settings ||
|#

## SAMLSettings {#yandex.cloud.mdb.opensearch.v1.SAMLSettings2}

#|
||Field | Description ||
|| enabled | **bool** ||
|| idp_entity_id | **string**

Required. The entity ID of your IdP. ||
|| idp_metadata_file | **bytes**

Required. The SAML 2.0 metadata file of your IdP. ||
|| sp_entity_id | **string**

Required. The entity ID of the service provider. ||
|| dashboards_url | **string**

Required. The OpenSearch Dashboards base URL. ||
|| roles_key | **string**

Optional. The attribute in the SAML response where the roles are stored. If not configured, no roles are used. ||
|| subject_key | **string**

Optional. The attribute in the SAML response where the subject is stored. If not configured, the NameID attribute is used. ||
|| jwt_default_expiration_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

default jwt expiration timeout. ||
|#