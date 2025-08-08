---
editable: false
apiPlayground:
  - url: https://marketplace.{{ api-host }}/marketplace/license-manager/v1/locks
    method: get
    path: null
    query:
      type: object
      properties:
        resourceId:
          description: |-
            **string**
            Required field. ID of the resource that the subscription locks belong to.
          type: string
        folderId:
          description: |-
            **string**
            Required field. ID of the folder that the subscription locks belong to.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `page_size`, the service returns a [ListLocksResponse.nextPageToken](/docs/marketplace/license-manager/api-ref/Lock/list#yandex.cloud.marketplace.licensemanager.v1.ListLocksResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListLocksResponse.nextPageToken](/docs/marketplace/license-manager/api-ref/Lock/list#yandex.cloud.marketplace.licensemanager.v1.ListLocksResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters subscription locks listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [Lock.product_id] field.
            2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
            3. The value. Must be in double quotes `""`. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.
            Example of a filter: `product_id="my-product-id"`.
          type: string
        orderBy:
          description: |-
            **string**
            Sorting order for the list of subscription locks.
          type: string
      required:
        - resourceId
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/marketplace/licensemanager/v1/license-manager/api-ref/Lock/list.md
---

# Yandex Cloud Marketplace License Manager, REST: Lock.List

Returns subscriptions locks for specified resource and folder.

## HTTP request

```
GET https://marketplace.{{ api-host }}/marketplace/license-manager/v1/locks
```

## Query parameters {#yandex.cloud.marketplace.licensemanager.v1.ListLocksRequest}

#|
||Field | Description ||
|| resourceId | **string**

Required field. ID of the resource that the subscription locks belong to. ||
|| folderId | **string**

Required field. ID of the folder that the subscription locks belong to. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListLocksResponse.nextPageToken](#yandex.cloud.marketplace.licensemanager.v1.ListLocksResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListLocksResponse.nextPageToken](#yandex.cloud.marketplace.licensemanager.v1.ListLocksResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters subscription locks listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Lock.product_id] field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. The value. Must be in double quotes `""`. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `product_id="my-product-id"`. ||
|| orderBy | **string**

Sorting order for the list of subscription locks. ||
|#

## Response {#yandex.cloud.marketplace.licensemanager.v1.ListLocksResponse}

**HTTP Code: 200 - OK**

```json
{
  "locks": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| locks[] | **[Lock](#yandex.cloud.marketplace.licensemanager.v1.Lock)**

List of subscription locks. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListLocksRequest.pageSize](#yandex.cloud.marketplace.licensemanager.v1.ListLocksRequest), use `next_page_token` as the value
for the [ListLocksRequest.pageToken](#yandex.cloud.marketplace.licensemanager.v1.ListLocksRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Lock {#yandex.cloud.marketplace.licensemanager.v1.Lock}

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