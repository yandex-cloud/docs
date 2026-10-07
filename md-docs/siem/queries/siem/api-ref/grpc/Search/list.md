[Документация Yandex Cloud](../../../../../../index.md) > [Yandex SIEM](../../../../../index.md) > Справочник API > gRPC (англ.) > [Yandex Cloud SIEM Queries API](../index.md) > [Search](index.md) > List

# Yandex Cloud SIEM Queries API, gRPC: SearchService.List

Retrieves a list of Searches in a Session.

## gRPC request

**rpc List ([ListSearchesRequest](#yandex.cloud.siem.v1.queries.ListSearchesRequest)) returns ([ListSearchesResponse](#yandex.cloud.siem.v1.queries.ListSearchesResponse))**

## ListSearchesRequest {#yandex.cloud.siem.v1.queries.ListSearchesRequest}

```json
{
  "session_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| session_id | **string**

Required field. Required. ID of the Session to list Searches in

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent List requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous List request to
get the next page of results.

The maximum string length in characters is 100. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## ListSearchesResponse {#yandex.cloud.siem.v1.queries.ListSearchesResponse}

```json
{
  "searches": [
    {
      "id": "string",
      "session_id": "string",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "status": "Status",
      "created_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "created_by": "string",
      "updated_by": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| searches[] | **[Search](#yandex.cloud.siem.v1.queries.Search)**

Requested list of Searches. ||
|| next_page_token | **string**

This token allows you to get the next page of results for List requests if the number of
results is larger than `page_size` specified in the request. To get the next page, specify
the value of `next_page_token` as a value for the `page_token` parameter in the next List
request. Subsequent List requests will have their own `next_page_token` to continue paging
through the results. ||
|#

## Search {#yandex.cloud.siem.v1.queries.Search}

Search is a resource describing a single search in session.

#|
||Field | Description ||
|| id | **string**

Required field. Required. Unique ID of the Search.
This ID is assigned by services in the process of creating a Search.

The maximum string length in characters is 50. ||
|| session_id | **string**

Required field. Required. ID of the Session that Search belongs to.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Required. Name of the Search.
The name is unique within the Session. 1-64 characters long.

The maximum string length in characters is 64. ||
|| description | **string**

The description of the Search. 0-256 characters long.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| status | enum **Status**

Search status

- `CREATING`: Search is being created
- `ACTIVE`: Search is active
- `UPDATING`: Search is being updated
- `DELETING`: Search is being deleted
- `DELETED`: Search is deleted ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when Search was created at. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when Search was last updated at. ||
|| created_by | **string**

ID of the user or service account who created the Search. ||
|| updated_by | **string**

ID of the user or service account who updated the Search. ||
|#