[Документация Yandex Cloud](../../../../../index.md) > [Yandex SIEM](../../../../index.md) > Справочник API > REST (англ.) > [Yandex Cloud SIEM Queries API](../index.md) > [Session](index.md) > List

# Yandex Cloud SIEM Queries API, REST: Session.List

Retrieves a list of Sessions.

This returns only Sessions for which the caller has the `siem.queries.get` permission.

## HTTP request

```
GET https://siem.api.cloud.yandex.net/siem/v1/queries/sessions
```

## Query parameters {#yandex.cloud.siem.v1.queries.ListSessionsRequest}

#|
||Field | Description ||
|| siemInstanceId | **string**

Required field. Required. ID of related SIEM instance.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent List requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous List request to
get the next page of results.

The maximum string length in characters is 100. ||
|| filter | **string**

Optional. A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|| orderBy | **string**

Optional. By which column the listing should be ordered and in which direction,
format is "&lt;field&gt; &lt;direction&gt;", default is "created_at desc".

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.siem.v1.queries.ListSessionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "sessions": [
    {
      "siemInstanceId": "string",
      "id": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "status": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "createdBy": "string",
      "updatedBy": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| sessions[] | **[Session](#yandex.cloud.siem.v1.queries.Session)**

Requested list of Sessions ||
|| nextPageToken | **string**

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
|| siemInstanceId | **string**

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
|| status | **enum** (Status)

Session status

- `CREATING`: Session is being created
- `ACTIVE`: Session is active
- `UPDATING`: Session is updating
- `DELETING`: Session is deleting
- `DELETED`: Session is deleted ||
|| createdAt | **string** (date-time)

The time when Session was created at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

The time when Session was last updated at.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who created Session ||
|| updatedBy | **string**

ID of the user or service account who updated Session. ||
|#