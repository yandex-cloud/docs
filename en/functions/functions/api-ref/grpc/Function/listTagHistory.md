---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Function/listTagHistory.md
---

# Cloud Functions Service, gRPC: FunctionService.ListTagHistory

Returns the log of tags assigned to versions of the specified function.

## gRPC request

**rpc ListTagHistory ([ListFunctionTagHistoryRequest](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryRequest)) returns ([ListFunctionTagHistoryResponse](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse))**

## ListFunctionTagHistoryRequest {#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryRequest}

```json
{
  "function_id": "string",
  "tag": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| function_id | **string**

Required field. ID of the function to retrieve tag history for.

To get a function ID, make a [FunctionService.List](/docs/functions/functions/api-ref/grpc/Function/list#List) request. ||
|| tag | **string**

Specific tag that history should be limited to. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`, the service returns a [ListFunctionOperationsResponse.next_page_token](/docs/functions/functions/api-ref/grpc/Function/listOperations#yandex.cloud.serverless.functions.v1.ListFunctionOperationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListFunctionOperationsResponse.next_page_token](/docs/functions/functions/api-ref/grpc/Function/listOperations#yandex.cloud.serverless.functions.v1.ListFunctionOperationsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [FunctionTagHistoryRecord.effective_from](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord) and [FunctionTagHistoryRecord.effective_to](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord) fields.
2. An `=` or `>` or `<` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
For example, `effective_to>2021-01-01T12:00:00Z`. ||
|#

## ListFunctionTagHistoryResponse {#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse}

```json
{
  "function_tag_history_record": [
    {
      "function_id": "string",
      "function_version_id": "string",
      "tag": "string",
      "effective_from": "google.protobuf.Timestamp",
      "effective_to": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| function_tag_history_record[] | **[FunctionTagHistoryRecord](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord)**

Set of relevant tag history records. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListFunctionTagHistoryRequest.page_size](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryRequest), use `nextPageToken` as the value
for the [ListFunctionTagHistoryRequest.page_token](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## FunctionTagHistoryRecord {#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord}

A record in the tag history.

#|
||Field | Description ||
|| function_id | **string**

ID of the function that the record is about. ||
|| function_version_id | **string**

ID of the function version that the record is about. ||
|| tag | **string**

Tag that was set for the version at some point. ||
|| effective_from | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the tag started being active for the function. ||
|| effective_to | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the tag stopped being active for the function. ||
|#