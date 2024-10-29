---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/getAuthSettings.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.GetAuthSettings {#GetAuthSettings}

Retrieves auth settings for specified cluster.

## gRPC request

**rpc GetAuthSettings ([GetAuthSettingsRequest](#yandex.cloud.mdb.opensearch.v1.GetAuthSettingsRequest)) returns ([AuthSettings](#yandex.cloud.mdb.opensearch.v1.AuthSettings))**

## GetAuthSettingsRequest {#yandex.cloud.mdb.opensearch.v1.GetAuthSettingsRequest}

```json
{
  "clusterId": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the OpenSearch cluster. ||
|#

## AuthSettings {#yandex.cloud.mdb.opensearch.v1.AuthSettings}

```json
{
  "saml": {
    "enabled": "bool",
    "idpEntityId": "string",
    "idpMetadataFile": "bytes",
    "spEntityId": "string",
    "dashboardsUrl": "string",
    "rolesKey": "string",
    "subjectKey": "string",
    "jwtDefaultExpirationTimeout": "google.protobuf.Int64Value"
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
|| idpEntityId | **string**

Required. The entity ID of your IdP. ||
|| idpMetadataFile | **bytes**

Required. The SAML 2.0 metadata file of your IdP. ||
|| spEntityId | **string**

Required. The entity ID of the service provider. ||
|| dashboardsUrl | **string**

Required. The OpenSearch Dashboards base URL. ||
|| rolesKey | **string**

Optional. The attribute in the SAML response where the roles are stored. If not configured, no roles are used. ||
|| subjectKey | **string**

Optional. The attribute in the SAML response where the subject is stored. If not configured, the NameID attribute is used. ||
|| jwtDefaultExpirationTimeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

default jwt expiration timeout. ||
|#