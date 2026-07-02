[Документация Yandex Cloud](../../../index.md) > [Yandex Identity and Access Management](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Role](index.md) > List

# Identity and Access Management API, REST: Role.List

Retrieves the list of Role resources.

## HTTP request

```
GET https://iam.api.cloud.yandex.net/iam/v1/roles
```

## Query parameters {#yandex.cloud.iam.v1.ListRolesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListRolesResponse.nextPageToken](#yandex.cloud.iam.v1.ListRolesResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken`
to the [ListRolesResponse.nextPageToken](#yandex.cloud.iam.v1.ListRolesResponse)
returned by a previous list request.

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
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

A Role resource. For more information, see [Roles](../../concepts/access-control/roles.md).

#|
||Field | Description ||
|| id | **string**

ID of the role. ||
|| description | **string**

Description of the role. 0-256 characters long. ||
|#