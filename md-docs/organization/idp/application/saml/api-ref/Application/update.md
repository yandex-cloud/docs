[Документация Yandex Cloud](../../../../../../index.md) > [Yandex Identity Hub](../../../../../index.md) > Справочник API > REST (англ.) > Identity Provider API > [SAML Application API](../index.md) > [Application](index.md) > Update

# SAML Application API, REST: Application.Update

Updates the specified SAML application.

## HTTP request

```
PATCH https://organization-manager.api.cloud.yandex.net/organization-manager/v1/idp/application/saml/applications/{applicationId}
```

## Path parameters

Request to update an existing SAML application.

#|
||Field | Description ||
|| applicationId | **string**

Required field. ID of the SAML application to update.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.application.saml.UpdateApplicationRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "serviceProvider": {
    "entityId": "string",
    "acsUrls": [
      {
        "url": "string",
        "index": "string"
      }
    ],
    "sloUrls": [
      {
        "url": "string",
        "responseUrl": "string",
        "protocolBinding": "string"
      }
    ]
  },
  "securitySettings": {
    "signatureMode": "string",
    "signatureCertificateId": "string"
  },
  "attributeMapping": {
    "nameId": {
      "format": "string",
      "value": "string"
    },
    "attributes": [
      {
        "name": "string",
        "value": "string"
      }
    ]
  },
  "groupClaimsSettings": {
    "groupDistributionType": "string",
    "groupAttributeName": "string"
  }
}
```

Request to update an existing SAML application.

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

New name for the SAML application.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

New description for the SAML application.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

New resource labels as `` key:value `` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| serviceProvider | **[ServiceProvider](#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider)**

New service provider configuration for the SAML application. ||
|| securitySettings | **[SecuritySettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings)**

New security settings for the SAML application. ||
|| attributeMapping | **[AttributeMappingSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMappingSpec)**

New attribute mapping configuration for the SAML application. ||
|| groupClaimsSettings | **[GroupClaimsSettings](#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings)**

New group claims settings for the SAML application. ||
|#

## ServiceProvider {#yandex.cloud.organizationmanager.v1.idp.application.saml.ServiceProvider}

Service provider configuration for SAML applications.

#|
||Field | Description ||
|| entityId | **string**

Required field. Service provider entity ID.

The maximum string length in characters is 8000. ||
|| acsUrls[] | **[AssertionConsumerServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL)**

Assertion Consumer Service URLs.

The number of elements must be in the range 1-100. ||
|| sloUrls[] | **[SingleLogoutServiceURL](#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL)**

Single Logout Service URLs.

The number of elements must be in the range 0-100. ||
|#

## AssertionConsumerServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.AssertionConsumerServiceURL}

Assertion Consumer Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where SAML responses are sent.

The maximum string length in characters is 8000. ||
|| index | **string** (int64)

Optional index for the assertion consumer service. ||
|#

## SingleLogoutServiceURL {#yandex.cloud.organizationmanager.v1.idp.application.saml.SingleLogoutServiceURL}

Single Logout Service URL configuration.

#|
||Field | Description ||
|| url | **string**

Required field. The URL where logout requests are sent.

The maximum string length in characters is 8000. ||
|| responseUrl | **string**

Optional separate URL for logout responses.

The maximum string length in characters is 8000. ||
|| protocolBinding | **enum** (ProtocolBinding)

Required field. Protocol binding supported by the logout endpoint.

- `HTTP_POST`: HTTP POST binding.
- `HTTP_REDIRECT`: HTTP Redirect binding. ||
|#

## SecuritySettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.SecuritySettings}

Security settings for SAML applications.

#|
||Field | Description ||
|| signatureMode | **enum** (SignatureMode)

Signature mode for SAML messages.

- `ASSERTIONS`: Sign individual assertions.
- `RESPONSE`: Sign the entire response.
- `RESPONSE_AND_ASSERTIONS`: Sign both the response and individual assertions. ||
|| signatureCertificateId | **string**

ID of the signature certificate to use. ||
|#

## AttributeMappingSpec {#yandex.cloud.organizationmanager.v1.idp.application.saml.AttributeMappingSpec}

Attribute mapping specification for SAML application.

#|
||Field | Description ||
|| nameId | **[NameIdSpec](#yandex.cloud.organizationmanager.v1.idp.application.saml.NameIdSpec)**

Required field. NameID configuration. ||
|| attributes[] | **[Attribute](#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute)**

List of attribute mappings.

The maximum number of elements is 50. ||
|#

## NameIdSpec {#yandex.cloud.organizationmanager.v1.idp.application.saml.NameIdSpec}

NameID specification for SAML application.

#|
||Field | Description ||
|| format | **enum** (Format)

Required field. Format of the NameID.

- `PERSISTENT`: Persistent NameID format.
This provides a stable, opaque identifier for the user.
- `EMAIL`: Email NameID format.
This uses the user's email address as the identifier. ||
|| value | **string**

Value of the NameID.

The maximum string length in characters is 50. ||
|#

## Attribute {#yandex.cloud.organizationmanager.v1.idp.application.saml.Attribute}

Attribute mapping for SAML applications.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the SAML attribute.

The maximum string length in characters is 8000. ||
|| value | **string**

Required field. Value of the SAML attribute.

The maximum string length in characters is 50. ||
|#

## GroupClaimsSettings {#yandex.cloud.organizationmanager.v1.idp.application.saml.GroupClaimsSettings}

Group claims settings for SAML applications.

#|
||Field | Description ||
|| groupDistributionType | **enum** (GroupDistributionType)

Distribution type for group claims.

- `NONE`: No groups are provided to the application.
- `ASSIGNED_GROUPS`: Only assigned groups are provided to the application.
- `ALL_GROUPS`: All groups are provided to the application. ||
|| groupAttributeName | **string**

Name of the SAML attribute that contains group information.

The maximum string length in characters is 8000. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](../../../../../../api-design-guide/concepts/operation.md).

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
|| metadata | **object**

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
|| response | **object**

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