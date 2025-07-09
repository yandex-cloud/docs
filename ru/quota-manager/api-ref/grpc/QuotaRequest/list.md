---
editable: false
sourcePath: en/_api-ref-grpc/quotamanager/v1/api-ref/grpc/QuotaRequest/list.md
---

# Quota Manager API, gRPC: QuotaRequestService.List

Retrieves the list of quota requests in the specified resource.

## gRPC request

**rpc List ([ListQuotaRequestRequest](#yandex.cloud.quotamanager.v1.ListQuotaRequestRequest)) returns ([ListQuotaRequestResponse](#yandex.cloud.quotamanager.v1.ListQuotaRequestResponse))**

## ListQuotaRequestRequest {#yandex.cloud.quotamanager.v1.ListQuotaRequestRequest}

```json
{
  "resource": {
    "id": "string",
    "type": "string"
  },
  "filter": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

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
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListQuotaRequestsResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.
Default value: 100 ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token`
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

## ListQuotaRequestResponse {#yandex.cloud.quotamanager.v1.ListQuotaRequestResponse}

```json
{
  "quota_requests": [
    {
      "id": "string",
      "resource": {
        "id": "string",
        "type": "string"
      },
      "created_at": "google.protobuf.Timestamp",
      "status": "Status",
      "quota_limits": [
        {
          "quota_id": "string",
          "desired_limit": "double",
          "approved_limit": "double",
          "unit": "string",
          "status": "Status",
          "message": "string",
          "modified_by": "string"
        }
      ],
      "created_by": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| quota_requests[] | **[QuotaRequest](#yandex.cloud.quotamanager.v1.QuotaRequest)**

List of quota requests. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListQuotaRequestsRequest.page_size], use
the `next_page_token` as the value
for the [ListQuotaRequestsRequest.page_token] query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## QuotaRequest {#yandex.cloud.quotamanager.v1.QuotaRequest}

#|
||Field | Description ||
|| id | **string**

ID of the quota request. ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource2)** ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| status | enum **Status**

Status of current quota request.

- `STATUS_UNSPECIFIED`
- `PENDING`: The request is pending and is waiting to be processed.
- `PROCESSING`: The request is processing.
- `PROCESSED`: The request was processed.
- `CANCELED`: The request was canceled.
- `DELETING`: The request is deleting. ||
|| quota_limits[] | **[QuotaLimit](#yandex.cloud.quotamanager.v1.QuotaRequest.QuotaLimit)**

Quota limits ||
|| created_by | **string**

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
|| quota_id | **string**

ID of the quota. ||
|| desired_limit | **double**

Desired limit. ||
|| approved_limit | **double**

Approved limit. ||
|| unit | **string**

Unit of quota. ||
|| status | enum **Status**

Status of current quota limit.

- `STATUS_UNSPECIFIED`
- `PENDING`: The request is pending and is waiting to be processed.
- `PROCESSING`: The request is processing.
- `PARTIAL_APPROVED`: The request was partially approved.
- `APPROVED`: The request was approved.
- `REJECTED`: The request was rejected.
- `CANCELED`: The request was canceled. ||
|| message | **string** ||
|| modified_by | **string**

ID of the subject who modified quota limit. ||
|#