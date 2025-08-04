---
editable: false
apiPlayground:
  - '{"url":"https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/auth","method":"put","path":{"type":"object","properties":{"clusterId":{"description":"**string**\n\nRequired field. Required. ID of the OpenSearch cluster.","type":"string"}},"required":["clusterId"],"additionalProperties":false},"query":null,"body":{"type":"object","properties":{"settings":{"description":"**[AuthSettings](/docs/managed-opensearch/api-ref/Cluster/getAuthSettings#yandex.cloud.mdb.opensearch.v1.AuthSettings)**\n\nRequired. Auth settings.","$ref":"#/definitions/AuthSettings"}},"additionalProperties":false},"definitions":{"SAMLSettings":{"type":"object","properties":{"enabled":{"description":"**boolean**","type":"boolean"},"idpEntityId":{"description":"**string**\n\nRequired. The entity ID of your IdP.","type":"string"},"idpMetadataFile":{"description":"**string** (bytes)\n\nRequired. The SAML 2.0 metadata file of your IdP.","type":"string","format":"bytes"},"spEntityId":{"description":"**string**\n\nRequired. The entity ID of the service provider.","type":"string"},"dashboardsUrl":{"description":"**string**\n\nRequired. The OpenSearch Dashboards base URL.","type":"string"},"rolesKey":{"description":"**string**\n\nOptional. The attribute in the SAML response where the roles are stored. If not configured, no roles are used.","type":"string"},"subjectKey":{"description":"**string**\n\nOptional. The attribute in the SAML response where the subject is stored. If not configured, the NameID attribute is used.","type":"string"},"jwtDefaultExpirationTimeout":{"description":"**string** (int64)\n\ndefault jwt expiration timeout.","type":"string","format":"int64"}}},"AuthSettings":{"type":"object","properties":{"saml":{"description":"**[SAMLSettings](/docs/managed-opensearch/api-ref/Cluster/getAuthSettings#yandex.cloud.mdb.opensearch.v1.SAMLSettings)**\n\nSAML settings","$ref":"#/definitions/SAMLSettings"}}}}}'
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Cluster/updateAuthSettings.md
---

# Managed Service for OpenSearch API, REST: Cluster.UpdateAuthSettings

Updates auth settings for specified cluster.

## HTTP request

```
PUT https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/{clusterId}/auth
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. Required. ID of the OpenSearch cluster. ||
|#

## Body parameters {#yandex.cloud.mdb.opensearch.v1.UpdateAuthSettingsRequest}

```json
{
  "settings": {
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
}
```

#|
||Field | Description ||
|| settings | **[AuthSettings](#yandex.cloud.mdb.opensearch.v1.AuthSettings)**

Required. Auth settings. ||
|#

## AuthSettings {#yandex.cloud.mdb.opensearch.v1.AuthSettings}

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
    "clusterId": "string"
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
|| metadata | **[UpdateAuthSettingsMetadata](#yandex.cloud.mdb.opensearch.v1.UpdateAuthSettingsMetadata)**

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
|| response | **[AuthSettings](#yandex.cloud.mdb.opensearch.v1.AuthSettings2)**

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

## UpdateAuthSettingsMetadata {#yandex.cloud.mdb.opensearch.v1.UpdateAuthSettingsMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the OpenSearch cluster. ||
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

## AuthSettings {#yandex.cloud.mdb.opensearch.v1.AuthSettings2}

#|
||Field | Description ||
|| saml | **[SAMLSettings](#yandex.cloud.mdb.opensearch.v1.SAMLSettings2)**

SAML settings ||
|#

## SAMLSettings {#yandex.cloud.mdb.opensearch.v1.SAMLSettings2}

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