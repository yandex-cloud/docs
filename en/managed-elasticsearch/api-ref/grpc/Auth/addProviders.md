---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Auth/addProviders.md
---

# Managed Service for Elasticsearch API, gRPC: AuthService.AddProviders

Adds new auth providers to Elasticsearch cluster.

## gRPC request

**rpc AddProviders ([AddAuthProvidersRequest](#yandex.cloud.mdb.elasticsearch.v1.AddAuthProvidersRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddAuthProvidersRequest {#yandex.cloud.mdb.elasticsearch.v1.AddAuthProvidersRequest}

```json
{
  "cluster_id": "string",
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
  ]
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. Required. ID of the ElasticSearch cluster. ||
|| providers[] | **[AuthProvider](#yandex.cloud.mdb.elasticsearch.v1.AuthProvider)**

Required. List of providers to add. ||
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
    "cluster_id": "string",
    "names": [
      "string"
    ]
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
    ]
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
|| metadata | **[AddAuthProvidersMetadata](#yandex.cloud.mdb.elasticsearch.v1.AddAuthProvidersMetadata)**

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
|| response | **[AuthProviders](#yandex.cloud.mdb.elasticsearch.v1.AuthProviders)**

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

## AddAuthProvidersMetadata {#yandex.cloud.mdb.elasticsearch.v1.AddAuthProvidersMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the ElasticSearch cluster. ||
|| names[] | **string**

Names of the providers being added. ||
|#

## AuthProviders {#yandex.cloud.mdb.elasticsearch.v1.AuthProviders}

#|
||Field | Description ||
|| providers[] | **[AuthProvider](#yandex.cloud.mdb.elasticsearch.v1.AuthProvider2)** ||
|#

## AuthProvider {#yandex.cloud.mdb.elasticsearch.v1.AuthProvider2}

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
|| saml | **[SamlSettings](#yandex.cloud.mdb.elasticsearch.v1.SamlSettings2)**

Includes only one of the fields `saml`. ||
|#

## SamlSettings {#yandex.cloud.mdb.elasticsearch.v1.SamlSettings2}

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