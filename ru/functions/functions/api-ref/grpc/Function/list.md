---
editable: false
sourcePath: en/_api-ref-grpc/serverless/functions/v1/functions/api-ref/grpc/Function/list.md
---

# Cloud Functions Service, gRPC: FunctionService.List

Retrieves the list of functions in the specified folder.

## gRPC request

**rpc List ([ListFunctionsRequest](#yandex.cloud.serverless.functions.v1.ListFunctionsRequest)) returns ([ListFunctionsResponse](#yandex.cloud.serverless.functions.v1.ListFunctionsResponse))**

## ListFunctionsRequest {#yandex.cloud.serverless.functions.v1.ListFunctionsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list functions in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListFunctionsResponse.next_page_token](#yandex.cloud.serverless.functions.v1.ListFunctionsResponse)
that can be used to get the next page of results in subsequent list requests.

Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListFunctionsResponse.next_page_token](#yandex.cloud.serverless.functions.v1.ListFunctionsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters functions listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [Function.name](#yandex.cloud.serverless.functions.v1.Function) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name="my-function"`. ||
|#

## ListFunctionsResponse {#yandex.cloud.serverless.functions.v1.ListFunctionsResponse}

```json
{
  "functions": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "http_invoke_url": "string",
      "status": "Status"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| functions[] | **[Function](#yandex.cloud.serverless.functions.v1.Function)**

List of functions in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListFunctionsRequest.page_size](#yandex.cloud.serverless.functions.v1.ListFunctionsRequest), use `nextPageToken` as the value
for the [ListFunctionsRequest.page_token](#yandex.cloud.serverless.functions.v1.ListFunctionsRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## Function {#yandex.cloud.serverless.functions.v1.Function}

A serverless function. For details about the concept, see [Functions](/docs/functions/concepts/function).

#|
||Field | Description ||
|| id | **string**

ID of the function. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the function belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the function. ||
|| name | **string**

Name of the function. The name is unique within the folder. ||
|| description | **string**

Description of the function. ||
|| labels | **object** (map<**string**, **string**>)

Function labels as `key:value` pairs. ||
|| http_invoke_url | **string**

URL that needs to be requested to invoke the function. ||
|| status | enum **Status**

Status of the function.

- `STATUS_UNSPECIFIED`
- `CREATING`: Function is being created.
- `ACTIVE`: Function is ready to be invoked.
- `DELETING`: Function is being deleted.
- `ERROR`: Function failed. ||
|#