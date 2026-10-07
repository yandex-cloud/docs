---
editable: false
---

# Yandex Cloud SIEM Queries API, gRPC: SessionService.List

Retrieves a list of Sessions.

This returns only Sessions for which the caller has the `siem.queries.get` permission.

## gRPC request

**rpc List ([ListSessionsRequest](#yandex.cloud.siem.v1.queries.ListSessionsRequest)) returns ([ListSessionsResponse](#yandex.cloud.siem.v1.queries.ListSessionsResponse))**

## ListSessionsRequest {#yandex.cloud.siem.v1.queries.ListSessionsRequest}

```json
{
  "siem_instance_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| siem_instance_id | **string**

Required field. Required. ID of related SIEM instance.

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

Optional. A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|| order_by | **string**

Optional. By which column the listing should be ordered and in which direction,
format is "&lt;field&gt; &lt;direction&gt;", default is "created_at desc".

The maximum string length in characters is 1000. ||
|#

## ListSessionsResponse {#yandex.cloud.siem.v1.queries.ListSessionsResponse}

```json
{
  "sessions": [
    {
      "siem_instance_id": "string",
      "id": "string",
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
|| sessions[] | **[Session](#yandex.cloud.siem.v1.queries.Session)**

Requested list of Sessions ||
|| next_page_token | **string**

This token allows you to get the next page of results for List requests if the number of
results is larger than `page_size` specified in the request. To get the next page, specify
the value of `next_page_token` as a value for the `page_token` parameter in the next List
request. Subsequent List requests will have their own `next_page_token` to continue paging
through the results. ||
|#

## Session {#yandex.cloud.siem.v1.queries.Session}

Session is a container for Datasets and Searches.

#|
||Field | Description ||
|| siem_instance_id | **string**

Required. ID of related SIEM instance. ||
|| id | **string**

Required field. Required. Unique ID of the Session.
This ID is assigned by services in the process of creating a Session.

The maximum string length in characters is 50. ||
|| name | **string**

Required field. Required. Name of the Session. 1-64 characters long.

The maximum string length in characters is 64. ||
|| description | **string**

The description of the Session. 0-256 characters long.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| status | enum **Status**

Session status

- `CREATING`: Session is being created
- `ACTIVE`: Session is active
- `UPDATING`: Session is updating
- `DELETING`: Session is deleting
- `DELETED`: Session is deleted ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when Session was created at. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when Session was last updated at. ||
|| created_by | **string**

ID of the user or service account who created Session ||
|| updated_by | **string**

ID of the user or service account who updated Session. ||
|#