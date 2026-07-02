[Документация Yandex Cloud](../../../../index.md) > [Yandex Network Load Balancer](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [NetworkLoadBalancer](index.md) > AttachTargetGroup

# Network Load Balancer API, gRPC: NetworkLoadBalancerService.AttachTargetGroup

Attaches a target group to the specified network load balancer.

## gRPC request

**rpc AttachTargetGroup ([AttachNetworkLoadBalancerTargetGroupRequest](#yandex.cloud.loadbalancer.v1.AttachNetworkLoadBalancerTargetGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AttachNetworkLoadBalancerTargetGroupRequest {#yandex.cloud.loadbalancer.v1.AttachNetworkLoadBalancerTargetGroupRequest}

```json
{
  "network_load_balancer_id": "string",
  "attached_target_group": {
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
}
```

#|
||Field | Description ||
|| network_load_balancer_id | **string**

ID of the network load balancer to attach the target group to.
To get the network load balancer ID, use a [NetworkLoadBalancerService.List](list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| attached_target_group | **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**

ID of the attached target group to attach to the network load balancer.
To get the network load balancer ID, use a [NetworkLoadBalancerService.List](list.md#List) request.
This field is required. ||
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