---
editable: false
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/getAuthSettings.md
---

# Managed Service for OpenSearch API, REST: Cluster.GetAuthSettings {#GetAuthSettings}

Retrieves auth settings for specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/auth
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the OpenSearch cluster. ||
|#

## Response {#yandex.cloud.mdb.opensearch.v1.AuthSettings}

**HTTP Code: 200 - OK**

```json
{
  "saml": {
    "enabled": "boolean",
    "idpEntityId": "string",
    "idpMetadataFile": "string",
    "spEntityId": "string",
    "dashboardsUrl": "string",
    "rolesKey": "string",
    "subjectKey": "string",
    "jwtDefaultExpirationTimeout": "string"
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
|| enabled | **boolean** ||
|| idpEntityId | **string**

Required. The entity ID of your IdP. ||
|| idpMetadataFile | **string** (bytes)

Required. The SAML 2.0 metadata file of your IdP. ||
|| spEntityId | **string**

Required. The entity ID of the service provider. ||
|| dashboardsUrl | **string**

Required. The OpenSearch Dashboards base URL. ||
|| rolesKey | **string**

Optional. The attribute in the SAML response where the roles are stored. If not configured, no roles are used. ||
|| subjectKey | **string**

Optional. The attribute in the SAML response where the subject is stored. If not configured, the NameID attribute is used. ||
|| jwtDefaultExpirationTimeout | **string** (int64)

default jwt expiration timeout. ||
|#