---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/getAuthSettings.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.GetAuthSettings

Retrieves auth settings for specified cluster.

## gRPC request

**rpc GetAuthSettings ([GetAuthSettingsRequest](#yandex.cloud.mdb.opensearch.v1.GetAuthSettingsRequest)) returns ([AuthSettings](#yandex.cloud.mdb.opensearch.v1.AuthSettings))**

## GetAuthSettingsRequest {#yandex.cloud.mdb.opensearch.v1.GetAuthSettingsRequest}

```json
{
  "cluster_id": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the OpenSearch cluster. ||
|#

## AuthSettings {#yandex.cloud.mdb.opensearch.v1.AuthSettings}

```json
{
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
```

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