---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Policy/listApplications.md
---

# Cloud Backup API, REST: Policy.ListApplications

List applied policies using filters.

## HTTP request

```
GET https://backup.{{ api-host }}/backup/v1/policies/{policyId}/applications
```

## Path parameters

#|
||Field | Description ||
|| policyId | **string**

Required field. Policy ID.

Includes only one of the fields `folderId`, `policyId`, `computeInstanceId`. ||
|#

## Query parameters {#yandex.cloud.backup.v1.ListApplicationsRequest}

#|
||Field | Description ||
|| folderId | **string**

Folder ID.

Includes only one of the fields `folderId`, `policyId`, `computeInstanceId`. ||
|| computeInstanceId | **string**

Compute Cloud instance ID.

Includes only one of the fields `folderId`, `policyId`, `computeInstanceId`. ||
|| showProcessing | **boolean**

If true, also returns applications that in the process of binding. ||
|#

## Response {#yandex.cloud.backup.v1.ListApplicationsResponse}

**HTTP Code: 200 - OK**

```json
{
  "applications": [
    {
      "policyId": "string",
      "computeInstanceId": "string",
      "enabled": "boolean",
      "status": "string",
      "createdAt": "string",
      "isProcessing": "boolean"
    }
  ]
}
```

#|
||Field | Description ||
|| applications[] | **[PolicyApplication](#yandex.cloud.backup.v1.PolicyApplication)** ||
|#

## PolicyApplication {#yandex.cloud.backup.v1.PolicyApplication}

#|
||Field | Description ||
|| policyId | **string**

Policy ID. ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| enabled | **boolean** ||
|| status | **enum** (Status)

- `STATUS_UNSPECIFIED`
- `OK`: Application is applied and everything is OK.
- `RUNNING`: Application is currently running.
- `DISABLED`: Application is disabled. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| isProcessing | **boolean**

If true, then the policy is in in the process of binding to the instance. ||
|#