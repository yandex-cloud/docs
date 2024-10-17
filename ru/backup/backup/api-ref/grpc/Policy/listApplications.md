---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Policy/listApplications.md
---

# Cloud Backup API, gRPC: PolicyService.ListApplications {#ListApplications}

List applied policies using filters.

## gRPC request

**rpc ListApplications ([ListApplicationsRequest](#yandex.cloud.backup.v1.ListApplicationsRequest)) returns ([ListApplicationsResponse](#yandex.cloud.backup.v1.ListApplicationsResponse))**

## ListApplicationsRequest {#yandex.cloud.backup.v1.ListApplicationsRequest}

```json
{
  // Includes only one of the fields `folderId`, `policyId`, `computeInstanceId`
  "folderId": "string",
  "policyId": "string",
  "computeInstanceId": "string",
  // end of the list of possible fields
  "showProcessing": "bool"
}
```

#|
||Field | Description ||
|| folderId | **string**

Folder ID.

Includes only one of the fields `folderId`, `policyId`, `computeInstanceId`. ||
|| policyId | **string**

Policy ID.

Includes only one of the fields `folderId`, `policyId`, `computeInstanceId`. ||
|| computeInstanceId | **string**

Compute Cloud instance ID.

Includes only one of the fields `folderId`, `policyId`, `computeInstanceId`. ||
|| showProcessing | **bool**

If true, also returns applications that in the process of binding. ||
|#

## ListApplicationsResponse {#yandex.cloud.backup.v1.ListApplicationsResponse}

```json
{
  "applications": [
    {
      "policyId": "string",
      "computeInstanceId": "string",
      "enabled": "bool",
      "status": "Status",
      "createdAt": "google.protobuf.Timestamp",
      "isProcessing": "bool"
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
|| enabled | **bool** ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `OK`: Application is applied and everything is OK.
- `RUNNING`: Application is currently running.
- `DISABLED`: Application is disabled. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| isProcessing | **bool**

If true, then the policy is in in the process of binding to the instance. ||
|#