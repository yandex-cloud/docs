---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/auth
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. Required. ID of the OpenSearch cluster.
            The maximum string length in characters is 50.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Managed Service for OpenSearch API, REST: Cluster.GetAuthSettings

Retrieves auth settings for specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/auth
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the OpenSearch cluster.

The maximum string length in characters is 50. ||
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

Required. The entity ID of your IdP.

The maximum string length in characters is 250. ||
|| idpMetadataFile | **string** (bytes)

Required. The SAML 2.0 metadata file of your IdP.

The maximum string length in characters is 10000. ||
|| spEntityId | **string**

Required. The entity ID of the service provider.

The maximum string length in characters is 250. ||
|| dashboardsUrl | **string**

Required. The OpenSearch Dashboards base URL.

The maximum string length in characters is 250. ||
|| rolesKey | **string**

Optional. The attribute in the SAML response where the roles are stored. If not configured, no roles are used.

The maximum string length in characters is 250. ||
|| subjectKey | **string**

Optional. The attribute in the SAML response where the subject is stored. If not configured, the NameID attribute is used.

The maximum string length in characters is 250. ||
|| jwtDefaultExpirationTimeout | **string** (int64)

default jwt expiration timeout. ||
|#