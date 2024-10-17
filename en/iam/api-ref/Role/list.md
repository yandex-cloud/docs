---
editable: false
sourcePath: en/_api-ref/iam/v1/api-ref/Role/list.md
---

# Identity and Access Management API, REST: Role.List {#List}

Retrieves the list of Role resources.

## HTTP request

```
GET https://iam.{{ api-host }}/iam/v1/roles
```

## Query parameters {#yandex.cloud.iam.v1.ListRolesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRolesResponse.nextPageToken](#yandex.cloud.iam.v1.ListRolesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListRolesResponse.nextPageToken](#yandex.cloud.iam.v1.ListRolesResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response. ||
|#

## Response {#yandex.cloud.iam.v1.ListRolesResponse}

**HTTP Code: 200 - OK**

```json
{
  "roles": [
    {
      "id": "string",
      "description": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| roles[] | **[Role](#yandex.cloud.iam.v1.Role)**

List of Role resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRolesRequest.pageSize](#yandex.cloud.iam.v1.ListRolesRequest), use
the `nextPageToken` as the value
for the [ListRolesRequest.pageToken](#yandex.cloud.iam.v1.ListRolesRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## Role {#yandex.cloud.iam.v1.Role}

A Role resource. For more information, see [Roles](/docs/iam/concepts/access-control/roles).

#|
||Field | Description ||
|| id | **string**

ID of the role. ||
|| description | **string**

Description of the role. 0-256 characters long. ||
|#