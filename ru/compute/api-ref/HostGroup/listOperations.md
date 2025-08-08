---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/hostGroups/{hostGroupId}/operations
    method: get
    path:
      type: object
      properties:
        hostGroupId:
          description: |-
            **string**
            Required field. ID of the host group to list operations for.
            To get the host group ID, use [HostGroupService.List](/docs/compute/api-ref/HostGroup/list#List) request.
          type: string
      required:
        - hostGroupId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListHostGroupOperationsResponse.nextPageToken](/docs/compute/api-ref/HostGroup/listOperations#yandex.cloud.compute.v1.ListHostGroupOperationsResponse)
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListHostGroupOperationsResponse.nextPageToken](/docs/compute/api-ref/HostGroup/listOperations#yandex.cloud.compute.v1.ListHostGroupOperationsResponse) returned by a previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/compute/v1/api-ref/HostGroup/listOperations.md
---

# Compute Cloud API, REST: HostGroup.ListOperations

Lists operations for the specified host group.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/hostGroups/{hostGroupId}/operations
```

## Path parameters

#|
||Field | Description ||
|| hostGroupId | **string**

Required field. ID of the host group to list operations for.
To get the host group ID, use [HostGroupService.List](/docs/compute/api-ref/HostGroup/list#List) request. ||
|#

## Query parameters {#yandex.cloud.compute.v1.ListHostGroupOperationsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListHostGroupOperationsResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostGroupOperationsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListHostGroupOperationsResponse.nextPageToken](#yandex.cloud.compute.v1.ListHostGroupOperationsResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.compute.v1.ListHostGroupOperationsResponse}

**HTTP Code: 200 - OK**

```json
{
  "operations": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| operations[] | **[Operation](#yandex.cloud.operation.Operation)**

List of operations for the specified host group. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListHostGroupOperationsRequest.pageSize](#yandex.cloud.compute.v1.ListHostGroupOperationsRequest), use the `nextPageToken` as the value
for the [ListHostGroupOperationsRequest.pageToken](#yandex.cloud.compute.v1.ListHostGroupOperationsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Operation {#yandex.cloud.operation.Operation}

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