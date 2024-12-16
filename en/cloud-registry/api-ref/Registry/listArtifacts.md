---
editable: false
sourcePath: en/_api-ref/cloudregistry/v1/api-ref/Registry/listArtifacts.md
---

# Yandex Cloud Registry API, REST: Registry.ListArtifacts

Retrieves the list of registry artifact resources in the specified registry.

## HTTP request

```
GET https://registry.{{ api-host }}/cloud-registry/v1/registries/{registryId}:listArtifacts
```

## Path parameters

#|
||Field | Description ||
|| registryId | **string**

Required field. ID of the registry artifact to list repositories in.

To get the registry ID use a [ArtifactService.List](/docs/cloud-registry/api-ref/Registry/list#List) request. ||
|#

## Query parameters {#yandex.cloud.cloudregistry.v1.ListArtifactsRequest}

#|
||Field | Description ||
|| path | **string**

The path to a specific node where the registry artifact is located. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRepositoriesResponse.next_page_token]
that can be used to get the next page of results in subsequent list requests.
Default value: 10. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListArtifactsResponse.nextPageToken](#yandex.cloud.cloudregistry.v1.ListArtifactsResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.cloudregistry.v1.ListArtifactsResponse}

**HTTP Code: 200 - OK**

```json
{
  "artifacts": [
    {
      "id": "string",
      "path": "string",
      "name": "string",
      "kind": "string",
      "status": "string",
      "createdAt": "string",
      "modifiedAt": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| artifacts[] | **[Artifact](#yandex.cloud.cloudregistry.v1.Artifact)**

List of Registry artifact resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRegistriesRequest.pageSize](/docs/cloud-registry/api-ref/Registry/list#yandex.cloud.cloudregistry.v1.ListRegistriesRequest), use
the `nextPageToken` as the value
for the [ListArtifactsRequest.pageToken](#yandex.cloud.cloudregistry.v1.ListArtifactsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Artifact {#yandex.cloud.cloudregistry.v1.Artifact}

A Artifact resource.

#|
||Field | Description ||
|| id | **string**

Output only. ID of the artifact. ||
|| path | **string**

Path where the artifact is located. ||
|| name | **string**

Name of the artifact. ||
|| kind | **enum** (Kind)

Kind of the artifact.

- `KIND_UNSPECIFIED`
- `FOLDER`: Artifact kind is folder.
- `PACKAGE`: Artifact kind is package.
- `ARTIFACT`: Artifact kind is artifact. ||
|| status | **enum** (Status)

Output only. Status of the artifact.

- `STATUS_UNSPECIFIED`
- `CREATING`: Artifact status is being created.
- `ACTIVE`: Artifact status is ready to use.
- `DELETING`: Artifact status is being deleted. ||
|| createdAt | **string** (date-time)

Output only. Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| modifiedAt | **string** (date-time)

Output only. Modification timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#