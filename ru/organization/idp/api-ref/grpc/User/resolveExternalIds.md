---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/User/resolveExternalIds.md
---

# Identity Provider API, gRPC: UserService.ResolveExternalIds

Resolves external IDs to internal user IDs.

## gRPC request

**rpc ResolveExternalIds ([ResolveExternalIdsRequest](#yandex.cloud.organizationmanager.v1.idp.ResolveExternalIdsRequest)) returns ([ResolveExternalIdsResponse](#yandex.cloud.organizationmanager.v1.idp.ResolveExternalIdsResponse))**

## ResolveExternalIdsRequest {#yandex.cloud.organizationmanager.v1.idp.ResolveExternalIdsRequest}

```json
{
  "userpool_id": "string",
  "external_ids": [
    "string"
  ]
}
```

Request to resolve external IDs to internal user IDs.

#|
||Field | Description ||
|| userpool_id | **string**

Required field. ID of the userpool to resolve external IDs in. ||
|| external_ids[] | **string**

List of external IDs to resolve. ||
|#

## ResolveExternalIdsResponse {#yandex.cloud.organizationmanager.v1.idp.ResolveExternalIdsResponse}

```json
{
  "resolved_users": [
    {
      "user_id": "string",
      "external_id": "string",
      "userpool_id": "string"
    }
  ]
}
```

Response for the [UserService.ResolveExternalIds](#ResolveExternalIds) operation.

#|
||Field | Description ||
|| resolved_users[] | **[ResolvedUser](#yandex.cloud.organizationmanager.v1.idp.ResolvedUser)**

List of resolved users. ||
|#

## ResolvedUser {#yandex.cloud.organizationmanager.v1.idp.ResolvedUser}

Information about a resolved user.

#|
||Field | Description ||
|| user_id | **string**

Internal user ID. ||
|| external_id | **string**

External identifier. ||
|| userpool_id | **string**

ID of the userpool the user belongs to. ||
|#