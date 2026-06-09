# Identity Provider API, REST: User.ResolveExternalIds

Resolves external IDs to internal user IDs.

## HTTP request

```
POST https://organization-manager.api.cloud.yandex.net/organization-manager/v1/idp/users:resolveExternalIds
```

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.ResolveExternalIdsRequest}

```json
{
  "userpoolId": "string",
  "externalIds": [
    "string"
  ]
}
```

Request to resolve external IDs to internal user IDs.

#|
||Field | Description ||
|| userpoolId | **string**

Required field. ID of the userpool to resolve external IDs in.

The maximum string length in characters is 50. ||
|| externalIds[] | **string**

List of external IDs to resolve.

The maximum string length in characters for each value is 256. The number of elements must be in the range 1-1000. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.ResolveExternalIdsResponse}

**HTTP Code: 200 - OK**

```json
{
  "resolvedUsers": [
    {
      "userId": "string",
      "externalId": "string",
      "userpoolId": "string"
    }
  ]
}
```

Response for the [UserService.ResolveExternalIds](#ResolveExternalIds) operation.

#|
||Field | Description ||
|| resolvedUsers[] | **[ResolvedUser](#yandex.cloud.organizationmanager.v1.idp.ResolvedUser)**

List of resolved users. ||
|#

## ResolvedUser {#yandex.cloud.organizationmanager.v1.idp.ResolvedUser}

Information about a resolved user.

#|
||Field | Description ||
|| userId | **string**

Internal user ID. ||
|| externalId | **string**

External identifier. ||
|| userpoolId | **string**

ID of the userpool the user belongs to. ||
|#