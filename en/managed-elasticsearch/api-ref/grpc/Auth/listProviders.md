---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Auth/listProviders.md
---

# Managed Service for Elasticsearch API, gRPC: AuthService.ListProviders {#ListProviders}

Retrieves the list of registered auth providers for Elasticsearch cluster.

## gRPC request

**rpc ListProviders ([ListAuthProvidersRequest](#yandex.cloud.mdb.elasticsearch.v1.ListAuthProvidersRequest)) returns ([ListAuthProvidersResponse](#yandex.cloud.mdb.elasticsearch.v1.ListAuthProvidersResponse))**

## ListAuthProvidersRequest {#yandex.cloud.mdb.elasticsearch.v1.ListAuthProvidersRequest}

```json
{
  "clusterId": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the ElasticSearch cluster. ||
|#

## ListAuthProvidersResponse {#yandex.cloud.mdb.elasticsearch.v1.ListAuthProvidersResponse}

```json
{
  "providers": [
    {
      "type": "Type",
      "name": "string",
      "order": "int64",
      "enabled": "bool",
      "hidden": "bool",
      "description": "string",
      "hint": "string",
      "icon": "string",
      // Includes only one of the fields `saml`
      "saml": {
        "idpEntityId": "string",
        "idpMetadataFile": "bytes",
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
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `NATIVE`
- `SAML` ||
|| name | **string** ||
|| order | **int64** ||
|| enabled | **bool** ||
|| hidden | **bool**

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
|| idpMetadataFile | **bytes** ||
|| spEntityId | **string** ||
|| kibanaUrl | **string** ||
|| attributePrincipal | **string** ||
|| attributeGroups | **string** ||
|| attributeName | **string** ||
|| attributeEmail | **string** ||
|| attributeDn | **string** ||
|#