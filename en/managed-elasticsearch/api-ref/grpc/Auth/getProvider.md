---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Auth/getProvider.md
---

# Managed Service for Elasticsearch API, gRPC: AuthService.GetProvider

Returns registered auth provider by name.

## gRPC request

**rpc GetProvider ([GetAuthProviderRequest](#yandex.cloud.mdb.elasticsearch.v1.GetAuthProviderRequest)) returns ([AuthProvider](#yandex.cloud.mdb.elasticsearch.v1.AuthProvider))**

## GetAuthProviderRequest {#yandex.cloud.mdb.elasticsearch.v1.GetAuthProviderRequest}

```json
{
  "cluster_id": "string",
  "name": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the ElasticSearch cluster. ||
|| name | **string**

Required field. Required. Name of the provider to delete. ||
|#

## AuthProvider {#yandex.cloud.mdb.elasticsearch.v1.AuthProvider}

```json
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
    "idp_entity_id": "string",
    "idp_metadata_file": "bytes",
    "sp_entity_id": "string",
    "kibana_url": "string",
    "attribute_principal": "string",
    "attribute_groups": "string",
    "attribute_name": "string",
    "attribute_email": "string",
    "attribute_dn": "string"
  }
  // end of the list of possible fields
}
```

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
|| idp_entity_id | **string** ||
|| idp_metadata_file | **bytes** ||
|| sp_entity_id | **string** ||
|| kibana_url | **string** ||
|| attribute_principal | **string** ||
|| attribute_groups | **string** ||
|| attribute_name | **string** ||
|| attribute_email | **string** ||
|| attribute_dn | **string** ||
|#