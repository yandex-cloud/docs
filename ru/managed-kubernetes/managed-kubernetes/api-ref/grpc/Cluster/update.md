---
editable: false
---

# Managed Services for Kubernetes API, gRPC: ClusterService.Update

Updates the specified Kubernetes cluster.

## gRPC request

**rpc Update ([UpdateClusterRequest](#yandex.cloud.k8s.v1.UpdateClusterRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterRequest {#yandex.cloud.k8s.v1.UpdateClusterRequest}

```json
{
  "cluster_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "master_spec": {
    "version": {
      // Includes only one of the fields `version`, `latest_revision`
      "version": "string",
      "latest_revision": "bool"
      // end of the list of possible fields
    },
    "maintenance_policy": {
      "auto_upgrade": "bool",
      "maintenance_window": {
        // Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`
        "anytime": "AnytimeMaintenanceWindow",
        "daily_maintenance_window": {
          "start_time": "google.type.TimeOfDay",
          "duration": "google.protobuf.Duration"
        },
        "weekly_maintenance_window": {
          "days_of_week": [
            {
              "days": [
                "DayOfWeek"
              ],
              "start_time": "google.type.TimeOfDay",
              "duration": "google.protobuf.Duration"
            }
          ]
        }
        // end of the list of possible fields
      }
    },
    "security_group_ids": [
      "string"
    ],
    "master_logging": {
      "enabled": "bool",
      // Includes only one of the fields `log_group_id`, `folder_id`
      "log_group_id": "string",
      "folder_id": "string",
      // end of the list of possible fields
      "audit_enabled": "bool",
      "cluster_autoscaler_enabled": "bool",
      "kube_apiserver_enabled": "bool",
      "events_enabled": "bool"
    },
    "locations": [
      {
        "zone_id": "string",
        "subnet_id": "string"
      }
    ],
    "external_v6_address_spec": {
      "address": "string"
    },
    "scale_policy": {
      // Includes only one of the fields `auto_scale`
      "auto_scale": {
        "min_resource_preset_id": "string"
      }
      // end of the list of possible fields
    }
  },
  // Includes only one of the fields `gateway_ipv4_address`
  "gateway_ipv4_address": "string",
  // end of the list of possible fields
  "service_account_id": "string",
  "node_service_account_id": "string",
  "network_policy": {
    "provider": "Provider"
  },
  "ip_allocation_policy": {
    "cluster_ipv4_cidr_block": "string",
    "node_ipv4_cidr_mask_size": "int64",
    "service_ipv4_cidr_block": "string",
    "cluster_ipv6_cidr_block": "string",
    "service_ipv6_cidr_block": "string"
  },
  "workload_identity_federation": {
    "enabled": "bool"
  }
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Kubernetes cluster to update.
To get the Kubernetes cluster ID use a [ClusterService.List](/docs/managed-kubernetes/managed-kubernetes/api-ref/grpc/Cluster/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)** ||
|| name | **string**

Name of the Kubernetes cluster.
The name must be unique within the folder.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

Description of the Kubernetes cluster.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.
Existing set of `labels` is completely replaced by the provided set.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| master_spec | **[MasterUpdateSpec](#yandex.cloud.k8s.v1.MasterUpdateSpec)**

Specification of the master update. ||
|| gateway_ipv4_address | **string**

Gateway IPv4 address.

The maximum string length in characters is 15.

Includes only one of the fields `gateway_ipv4_address`. ||
|| service_account_id | **string**

Service account to be used for provisioning Compute Cloud and VPC resources for Kubernetes cluster.
Selected service account should have `edit` role on the folder where the Kubernetes cluster will be
located and on the folder where selected network resides. ||
|| node_service_account_id | **string**

Service account to be used by the worker nodes of the Kubernetes cluster to access Container Registry
or to push node logs and metrics. ||
|| network_policy | **[NetworkPolicy](#yandex.cloud.k8s.v1.NetworkPolicy)** ||
|| ip_allocation_policy | **[IPAllocationPolicy](#yandex.cloud.k8s.v1.IPAllocationPolicy)** ||
|| workload_identity_federation | **[WorkloadIdentityFederationSpec](#yandex.cloud.k8s.v1.WorkloadIdentityFederationSpec)** ||
|#

## MasterUpdateSpec {#yandex.cloud.k8s.v1.MasterUpdateSpec}

#|
||Field | Description ||
|| version | **[UpdateVersionSpec](#yandex.cloud.k8s.v1.UpdateVersionSpec)**

Specification of the master update. ||
|| maintenance_policy | **[MasterMaintenancePolicy](#yandex.cloud.k8s.v1.MasterMaintenancePolicy)**

Maintenance policy of the master. ||
|| security_group_ids[] | **string**

Master security groups. ||
|| master_logging | **[MasterLogging](#yandex.cloud.k8s.v1.MasterLogging)**

Cloud Logging for master components. ||
|| locations[] | **[LocationSpec](#yandex.cloud.k8s.v1.LocationSpec)**

Update master instance locations. ||
|| external_v6_address_spec | **[ExternalAddressSpec](#yandex.cloud.k8s.v1.ExternalAddressSpec)**

Specification of parameters for external IPv6 networking. ||
|| scale_policy | **[MasterScalePolicySpec](#yandex.cloud.k8s.v1.MasterScalePolicySpec)**

Scale policy of the master. ||
|#

## UpdateVersionSpec {#yandex.cloud.k8s.v1.UpdateVersionSpec}

#|
||Field | Description ||
|| version | **string**

Request update to a newer version of Kubernetes (1.x -> 1.y).

Includes only one of the fields `version`, `latest_revision`. ||
|| latest_revision | **bool**

Request update to the latest revision for the current version.

Includes only one of the fields `version`, `latest_revision`. ||
|#

## MasterMaintenancePolicy {#yandex.cloud.k8s.v1.MasterMaintenancePolicy}

#|
||Field | Description ||
|| auto_upgrade | **bool**

If set to true, automatic updates are installed in the specified period of time with no interaction from the user.
If set to false, automatic upgrades are disabled. ||
|| maintenance_window | **[MaintenanceWindow](#yandex.cloud.k8s.v1.MaintenanceWindow)**

Maintenance window settings. Update will start at the specified time and last no more than the specified duration.
The time is set in UTC. ||
|#

## MaintenanceWindow {#yandex.cloud.k8s.v1.MaintenanceWindow}

#|
||Field | Description ||
|| anytime | **[AnytimeMaintenanceWindow](#yandex.cloud.k8s.v1.AnytimeMaintenanceWindow)**

Updating the master at any time.

Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`.

Maintenance policy. ||
|| daily_maintenance_window | **[DailyMaintenanceWindow](#yandex.cloud.k8s.v1.DailyMaintenanceWindow)**

Updating the master on any day during the specified time window.

Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`.

Maintenance policy. ||
|| weekly_maintenance_window | **[WeeklyMaintenanceWindow](#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow)**

Updating the master on selected days during the specified time window.

Includes only one of the fields `anytime`, `daily_maintenance_window`, `weekly_maintenance_window`.

Maintenance policy. ||
|#

## AnytimeMaintenanceWindow {#yandex.cloud.k8s.v1.AnytimeMaintenanceWindow}

#|
||Field | Description ||
|| Empty | > ||
|#

## DailyMaintenanceWindow {#yandex.cloud.k8s.v1.DailyMaintenanceWindow}

#|
||Field | Description ||
|| start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Window duration. ||
|#

## WeeklyMaintenanceWindow {#yandex.cloud.k8s.v1.WeeklyMaintenanceWindow}

#|
||Field | Description ||
|| days_of_week[] | **[DaysOfWeekMaintenanceWindow](#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow)**

Days of the week and the maintenance window for these days when automatic updates are allowed.

The number of elements must be in the range 1-7. ||
|#

## DaysOfWeekMaintenanceWindow {#yandex.cloud.k8s.v1.DaysOfWeekMaintenanceWindow}

#|
||Field | Description ||
|| days[] | enum **DayOfWeek**

Days of the week when automatic updates are allowed.

The number of elements must be in the range 1-7.

- `MONDAY`: The day-of-week of Monday.
- `TUESDAY`: The day-of-week of Tuesday.
- `WEDNESDAY`: The day-of-week of Wednesday.
- `THURSDAY`: The day-of-week of Thursday.
- `FRIDAY`: The day-of-week of Friday.
- `SATURDAY`: The day-of-week of Saturday.
- `SUNDAY`: The day-of-week of Sunday. ||
|| start_time | **[google.type.TimeOfDay](https://github.com/googleapis/googleapis/blob/master/google/type/timeofday.proto)**

Required field. Window start time, in the UTC timezone. ||
|| duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Window duration. ||
|#

## MasterLogging {#yandex.cloud.k8s.v1.MasterLogging}

#|
||Field | Description ||
|| enabled | **bool**

Identifies whether Cloud Logging is enabled for master components. ||
|| log_group_id | **string**

ID of the log group where logs of master components should be stored.

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `log_group_id`, `folder_id`.

The destination of master components' logs. ||
|| folder_id | **string**

ID of the folder where logs should be stored (in default group).

Value must match the regular expression ` ([a-zA-Z][-a-zA-Z0-9_.]{0,63})? `.

Includes only one of the fields `log_group_id`, `folder_id`.

The destination of master components' logs. ||
|| audit_enabled | **bool**

Identifies whether Cloud Logging is enabled for audit logs. ||
|| cluster_autoscaler_enabled | **bool**

Identifies whether Cloud Logging is enabled for cluster-autoscaler. ||
|| kube_apiserver_enabled | **bool**

Identifies whether Cloud Logging is enabled for kube-apiserver. ||
|| events_enabled | **bool**

Identifies whether Cloud Logging is enabled for events. ||
|#

## LocationSpec {#yandex.cloud.k8s.v1.LocationSpec}

#|
||Field | Description ||
|| zone_id | **string**

Required field. ID of the availability zone where the master resides. ||
|| subnet_id | **string**

ID of the VPC network's subnet where the master resides.
If not specified and there is a single subnet in specified zone, address in this subnet will be allocated. ||
|#

## ExternalAddressSpec {#yandex.cloud.k8s.v1.ExternalAddressSpec}

#|
||Field | Description ||
|| address | **string**

IP address. ||
|#

## MasterScalePolicySpec {#yandex.cloud.k8s.v1.MasterScalePolicySpec}

#|
||Field | Description ||
|| auto_scale | **[AutoScale](#yandex.cloud.k8s.v1.MasterScalePolicySpec.AutoScale)**

Includes only one of the fields `auto_scale`. ||
|#

## AutoScale {#yandex.cloud.k8s.v1.MasterScalePolicySpec.AutoScale}

Scalable master instance resources.

#|
||Field | Description ||
|| min_resource_preset_id | **string**

Required field. Preset of computing resources to be used as lower boundary for scaling. ||
|#

## NetworkPolicy {#yandex.cloud.k8s.v1.NetworkPolicy}

#|
||Field | Description ||
|| provider | enum **Provider**

- `CALICO` ||
|#

## IPAllocationPolicy {#yandex.cloud.k8s.v1.IPAllocationPolicy}

#|
||Field | Description ||
|| cluster_ipv4_cidr_block | **string**

CIDR block. IP range for allocating pod addresses.
It should not overlap with any subnet in the network the Kubernetes cluster located in. Static routes will be
set up for this CIDR blocks in node subnets. ||
|| node_ipv4_cidr_mask_size | **int64**

Size of the masks that are assigned for each node in the cluster.
If not specified, 24 is used. ||
|| service_ipv4_cidr_block | **string**

CIDR block. IP range Kubernetes service Kubernetes cluster IP addresses will be allocated from.
It should not overlap with any subnet in the network the Kubernetes cluster located in. ||
|| cluster_ipv6_cidr_block | **string**

IPv6 range for allocating pod IP addresses. ||
|| service_ipv6_cidr_block | **string**

IPv6 range for allocating Kubernetes service IP addresses ||
|#

## WorkloadIdentityFederationSpec {#yandex.cloud.k8s.v1.WorkloadIdentityFederationSpec}

#|
||Field | Description ||
|| enabled | **bool**

Identifies whether Workload Identity Federation is enabled. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Any"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#