---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/auth/providers
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. Required. ID of the ElasticSearch cluster.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Auth/listProviders.md
---

# Managed Service for Elasticsearch API, REST: Auth.ListProviders

Retrieves the list of registered auth providers for Elasticsearch cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/auth/providers
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the ElasticSearch cluster. ||
|#

## Response {#yandex.cloud.mdb.elasticsearch.v1.ListAuthProvidersResponse}

**HTTP Code: 200 - OK**

```json
{
  "providers": [
    {
      "type": "string",
      "name": "string",
      "order": "string",
      "enabled": "boolean",
      "hidden": "boolean",
      "description": "string",
      "hint": "string",
      "icon": "string",
      // Includes only one of the fields `saml`
      "saml": {
        "idpEntityId": "string",
        "idpMetadataFile": "string",
        "spEntityId": "string",
        "kibanaUrl": "string",
        "attributePrincipal": "string",
        "attributeGroups": "string",
        "attributeName": "string",
        "attributeEmail": "string",
        "attributeDn": "string"
      }
      // end of the list of possible fields
    }
  ]
}
```

#|
||Field | Description ||
|| providers[] | **[AuthProvider](#yandex.cloud.mdb.elasticsearch.v1.AuthProvider)**

List of auth providers of the Elasticsearch cluster. ||
|#

## AuthProvider {#yandex.cloud.mdb.elasticsearch.v1.AuthProvider}

#|
||Field | Description ||
|| type | **enum** (Type)

- `TYPE_UNSPECIFIED`
- `NATIVE`
- `SAML` ||
|| name | **string** ||
|| order | **string** (int64) ||
|| enabled | **boolean** ||
|| hidden | **boolean**

selector ui settings ||
|| description | **string** ||
|| hint | **string** ||
|| icon | **string** ||
|| saml | **[SamlSettings](#yandex.cloud.mdb.elasticsearch.v1.SamlSettings)**

Includes only one of the fields `saml`. ||
|#

## SamlSettings {#yandex.cloud.mdb.elasticsearch.v1.SamlSettings}

#|
||Field | Description ||
|| idpEntityId | **string** ||
|| idpMetadataFile | **string** (bytes) ||
|| spEntityId | **string** ||
|| kibanaUrl | **string** ||
|| attributePrincipal | **string** ||
|| attributeGroups | **string** ||
|| attributeName | **string** ||
|| attributeEmail | **string** ||
|| attributeDn | **string** ||
|#