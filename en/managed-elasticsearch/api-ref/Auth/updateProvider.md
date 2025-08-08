---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/auth/providers/{name}
    method: put
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. Required. ID of the ElasticSearch cluster.
          type: string
        name:
          description: |-
            **string**
            Required field. Required. Name of the provider to update.
          pattern: '[a-z][a-z0-9_-]*'
          type: string
      required:
        - clusterId
        - name
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        provider:
          description: |-
            **[AuthProvider](/docs/managed-elasticsearch/api-ref/Auth/listProviders#yandex.cloud.mdb.elasticsearch.v1.AuthProvider)**
            Required field. Required. New provider defenition.
          oneOf:
            - type: object
              properties:
                saml:
                  description: |-
                    **[SamlSettings](/docs/managed-elasticsearch/api-ref/Auth/listProviders#yandex.cloud.mdb.elasticsearch.v1.SamlSettings)**
                    Includes only one of the fields `saml`.
                  $ref: '#/definitions/SamlSettings'
      required:
        - provider
      additionalProperties: false
    definitions:
      SamlSettings:
        type: object
        properties:
          idpEntityId:
            description: '**string**'
            type: string
          idpMetadataFile:
            description: '**string** (bytes)'
            type: string
            format: bytes
          spEntityId:
            description: '**string**'
            type: string
          kibanaUrl:
            description: '**string**'
            type: string
          attributePrincipal:
            description: '**string**'
            type: string
          attributeGroups:
            description: '**string**'
            type: string
          attributeName:
            description: '**string**'
            type: string
          attributeEmail:
            description: '**string**'
            type: string
          attributeDn:
            description: '**string**'
            type: string
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Auth/updateProvider.md
---

# Managed Service for Elasticsearch API, REST: Auth.UpdateProvider

Updates registered auth provider.

## HTTP request

```
PUT https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/auth/providers/{name}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the ElasticSearch cluster. ||
|| name | **string**

Required field. Required. Name of the provider to update. ||
|#

## Body parameters {#yandex.cloud.mdb.elasticsearch.v1.UpdateAuthProviderRequest}

```json
{
  "provider": {
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
}
```

#|
||Field | Description ||
|| provider | **[AuthProvider](#yandex.cloud.mdb.elasticsearch.v1.AuthProvider)**

Required field. Required. New provider defenition. ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "clusterId": "string",
    "names": [
      "string"
    ]
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateAuthProvidersMetadata](#yandex.cloud.mdb.elasticsearch.v1.UpdateAuthProvidersMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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

## UpdateAuthProvidersMetadata {#yandex.cloud.mdb.elasticsearch.v1.UpdateAuthProvidersMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the ElasticSearch cluster. ||
|| names[] | **string**

Names of the providers being added. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## AuthProviders {#yandex.cloud.mdb.elasticsearch.v1.AuthProviders}

#|
||Field | Description ||
|| providers[] | **[AuthProvider](#yandex.cloud.mdb.elasticsearch.v1.AuthProvider2)** ||
|#

## AuthProvider {#yandex.cloud.mdb.elasticsearch.v1.AuthProvider2}

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
|| saml | **[SamlSettings](#yandex.cloud.mdb.elasticsearch.v1.SamlSettings2)**

Includes only one of the fields `saml`. ||
|#

## SamlSettings {#yandex.cloud.mdb.elasticsearch.v1.SamlSettings2}

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