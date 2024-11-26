---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/OsLogin/listProfiles.md
---

# Cloud Organization API, gRPC: OsLoginService.ListProfiles

## gRPC request

**rpc ListProfiles ([ListOsLoginProfilesRequest](#yandex.cloud.organizationmanager.v1.ListOsLoginProfilesRequest)) returns ([ListOsLoginProfilesResponse](#yandex.cloud.organizationmanager.v1.ListOsLoginProfilesResponse))**

## ListOsLoginProfilesRequest {#yandex.cloud.organizationmanager.v1.ListOsLoginProfilesRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field.  ||
|| page_size | **int64** ||
|| page_token | **string** ||
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
      "organization_id": "string",
      "subject_id": "string",
      "login": "string",
      "uid": "int64",
      "is_default": "bool",
      "home_directory": "string",
      "shell": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| profiles[] | **[OsLoginProfile](#yandex.cloud.organizationmanager.v1.OsLoginProfile)** ||
|| next_page_token | **string** ||
|#

## OsLoginProfile {#yandex.cloud.organizationmanager.v1.OsLoginProfile}

#|
||Field | Description ||
|| id | **string** ||
|| organization_id | **string** ||
|| subject_id | **string** ||
|| login | **string** ||
|| uid | **int64** ||
|| is_default | **bool** ||
|| home_directory | **string** ||
|| shell | **string** ||
|#