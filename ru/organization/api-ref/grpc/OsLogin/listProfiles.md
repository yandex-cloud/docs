---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/OsLogin/listProfiles.md
---

# Cloud Organization API, gRPC: OsLoginService.ListProfiles {#ListProfiles}

## gRPC request

**rpc ListProfiles ([ListOsLoginProfilesRequest](#yandex.cloud.organizationmanager.v1.ListOsLoginProfilesRequest)) returns ([ListOsLoginProfilesResponse](#yandex.cloud.organizationmanager.v1.ListOsLoginProfilesResponse))**

## ListOsLoginProfilesRequest {#yandex.cloud.organizationmanager.v1.ListOsLoginProfilesRequest}

```json
{
  "organizationId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field.  ||
|| pageSize | **int64** ||
|| pageToken | **string** ||
|| filter | **string**

A filter expression that filters profiles listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering by subject_id, uid or login.
2. An `=` operator.
3. The value in double quotes (`"`).
E.g. login="example-login" ||
|#

## ListOsLoginProfilesResponse {#yandex.cloud.organizationmanager.v1.ListOsLoginProfilesResponse}

```json
{
  "profiles": [
    {
      "id": "string",
      "organizationId": "string",
      "subjectId": "string",
      "login": "string",
      "uid": "int64",
      "isDefault": "bool",
      "homeDirectory": "string",
      "shell": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| profiles[] | **[OsLoginProfile](#yandex.cloud.organizationmanager.v1.OsLoginProfile)** ||
|| nextPageToken | **string** ||
|#

## OsLoginProfile {#yandex.cloud.organizationmanager.v1.OsLoginProfile}

#|
||Field | Description ||
|| id | **string** ||
|| organizationId | **string** ||
|| subjectId | **string** ||
|| login | **string** ||
|| uid | **int64** ||
|| isDefault | **bool** ||
|| homeDirectory | **string** ||
|| shell | **string** ||
|#