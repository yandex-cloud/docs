---
editable: false
---

# Managed Service for Redis API, gRPC: VersionsService.List

Returns list of available Redis versions.

## gRPC request

**rpc List ([ListVersionsRequest](#yandex.cloud.mdb.redis.v1.ListVersionsRequest)) returns ([ListVersionsResponse](#yandex.cloud.mdb.redis.v1.ListVersionsResponse))**

## ListVersionsRequest {#yandex.cloud.mdb.redis.v1.ListVersionsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListVersions requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListVersions
request to get the next page of results.

The maximum string length in characters is 100. ||
|#

## ListVersionsResponse {#yandex.cloud.mdb.redis.v1.ListVersionsResponse}

```json
{
  "version": [
    {
      "id": "string",
      "name": "string",
      "status": "Status",
      "updatable_to": [
        "string"
      ],
      "deprecated_at": "google.protobuf.Timestamp",
      "eol_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| version[] | **[Version](#yandex.cloud.mdb.v1.Version)**

Requested list of available versions. ||
|| next_page_token | **string**

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
|| status | enum **Status**

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
|| updatable_to[] | **string**

List of version IDs that the current version can be updated to ||
|| deprecated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Optional. Date when the version reaches DEPRECATED status (day precision)
 ||
|| eol_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Optional. Date when the version reaches EOL status (day precision) ||
|#