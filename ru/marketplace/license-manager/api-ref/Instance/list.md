---
editable: false
apiPlayground:
  - url: https://marketplace.{{ api-host }}/marketplace/license-manager/v1/instances
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder that the subscription instance belongs to.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `page_size`, the service returns a [ListInstancesResponse.nextPageToken](/docs/marketplace/license-manager/api-ref/Instance/list#yandex.cloud.marketplace.licensemanager.v1.ListInstancesResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListInstancesResponse.nextPageToken](/docs/marketplace/license-manager/api-ref/Instance/list#yandex.cloud.marketplace.licensemanager.v1.ListInstancesResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters subscription instances listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on [Instance.name] field.
            2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
            3. The value. Must be in double quotes `""`. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.
            Example of a filter: `name="my-subscription-instance"`.
          type: string
        orderBy:
          description: |-
            **string**
            Sorting order for the list of subscription instances.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/marketplace/licensemanager/v1/license-manager/api-ref/Instance/list.md
---

# Yandex Cloud Marketplace License Manager, REST: Instance.List

Retrieves the list of subscription instances in the specified folder.

## HTTP request

```
GET https://marketplace.{{ api-host }}/marketplace/license-manager/v1/instances
```

## Query parameters {#yandex.cloud.marketplace.licensemanager.v1.ListInstancesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder that the subscription instance belongs to. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListInstancesResponse.nextPageToken](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListInstancesResponse.nextPageToken](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters subscription instances listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Instance.name] field.
2. An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values.
3. The value. Must be in double quotes `""`. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name="my-subscription-instance"`. ||
|| orderBy | **string**

Sorting order for the list of subscription instances. ||
|#

## Response {#yandex.cloud.marketplace.licensemanager.v1.ListInstancesResponse}

**HTTP Code: 200 - OK**

```json
{
  "instances": [
    {
      "id": "string",
      "cloudId": "string",
      "folderId": "string",
      "templateId": "string",
      "templateVersionId": "string",
      "description": "string",
      "startTime": "string",
      "endTime": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "state": "string",
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
      "licenseTemplate": {
        "id": "string",
        "versionId": "string",
        "name": "string",
        "publisherId": "string",
        "productId": "string",
        "tariffId": "string",
        "licenseSkuId": "string",
        "period": "string",
        "createdAt": "string",
        "updatedAt": "string",
        "state": "string"
      },
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
|| instances[] | **[Instance](#yandex.cloud.marketplace.licensemanager.v1.Instance)**

List of subscription instances. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListInstancesRequest.pageSize](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesRequest), use `next_page_token` as the value
for the [ListInstancesRequest.pageToken](#yandex.cloud.marketplace.licensemanager.v1.ListInstancesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Instance {#yandex.cloud.marketplace.licensemanager.v1.Instance}

#|
||Field | Description ||
|| id | **string**

ID of the subscription instance. ||
|| cloudId | **string**

ID of the cloud that the subscription instance belongs to. ||
|| folderId | **string**

ID of the folder that the subscription instance belongs to. ||
|| templateId | **string**

ID of the subscription template that was used to create subscription instance. ||
|| templateVersionId | **string**

ID of the version of subscription template. ||
|| description | **string**

Description of the subscription instance. ||
|| startTime | **string** (date-time)

Timestamp of the start of the subscription.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| endTime | **string** (date-time)

Timestamp of the end of the subscription.

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

Subscription state.

- `STATE_UNSPECIFIED`
- `PENDING`: Subscription created but not active yet.
- `ACTIVE`: Subscription is active.
- `CANCELLED`: Subscription canceled. It is still active, but won't be automatically renewed after the end of the current period.
- `EXPIRED`: Subscription expired.
- `DEPRECATED`: Subscription deprecated.
- `DELETED`: Subscription deleted. ||
|| locks[] | **[Lock](#yandex.cloud.marketplace.licensemanager.v1.Lock)**

List of subscription locks. ||
|| licenseTemplate | **[Template](#yandex.cloud.marketplace.licensemanager.v1.Template)**

Subscription template. ||
|| externalInstance | **[ExternalInstance](#yandex.cloud.marketplace.licensemanager.v1.ExternalInstance)**

External subscription instance (optional). ||
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

## Template {#yandex.cloud.marketplace.licensemanager.v1.Template}

#|
||Field | Description ||
|| id | **string**

ID of the subscription template. ||
|| versionId | **string**

Version of the subscription template. ||
|| name | **string**

Name of the subscription template. ||
|| publisherId | **string**

ID of publisher. ||
|| productId | **string**

ID of product. ||
|| tariffId | **string**

ID of tariff. ||
|| licenseSkuId | **string**

ID of subscription SKU. ||
|| period | **string**

Subscription period. ||
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

Subscription template state.

- `STATE_UNSPECIFIED`
- `PENDING`: Subscription template created but not active yet.
- `ACTIVE`: Subscription template is active.
- `DEPRECATED`: Subscription template deprecated.
- `DELETED`: Subscription template deleted. ||
|#