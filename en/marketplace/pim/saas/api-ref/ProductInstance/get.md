---
editable: false
apiPlayground:
  - url: https://marketplace.{{ api-host }}/marketplace/pim/saas/v1/instances/{productInstanceId}
    method: get
    path:
      type: object
      properties:
        productInstanceId:
          description: |-
            **string**
            Required field. ID of the product instance to return.
          type: string
      required:
        - productInstanceId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/marketplace/pim/v1/saas/pim/saas/api-ref/ProductInstance/get.md
---

# Yandex Cloud Marketplace Product Instance Management API, REST: ProductInstance.Get

Returns the specified product instance.

## HTTP request

```
GET https://marketplace.{{ api-host }}/marketplace/pim/saas/v1/instances/{productInstanceId}
```

## Path parameters

#|
||Field | Description ||
|| productInstanceId | **string**

Required field. ID of the product instance to return. ||
|#

## Response {#yandex.cloud.marketplace.pim.v1.saas.ProductInstance}

**HTTP Code: 200 - OK**

```json
{
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
```

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
|| saasInfo | **[SaasInfo](#yandex.cloud.marketplace.pim.v1.saas.SaasInfo)**

Includes only one of the fields `saasInfo`.

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