---
editable: false
apiPlayground:
  - url: https://loadtesting.{{ api-host }}/loadtesting/api/v1/configs
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to list configs in.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `page_size`, the service returns a [ListConfigsResponse.nextPageToken](/docs/load-testing/user/api-ref/Config/list#yandex.cloud.loadtesting.api.v1.ListConfigsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListConfigsResponse.nextPageToken](/docs/load-testing/user/api-ref/Config/list#yandex.cloud.loadtesting.api.v1.ListConfigsResponse) returned by a previous list request.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters tests listed in the response.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/loadtesting/api/v1/user/api-ref/Config/list.md
---

# Load Testing API, REST: Config.List

Retrieves the list of configs in the specified folder.

## HTTP request

```
GET https://loadtesting.{{ api-host }}/loadtesting/api/v1/configs
```

## Query parameters {#yandex.cloud.loadtesting.api.v1.ListConfigsRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list configs in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListConfigsResponse.nextPageToken](#yandex.cloud.loadtesting.api.v1.ListConfigsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigsResponse.nextPageToken](#yandex.cloud.loadtesting.api.v1.ListConfigsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters tests listed in the response. ||
|#

## Response {#yandex.cloud.loadtesting.api.v1.ListConfigsResponse}

**HTTP Code: 200 - OK**

```json
{
  "configs": [
    {
      "id": "string",
      "folderId": "string",
      "yamlString": "string",
      "name": "string",
      "createdAt": "string",
      "createdBy": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| configs[] | **[Config](#yandex.cloud.loadtesting.api.v1.config.Config)**

List of configs in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListConfigsRequest.pageSize](#yandex.cloud.loadtesting.api.v1.ListConfigsRequest), use `next_page_token` as the value
for the [ListConfigsRequest.pageToken](#yandex.cloud.loadtesting.api.v1.ListConfigsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Config {#yandex.cloud.loadtesting.api.v1.config.Config}

Test config.

#|
||Field | Description ||
|| id | **string**

ID of the test config. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the config belongs to. ||
|| yamlString | **string**

Config content in YAML format. ||
|| name | **string**

Name of the config. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

UA or SA that created the config. ||
|#