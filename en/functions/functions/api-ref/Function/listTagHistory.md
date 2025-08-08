---
editable: false
apiPlayground:
  - url: https://serverless-functions.{{ api-host }}/functions/v1/functions/{functionId}:tagHistory
    method: get
    path:
      type: object
      properties:
        functionId:
          description: |-
            **string**
            Required field. ID of the function to retrieve tag history for.
            To get a function ID, make a [FunctionService.List](/docs/functions/functions/api-ref/Function/list#List) request.
          type: string
      required:
        - functionId
      additionalProperties: false
    query:
      type: object
      properties:
        tag:
          description: |-
            **string**
            Specific tag that history should be limited to.
          pattern: '[a-z][-_0-9a-z]*|[$]latest'
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `pageSize`, the service returns a [ListFunctionOperationsResponse.nextPageToken](/docs/functions/functions/api-ref/Function/listOperations#yandex.cloud.serverless.functions.v1.ListFunctionOperationsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListFunctionOperationsResponse.nextPageToken](/docs/functions/functions/api-ref/Function/listOperations#yandex.cloud.serverless.functions.v1.ListFunctionOperationsResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression must specify:
            1. The field name. Currently filtering can only be applied to the [FunctionTagHistoryRecord.effectiveFrom](/docs/functions/functions/api-ref/Function/listTagHistory#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord) and [FunctionTagHistoryRecord.effectiveTo](/docs/functions/functions/api-ref/Function/listTagHistory#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord) fields.
            2. An `=` or `>` or `<` operator.
            3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
            For example, `effective_to>2021-01-01T12:00:00Z`.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/serverless/functions/v1/functions/api-ref/Function/listTagHistory.md
---

# Cloud Functions Service, REST: Function.ListTagHistory

Returns the log of tags assigned to versions of the specified function.

## HTTP request

```
GET https://serverless-functions.{{ api-host }}/functions/v1/functions/{functionId}:tagHistory
```

## Path parameters

#|
||Field | Description ||
|| functionId | **string**

Required field. ID of the function to retrieve tag history for.

To get a function ID, make a [FunctionService.List](/docs/functions/functions/api-ref/Function/list#List) request. ||
|#

## Query parameters {#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryRequest}

#|
||Field | Description ||
|| tag | **string**

Specific tag that history should be limited to. ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`, the service returns a [ListFunctionOperationsResponse.nextPageToken](/docs/functions/functions/api-ref/Function/listOperations#yandex.cloud.serverless.functions.v1.ListFunctionOperationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListFunctionOperationsResponse.nextPageToken](/docs/functions/functions/api-ref/Function/listOperations#yandex.cloud.serverless.functions.v1.ListFunctionOperationsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The expression must specify:
1. The field name. Currently filtering can only be applied to the [FunctionTagHistoryRecord.effectiveFrom](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord) and [FunctionTagHistoryRecord.effectiveTo](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord) fields.
2. An `=` or `>` or `<` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
For example, `effective_to>2021-01-01T12:00:00Z`. ||
|#

## Response {#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse}

**HTTP Code: 200 - OK**

```json
{
  "functionTagHistoryRecord": [
    {
      "functionId": "string",
      "functionVersionId": "string",
      "tag": "string",
      "effectiveFrom": "string",
      "effectiveTo": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| functionTagHistoryRecord[] | **[FunctionTagHistoryRecord](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord)**

Set of relevant tag history records. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListFunctionTagHistoryRequest.pageSize](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryRequest), use `nextPageToken` as the value
for the [ListFunctionTagHistoryRequest.pageToken](#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryRequest) parameter in the next list request.

Each subsequent page will have its own `nextPageToken` to continue paging through the results. ||
|#

## FunctionTagHistoryRecord {#yandex.cloud.serverless.functions.v1.ListFunctionTagHistoryResponse.FunctionTagHistoryRecord}

A record in the tag history.

#|
||Field | Description ||
|| functionId | **string**

ID of the function that the record is about. ||
|| functionVersionId | **string**

ID of the function version that the record is about. ||
|| tag | **string**

Tag that was set for the version at some point. ||
|| effectiveFrom | **string** (date-time)

Timestamp when the tag started being active for the function.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| effectiveTo | **string** (date-time)

Timestamp when the tag stopped being active for the function.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#