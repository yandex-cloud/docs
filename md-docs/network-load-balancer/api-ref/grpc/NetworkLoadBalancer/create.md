# Network Load Balancer API, gRPC: NetworkLoadBalancerService.Create

Creates a network load balancer in the specified folder using the data specified in the request.

## gRPC request

**rpc Create ([CreateNetworkLoadBalancerRequest](#yandex.cloud.loadbalancer.v1.CreateNetworkLoadBalancerRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateNetworkLoadBalancerRequest {#yandex.cloud.loadbalancer.v1.CreateNetworkLoadBalancerRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "region_id": "string",
  "type": "Type",
  "listener_specs": [
    {
      "name": "string",
      "port": "int64",
      "protocol": "Protocol",
      // Includes only one of the fields `external_address_spec`, `internal_address_spec`
      "external_address_spec": {
        "address": "string",
        "ip_version": "IpVersion"
      },
      "internal_address_spec": {
        "address": "string",
        "subnet_id": "string",
        "ip_version": "IpVersion"
      },
      // end of the list of possible fields
      "target_port": "int64"
    }
  ],
  "attached_target_groups": [
    {
      "target_group_id": "string",
      "health_checks": [
        {
          "name": "string",
          "interval": "google.protobuf.Duration",
          "timeout": "google.protobuf.Duration",
          "unhealthy_threshold": "int64",
          "healthy_threshold": "int64",
          // Includes only one of the fields `tcp_options`, `http_options`
          "tcp_options": {
            "port": "int64"
          },
          "http_options": {
            "port": "int64",
            "path": "string"
          }
          // end of the list of possible fields
        }
      ]
    }
  ],
  "deletion_protection": "bool",
  "allow_zonal_shift": "bool"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to create a network load balancer in.
To get the folder ID, use a [NetworkLoadBalancerService.List](list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| name | **string**

Name of the network load balancer.
The name must be unique within the folder.
The value must match the regular expression: ```|[a-z][-a-z0-9]{1,61}[a-z0-9]```. ||
|| description | **string**

Description of the network load balancer.
The length must be less than or equal to 256. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs.
Each map key must match the regular expression: `[a-z][-_0-9a-z]*`.
Each map value must match the regular expression: `[-_0-9a-z]*`.
The length of each map key must be between 1 and 63.
The length of each map value must be less than or equal to 63.
The number of elements must be less than or equal to 64. ||
|| region_id | **string**

ID of the region where the network load balancer resides.
The length must be less than or equal to 50. ||
|| type | enum **Type**

Type of the network load balancer.
This field is required.

- `EXTERNAL`: External network load balancer.
- `INTERNAL`: Internal network load balancer. ||
|| listener_specs[] | **[ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec)**

List of listeners and their specs for the network load balancer.
The number of elements must be less than or equal to 1000. ||
|| attached_target_groups[] | **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**

List of attached target groups for the network load balancer.
The number of elements must be less than or equal to 1000. ||
|| deletion_protection | **bool**

Specifies if network load balancer protected from deletion. ||
|| allow_zonal_shift | **bool**

Specifies if network load balancer available to zonal shift. ||
|#

## ListenerSpec {#yandex.cloud.loadbalancer.v1.ListenerSpec}

Listener specification that will be used by a network load balancer.

#|
||Field | Description ||
|| name | **string**

Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.
The value must match the regular expression: ```|[a-z][-a-z0-9]{1,61}[a-z0-9]```.
This field is required. ||
|| port | **int64**

Port for incoming traffic.
The value must be between 1 and 65535. ||
|| protocol | enum **Protocol**

Protocol for incoming traffic.
This field is required.

- `TCP`
- `UDP` ||
|| external_address_spec | **[ExternalAddressSpec](#yandex.cloud.loadbalancer.v1.ExternalAddressSpec)**

External IP address specification.

Includes only one of the fields `external_address_spec`, `internal_address_spec`.

IP address for incoming traffic. Either the ID of the previously created address or the address specification. ||
|| internal_address_spec | **[InternalAddressSpec](#yandex.cloud.loadbalancer.v1.InternalAddressSpec)**

Internal IP address specification.

Includes only one of the fields `external_address_spec`, `internal_address_spec`.

IP address for incoming traffic. Either the ID of the previously created address or the address specification. ||
|| target_port | **int64**

Port of a target.
Acceptable values are 1 to 65535, inclusive. ||
|#

## ExternalAddressSpec {#yandex.cloud.loadbalancer.v1.ExternalAddressSpec}

External address specification that is used by [ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec).

#|
||Field | Description ||
|| address | **string**

Public IP address for a listener.
If you provide a static public IP address for the [NetworkLoadBalancerService.Update](update.md#Update)
method, it will replace the existing listener address. ||
|| ip_version | enum **IpVersion**

IP version.

- `IPV4`: IPv4
- `IPV6`: IPv6 ||
|#

## InternalAddressSpec {#yandex.cloud.loadbalancer.v1.InternalAddressSpec}

Internal address specification that is used by [ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec).

#|
||Field | Description ||
|| address | **string**

Internal IP address for a listener. ||
|| subnet_id | **string**

ID of the subnet. ||
|| ip_version | enum **IpVersion**

IP version.

- `IPV4`: IPv4
- `IPV6`: IPv6 ||
|#

## AttachedTargetGroup {#yandex.cloud.loadbalancer.v1.AttachedTargetGroup}

An AttachedTargetGroup resource. For more information, see [Targets and groups](../../../concepts/target-resources.md).

#|
||Field | Description ||
|| target_group_id | **string**

ID of the target group.
The length must be less than or equal to 50.
This field is required. ||
|| health_checks[] | **[HealthCheck](#yandex.cloud.loadbalancer.v1.HealthCheck)**

A health check to perform on the target group.
For now we accept only one health check per AttachedTargetGroup.
The number of elements must be exactly 1. ||
|#

## HealthCheck {#yandex.cloud.loadbalancer.v1.HealthCheck}

A HealthCheck resource. For more information, see [Health check](../../../concepts/health-check.md).

#|
||Field | Description ||
|| name | **string**

Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.
The value must match the regular expression: ```|[a-z][-a-z0-9]{1,61}[a-z0-9]```.
This field is required. ||
|| interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The interval between health checks. The default is 2 seconds. ||
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for a target to return a response for the health check. The default is 1 second. ||
|| unhealthy_threshold | **int64**

Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2.
The value must be between 2 and 10. ||
|| healthy_threshold | **int64**

Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2.
The value must be between 2 and 10. ||
|| tcp_options | **[TcpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions)**

Options for TCP health check.

Includes only one of the fields `tcp_options`, `http_options`.

Protocol to use for the health check. Either TCP or HTTP.
Only one field must be specified. ||
|| http_options | **[HttpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions)**

Options for HTTP health check.

Includes only one of the fields `tcp_options`, `http_options`.

Protocol to use for the health check. Either TCP or HTTP.
Only one field must be specified. ||
|#

## TcpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions}

Configuration option for a TCP health check.

#|
||Field | Description ||
|| port | **int64**

Port to use for TCP health checks.
The value must be between 1 and 65535. ||
|#

## HttpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions}

Configuration option for an HTTP health check.

#|
||Field | Description ||
|| port | **int64**

Port to use for HTTP health checks.
The value must be between 1 and 65535. ||
|| path | **string**

URL path to set for health checking requests for every target in the target group.
For example `` /ping ``. The default path is `` / ``. ||
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

An Operation resource. For more information, see [Operation](../../../../api-design-guide/concepts/operation.md).

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