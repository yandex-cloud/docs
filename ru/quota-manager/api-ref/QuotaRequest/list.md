---
editable: false
apiPlayground:
  - url: https://quota-manager.{{ api-host }}/quota-manager/v1/quotaRequests
    method: get
    path: null
    query:
      type: object
      properties:
        resource:
          description: |-
            **[Resource](/docs/quota-manager/api-ref/QuotaLimit/get#yandex.cloud.quotamanager.v1.Resource)**
            Required field. Resource to list quota requests in.
          $ref: '#/definitions/Resource'
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering only on the [quotaRequest.status] field.
            2. An `=` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListQuotaRequestsResponse.next_page_token]
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken`
            to the [ListQuotaRequestsResponse.next_page_token]
            returned by a previous list request.
          type: string
      required:
        - resource
      additionalProperties: false
    body: null
    definitions:
      Resource:
        type: object
        properties:
          id:
            description: |-
              **string**
              Required field. The id if the resource.
            type: string
          type:
            description: |-
              **string**
              Required field. The type of the resource, e.g. resource-manager.cloud, billing.account.
            type: string
        required:
          - id
          - type
sourcePath: en/_api-ref/quotamanager/v1/api-ref/QuotaRequest/list.md
---

# Quota Manager API, REST: QuotaRequest.List

Retrieves the list of quota requests in the specified resource.

## HTTP request

```
GET https://quota-manager.{{ api-host }}/quota-manager/v1/quotaRequests
```

## Query parameters {#yandex.cloud.quotamanager.v1.ListQuotaRequestRequest}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource)**

Required field. Resource to list quota requests in. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [quotaRequest.status] field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListQuotaRequestsResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListQuotaRequestsResponse.next_page_token]
returned by a previous list request. ||
|#

## Resource {#yandex.cloud.quotamanager.v1.Resource}

#|
||Field | Description ||
|| id | **string**

Required field. The id if the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.cloud, billing.account. ||
|#

## Response {#yandex.cloud.quotamanager.v1.ListQuotaRequestResponse}

**HTTP Code: 200 - OK**

```json
{
  "quotaRequests": [
    {
      "id": "string",
      "resource": {
        "id": "string",
        "type": "string"
      },
      "createdAt": "string",
      "status": "string",
      "quotaLimits": [
        {
          "quotaId": "string",
          "desiredLimit": "string",
          "approvedLimit": "string",
          "unit": "string",
          "status": "string",
          "message": "string",
          "modifiedBy": "string"
        }
      ],
      "createdBy": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| quotaRequests[] | **[QuotaRequest](#yandex.cloud.quotamanager.v1.QuotaRequest)**

List of quota requests. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListQuotaRequestsRequest.page_size], use
the `nextPageToken` as the value
for the [ListQuotaRequestsRequest.page_token] query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## QuotaRequest {#yandex.cloud.quotamanager.v1.QuotaRequest}

#|
||Field | Description ||
|| id | **string**

ID of the quota request. ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource2)** ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Status of current quota request.

- `STATUS_UNSPECIFIED`
- `PENDING`: The request is pending and is waiting to be processed.
- `PROCESSING`: The request is processing.
- `PROCESSED`: The request was processed.
- `CANCELED`: The request was canceled.
- `DELETING`: The request is deleting. ||
|| quotaLimits[] | **[QuotaLimit](#yandex.cloud.quotamanager.v1.QuotaRequest.QuotaLimit)**

Quota limits ||
|| createdBy | **string**

ID of the subject who created quota request. ||
|#

## Resource {#yandex.cloud.quotamanager.v1.Resource2}

#|
||Field | Description ||
|| id | **string**

Required field. The id if the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.cloud, billing.account. ||
|#

## QuotaLimit {#yandex.cloud.quotamanager.v1.QuotaRequest.QuotaLimit}

#|
||Field | Description ||
|| quotaId | **string**

ID of the quota. ||
|| desiredLimit | **string**

Desired limit. ||
|| approvedLimit | **string**

Approved limit. ||
|| unit | **string**

Unit of quota. ||
|| status | **enum** (Status)

Status of current quota limit.

- `STATUS_UNSPECIFIED`
- `PENDING`: The request is pending and is waiting to be processed.
- `PROCESSING`: The request is processing.
- `PARTIAL_APPROVED`: The request was partially approved.
- `APPROVED`: The request was approved.
- `REJECTED`: The request was rejected.
- `CANCELED`: The request was canceled. ||
|| message | **string** ||
|| modifiedBy | **string**

ID of the subject who modified quota limit. ||
|#