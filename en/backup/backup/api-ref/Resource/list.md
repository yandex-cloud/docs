---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Resource/list.md
---

# Cloud Backup API, REST: Resource.List

List resources: Compute Cloud instances.

## HTTP request

```
GET https://backup.{{ api-host }}/backup/v1/resources
```

## Query parameters {#yandex.cloud.backup.v1.ListResourcesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID. ||
|| pageSize | **string** (int64)

Number of results per page. ||
|| pageToken | **string**

Token for the results page. ||
|| type | **enum** (ResourceType)

Type of resource. Could be compute VM or baremetal server.

- `RESOURCE_TYPE_UNSPECIFIED`
- `COMPUTE`: Resource is Compute Cloud VM
- `BMS`: Resource is baremetal server ||
|#

## Response {#yandex.cloud.backup.v1.ListResourcesResponse}

**HTTP Code: 200 - OK**

```json
{
  "resources": [
    {
      "computeInstanceId": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "online": "boolean",
      "enabled": "boolean",
      "status": "string",
      "statusDetails": "string",
      "statusProgress": "string",
      "lastBackupTime": "string",
      "nextBackupTime": "string",
      "resourceId": "string",
      "isActive": "boolean",
      "initStatus": "string",
      "metadata": "string",
      "type": "string",
      "tenantInfo": {
        "folderId": "string",
        "personalTenantId": "string",
        "userId": "string"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| resources[] | **[Resource](#yandex.cloud.backup.v1.Resource)**

Set of resource parameters. ||
|| nextPageToken | **string**

Token for the next results page. ||
|#

## Resource {#yandex.cloud.backup.v1.Resource}

#|
||Field | Description ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| online | **boolean**

If this field is true, it means that instance is online. ||
|| enabled | **boolean**

If this field is true, it means that backup is enabled to instance. ||
|| status | **enum** (Status)

- `STATUS_UNSPECIFIED`
- `IDLE`: Compute Cloud instance is doing nothing right now.
- `BACKUPING`: Compute Cloud instance is currently backing up itself.
- `RECOVERING`: Compute Cloud instance is currently recovering itself.
- `FAILED`: Compute Cloud instance is in failure state, check content of
`status_details` field for more information.
- `OTHER`: Unspecified state, check `status_details` field
for more information. ||
|| statusDetails | **string**

If status value is one of `OTHER` or `FAILED`,
detailed info might be stored here. ||
|| statusProgress | **string** (int64)

In case status is one of `BACKUPING` or `RECOVERING`,
progress value might be found here. ||
|| lastBackupTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| nextBackupTime | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| resourceId | **string**

Resource ID is used to identify Compute Cloud instance in backup service. ||
|| isActive | **boolean**

Status `is_active` shows whether current Compute Cloud instance controls Cloud Backup resource.
If status `is_active` is false it means Compute Cloud instance is not able to manipulate
Cloud Backup resource. ||
|| initStatus | **enum** (InitStatus)

Status of resource initialization in cloud backup service.

- `INIT_STATUS_UNSPECIFIED`
- `REGISTERING`: Registration of instance in cloud backups have started.
- `REGISTRED`: Instance is registered in cloud backups.
- `FAILED_REGISTRATION`: Instance registration failed.
- `DELETED`: Instance is deleted from cloud backup service. ||
|| metadata | **string**

Metadata to provide details about instance registration process
if status is FAILED_REGISTRATION or REGISTERING ||
|| type | **enum** (ResourceType)

Type of resource. Could be compute VM or baremetal server.

- `RESOURCE_TYPE_UNSPECIFIED`
- `COMPUTE`: Resource is Compute Cloud VM
- `BMS`: Resource is baremetal server ||
|| tenantInfo | **[TenantInfo](#yandex.cloud.backup.v1.TenantInfo)**

Additional info abount tenant which resource belongs to ||
|#

## TenantInfo {#yandex.cloud.backup.v1.TenantInfo}

#|
||Field | Description ||
|| folderId | **string**

Folder ID ||
|| personalTenantId | **string**

Personal tenant id from backup provider ||
|| userId | **string**

User id from provider ||
|#