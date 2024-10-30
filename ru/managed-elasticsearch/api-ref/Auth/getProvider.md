---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Auth/getProvider.md
---

# Managed Service for Elasticsearch API, REST: Auth.GetProvider {#GetProvider}

Returns registered auth provider by name.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/auth/providers/{name}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the ElasticSearch cluster. ||
|| name | **string**

Required field. Required. Name of the provider to delete. ||
|#

## Response {#yandex.cloud.mdb.elasticsearch.v1.AuthProvider}

**HTTP Code: 200 - OK**

```json
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
```

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