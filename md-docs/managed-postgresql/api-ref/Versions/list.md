[Документация Yandex Cloud](../../../index.md) > [Yandex Managed Service for PostgreSQL](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Versions](index.md) > List

# Managed Service for PostgreSQL API, REST: Versions.List

Returns list of available PostgreSQL versions.

## HTTP request

```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/versions
```

## Query parameters {#yandex.cloud.mdb.postgresql.v1.ListVersionsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListVersions requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListVersions
request to get the next page of results.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.mdb.postgresql.v1.ListVersionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "version": [
    {
      "id": "string",
      "name": "string",
      "status": "string",
      "updatableTo": [
        "string"
      ],
      "deprecatedAt": "string",
      "eolAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| version[] | **[Version](#yandex.cloud.mdb.v1.Version)**

Requested list of available versions. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for ListVersions requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListVersions request. Subsequent ListVersions
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## Version {#yandex.cloud.mdb.v1.Version}

Common message for describing a Managed Database version.

#|
||Field | Description ||
|| id | **string**

Version ID ||
|| name | **string**

Version name ||
|| status | **enum** (Status)

Version status

- `NEW`: Newly released version. New clusters can be created.
Support may not yet be available in full scope.
- `ACTUAL`: Newly released version. New clusters can be created.
- `SUPPORTED`: Fully supported version.
- `DEPRECATED`: Version approaching end of support. New cluster creation is not allowed.
Existing clusters continue to operate. Restore from backups is available.
- `LEGACY`: Deprecated version billed at an increased rate.
New cluster creation and restore from backups are not allowed.
Existing clusters continue to operate; automatic upgrade may be scheduled.
- `EOL`: End-of-life version. Clusters are forcibly upgraded to a supported version or shut down. ||
|| updatableTo[] | **string**

List of version IDs that the current version can be updated to ||
|| deprecatedAt | **string** (date-time)

Optional. Date when the version reaches DEPRECATED status (day precision)


String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| eolAt | **string** (date-time)

Optional. Date when the version reaches EOL status (day precision)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#