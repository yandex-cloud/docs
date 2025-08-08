---
editable: false
apiPlayground:
  - url: https://marketplace.{{ api-host }}/marketplace/pim/saas/v1/instances/claim
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        token:
          description: |-
            **string**
            Required field. Signed JWT token which contains information about product instance and subscription.
          type: string
        resourceId:
          description: |-
            **string**
            ID of the resource to which the product instance will be claimed.
          type: string
        resourceInfo:
          description: |-
            **[SaasInfo](/docs/marketplace/pim/ProductInstance/get#yandex.cloud.marketplace.pim.v1.saas.SaasInfo)**
            Additional information about the resource.
          $ref: '#/definitions/SaasInfo'
      required:
        - token
      additionalProperties: false
    definitions:
      SaasInfo:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the SaaS resource.
            type: string
          data:
            description: |-
              **object** (map<**string**, **string**>)
              Additional data about the SaaS resource.
            type: string
sourcePath: en/_api-ref/marketplace/pim/v1/saas/pim/saas/api-ref/ProductInstance/claim.md
---

# Yandex Cloud Marketplace Product Instance Management API, REST: ProductInstance.Claim

Claims a product instance - activates it and optionally locks to subscription

## HTTP request

```
POST https://marketplace.{{ api-host }}/marketplace/pim/saas/v1/instances/claim
```

## Body parameters {#yandex.cloud.marketplace.pim.v1.saas.ClaimProductInstanceRequest}

```json
{
  "token": "string",
  "resourceId": "string",
  "resourceInfo": {
    "id": "string",
    "data": "object"
  }
}
```

#|
||Field | Description ||
|| token | **string**

Required field. Signed JWT token which contains information about product instance and subscription. ||
|| resourceId | **string**

ID of the resource to which the product instance will be claimed. ||
|| resourceInfo | **[SaasInfo](#yandex.cloud.marketplace.pim.v1.saas.SaasInfo)**

Additional information about the resource. ||
|#

## SaasInfo {#yandex.cloud.marketplace.pim.v1.saas.SaasInfo}

#|
||Field | Description ||
|| id | **string**

ID of the SaaS resource. ||
|| data | **object** (map<**string**, **string**>)

Additional data about the SaaS resource. ||
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
    "productId": "string",
    "productInstanceId": "string",
    "licenseInstanceId": "string",
    "lockId": "string"
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
    "id": "string",
    "resourceId": "string",
    "resourceType": "string",
    "resourceMetadata": "object",
    "state": "string",
    "createdAt": "string",
    "updatedAt": "string",
    // Includes only one of the fields `saasInfo`
    "saasInfo": {
      "id": "string",
      "data": "object"
    }
    // end of the list of possible fields
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
|| metadata | **[ClaimProductInstanceMetadata](#yandex.cloud.marketplace.pim.v1.saas.ClaimProductInstanceMetadata)**

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
|| response | **[ProductInstance](#yandex.cloud.marketplace.pim.v1.saas.ProductInstance)**

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

## ClaimProductInstanceMetadata {#yandex.cloud.marketplace.pim.v1.saas.ClaimProductInstanceMetadata}

#|
||Field | Description ||
|| productId | **string**

ID of the product to which the product instance belongs. ||
|| productInstanceId | **string**

ID of the product instance. ||
|| licenseInstanceId | **string**

ID of the subscription. ||
|| lockId | **string**

ID of the subscription lock. ||
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

## ProductInstance {#yandex.cloud.marketplace.pim.v1.saas.ProductInstance}

#|
||Field | Description ||
|| id | **string**

ID of the product instance. ||
|| resourceId | **string**

ID of the resource. ||
|| resourceType | **enum** (ResourceType)

Type of the resource.

- `RESOURCE_TYPE_UNSPECIFIED`
- `SAAS`: SaaS resource.
- `K8S`: Kubernetes resource.
- `COMPUTE`: Compute resource.
- `CLOUD_APPS`: Cloud Apps resource. ||
|| resourceMetadata | **object** (map<**string**, **string**>)

Metadata of the resource; Reserved for future use. ||
|| state | **enum** (State)

State of the product instance.

- `STATE_UNSPECIFIED`
- `ACTIVATED`: Product instance is activated.
- `DEACTIVATED`: Product instance is deactivated.
- `PENDING_ACTIVATION`: Product instance is pending activation.
- `DEPRECATED`: Product instance is deprecated.
- `DELETED`: Product instance is deleted. ||
|| createdAt | **string** (date-time)

Creation timestamp

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Update timestamp

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| saasInfo | **[SaasInfo](#yandex.cloud.marketplace.pim.v1.saas.SaasInfo2)**

Includes only one of the fields `saasInfo`.

Additional information about the resource. ||
|#

## SaasInfo {#yandex.cloud.marketplace.pim.v1.saas.SaasInfo2}

#|
||Field | Description ||
|| id | **string**

ID of the SaaS resource. ||
|| data | **object** (map<**string**, **string**>)

Additional data about the SaaS resource. ||
|#