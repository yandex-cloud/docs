---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Policy/listApplications.md
---

# Cloud Backup API, gRPC: PolicyService.ListApplications

List applied policies using filters.

## gRPC request

**rpc ListApplications ([ListApplicationsRequest](#yandex.cloud.backup.v1.ListApplicationsRequest)) returns ([ListApplicationsResponse](#yandex.cloud.backup.v1.ListApplicationsResponse))**

## ListApplicationsRequest {#yandex.cloud.backup.v1.ListApplicationsRequest}

```json
{
  // Includes only one of the fields `folder_id`, `policy_id`, `compute_instance_id`
  "folder_id": "string",
  "policy_id": "string",
  "compute_instance_id": "string",
  // end of the list of possible fields
  "show_processing": "bool"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Folder ID.

Includes only one of the fields `folder_id`, `policy_id`, `compute_instance_id`. ||
|| policy_id | **string**

Policy ID.

Includes only one of the fields `folder_id`, `policy_id`, `compute_instance_id`. ||
|| compute_instance_id | **string**

Compute Cloud instance ID.

Includes only one of the fields `folder_id`, `policy_id`, `compute_instance_id`. ||
|| show_processing | **bool**

If true, also returns applications that in the process of binding. ||
|#

## ListApplicationsResponse {#yandex.cloud.backup.v1.ListApplicationsResponse}

```json
{
  "applications": [
    {
      "policy_id": "string",
      "compute_instance_id": "string",
      "enabled": "bool",
      "status": "Status",
      "created_at": "google.protobuf.Timestamp",
      "is_processing": "bool"
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
|| policy_id | **string**

Policy ID. ||
|| compute_instance_id | **string**

Compute Cloud instance ID. ||
|| enabled | **bool** ||
|| status | enum **Status**

- `STATUS_UNSPECIFIED`
- `OK`: Application is applied and everything is OK.
- `RUNNING`: Application is currently running.
- `DISABLED`: Application is disabled. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| is_processing | **bool**

If true, then the policy is in in the process of binding to the instance. ||
|#