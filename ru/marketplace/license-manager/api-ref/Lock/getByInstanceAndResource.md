---
editable: false
apiPlayground:
  - url: https://marketplace.{{ api-host }}/marketplace/license-manager/v1/locks:getByInstanceAndResource
    method: get
    path: null
    query:
      type: object
      properties:
        instanceId:
          description: |-
            **string**
            Required field. ID of the subscription instance.
          type: string
        resourceId:
          description: |-
            **string**
            Required field. ID of the resource to which the subscription will be locked.
          type: string
      required:
        - instanceId
        - resourceId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/marketplace/licensemanager/v1/license-manager/api-ref/Lock/getByInstanceAndResource.md
---

# Yandex Cloud Marketplace License Manager, REST: Lock.GetByInstanceAndResource

Returns the subscription lock for specified subscription instance and resource.

## HTTP request

```
GET https://marketplace.{{ api-host }}/marketplace/license-manager/v1/locks:getByInstanceAndResource
```

## Query parameters {#yandex.cloud.marketplace.licensemanager.v1.GetLockByInstanceAndResourceRequest}

#|
||Field | Description ||
|| instanceId | **string**

Required field. ID of the subscription instance. ||
|| resourceId | **string**

Required field. ID of the resource to which the subscription will be locked. ||
|#

## Response {#yandex.cloud.marketplace.licensemanager.v1.Lock}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "instanceId": "string",
  "resourceId": "string",
  "startTime": "string",
  "endTime": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "state": "string",
  "templateId": "string",
  "externalInstance": {
    "name": "string",
    "properties": "object",
    // Includes only one of the fields `subscription`, `license`
    "subscription": {
      "subscriptionId": "string",
      "licenseId": "string",
      "activationKey": "string"
    },
    "license": {
      "licenseId": "string",
      "payload": "string"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| id | **string**

ID of the subscription lock. ||
|| instanceId | **string**

ID of the subscription instance. ||
|| resourceId | **string**

ID of the resource. ||
|| startTime | **string** (date-time)

Timestamp of the start of the subscription lock.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| endTime | **string** (date-time)

Timestamp of the end of the subscription lock.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| state | **enum** (State)

Subscription lock state.

- `STATE_UNSPECIFIED`
- `UNLOCKED`: Subscription unlocked.
- `LOCKED`: Subscription locked to the resource.
- `DELETED`: Subscription lock deleted. ||
|| templateId | **string**

ID of the subscription template. ||
|| externalInstance | **[ExternalInstance](#yandex.cloud.marketplace.licensemanager.v1.ExternalInstance)**

External subscription instance (optional), for usage convenience propagated
from parent subscription instance. ||
|#

## ExternalInstance {#yandex.cloud.marketplace.licensemanager.v1.ExternalInstance}

ExternalInstance attachment to external service subscription.

#|
||Field | Description ||
|| name | **string**

Optional external subscription name. ||
|| properties | **object** (map<**string**, **string**>)

Mapping of vendor defined properties in key, value format. ||
|| subscription | **[ExternalSubscription](#yandex.cloud.marketplace.licensemanager.v1.ExternalSubscription)**

Includes only one of the fields `subscription`, `license`. ||
|| license | **[ExternalLicense](#yandex.cloud.marketplace.licensemanager.v1.ExternalLicense)**

Includes only one of the fields `subscription`, `license`. ||
|#

## ExternalSubscription {#yandex.cloud.marketplace.licensemanager.v1.ExternalSubscription}

#|
||Field | Description ||
|| subscriptionId | **string**

External subscription id. ||
|| licenseId | **string**

Optional: paired license id for external subscription. ||
|| activationKey | **string**

Optional: default activation key for external subscription. ||
|#

## ExternalLicense {#yandex.cloud.marketplace.licensemanager.v1.ExternalLicense}

#|
||Field | Description ||
|| licenseId | **string**

External license bound to subscription instance. ||
|| payload | **string** (bytes)

License (vendor specific) payload. ||
|#