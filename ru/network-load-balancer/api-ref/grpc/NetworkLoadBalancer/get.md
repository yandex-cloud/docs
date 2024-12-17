---
editable: false
sourcePath: en/_api-ref-grpc/loadbalancer/v1/api-ref/grpc/NetworkLoadBalancer/get.md
---

# Network Load Balancer API, gRPC: NetworkLoadBalancerService.Get

Returns the specified NetworkLoadBalancer resource.

Get the list of available NetworkLoadBalancer resources by making a [List](/docs/network-load-balancer/api-ref/grpc/NetworkLoadBalancer/list#List) request.

## gRPC request

**rpc Get ([GetNetworkLoadBalancerRequest](#yandex.cloud.loadbalancer.v1.GetNetworkLoadBalancerRequest)) returns ([NetworkLoadBalancer](#yandex.cloud.loadbalancer.v1.NetworkLoadBalancer))**

## GetNetworkLoadBalancerRequest {#yandex.cloud.loadbalancer.v1.GetNetworkLoadBalancerRequest}

```json
{
  "network_load_balancer_id": "string"
}
```

#|
||Field | Description ||
|| network_load_balancer_id | **string**

ID of the NetworkLoadBalancer resource to return.
To get the network load balancer ID, use a [NetworkLoadBalancerService.List](/docs/network-load-balancer/api-ref/grpc/NetworkLoadBalancer/list#List) request. ||
|#

## NetworkLoadBalancer {#yandex.cloud.loadbalancer.v1.NetworkLoadBalancer}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "region_id": "string",
  "status": "Status",
  "type": "Type",
  "session_affinity": "SessionAffinity",
  "listeners": [
    {
      "name": "string",
      "address": "string",
      "port": "int64",
      "protocol": "Protocol",
      "target_port": "int64",
      "subnet_id": "string",
      "ip_version": "IpVersion"
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
  "deletion_protection": "bool"
}
```

A NetworkLoadBalancer resource. For more information, see [Network Load Balancer](/docs/network-load-balancer/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the network load balancer. ||
|| folder_id | **string**

ID of the folder that the network load balancer belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the network load balancer. The name is unique within the folder. 3-63 characters long. ||
|| description | **string**

Optional description of the network load balancer. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| region_id | **string**

ID of the region that the network load balancer belongs to. ||
|| status | enum **Status**

Status of the network load balancer.

- `STATUS_UNSPECIFIED`
- `CREATING`: Network load balancer is being created.
- `STARTING`: Network load balancer is being started.
- `ACTIVE`: Network load balancer is active and sends traffic to the targets.
- `STOPPING`: Network load balancer is being stopped.
- `STOPPED`: Network load balancer is stopped and doesn't send traffic to the targets.
- `DELETING`: Network load balancer is being deleted.
- `INACTIVE`: The load balancer doesn't have any listeners or target groups, or
attached target groups are empty. The load balancer doesn't perform any health checks or
send traffic in this state. ||
|| type | enum **Type**

Type of the network load balancer. Only external network load balancers are available now.

- `TYPE_UNSPECIFIED`
- `EXTERNAL`: External network load balancer.
- `INTERNAL`: Internal network load balancer. ||
|| session_affinity | enum **SessionAffinity**

Type of the session affinity. Only 5-tuple affinity is available now.

- `SESSION_AFFINITY_UNSPECIFIED`
- `CLIENT_IP_PORT_PROTO`: 5-tuple affinity. ||
|| listeners[] | **[Listener](#yandex.cloud.loadbalancer.v1.Listener)**

List of listeners for the network load balancer. ||
|| attached_target_groups[] | **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**

List of target groups attached to the network load balancer. ||
|| deletion_protection | **bool**

Specifies if network load balancer protected from deletion. ||
|#

## Listener {#yandex.cloud.loadbalancer.v1.Listener}

A Listener resource. For more information, see [Listener](/docs/network-load-balancer/concepts/listener)

#|
||Field | Description ||
|| name | **string**

Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. ||
|| address | **string**

IP address for the listener. ||
|| port | **int64**

Port. ||
|| protocol | enum **Protocol**

Network protocol for incoming traffic.

- `PROTOCOL_UNSPECIFIED`
- `TCP`
- `UDP` ||
|| target_port | **int64**

Port of a target. ||
|| subnet_id | **string**

ID of the subnet. ||
|| ip_version | enum **IpVersion**

IP version of the external address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4
- `IPV6`: IPv6 ||
|#

## AttachedTargetGroup {#yandex.cloud.loadbalancer.v1.AttachedTargetGroup}

An AttachedTargetGroup resource. For more information, see [Targets and groups](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| target_group_id | **string**

Required field. ID of the target group. ||
|| health_checks[] | **[HealthCheck](#yandex.cloud.loadbalancer.v1.HealthCheck)**

A health check to perform on the target group.
For now we accept only one health check per AttachedTargetGroup. ||
|#

## HealthCheck {#yandex.cloud.loadbalancer.v1.HealthCheck}

A HealthCheck resource. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. ||
|| interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

The interval between health checks. The default is 2 seconds. ||
|| timeout | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Timeout for a target to return a response for the health check. The default is 1 second. ||
|| unhealthy_threshold | **int64**

Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. ||
|| healthy_threshold | **int64**

Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. ||
|| tcp_options | **[TcpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions)**

Options for TCP health check.

Includes only one of the fields `tcp_options`, `http_options`.

Protocol to use for the health check. Either TCP or HTTP. ||
|| http_options | **[HttpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions)**

Options for HTTP health check.

Includes only one of the fields `tcp_options`, `http_options`.

Protocol to use for the health check. Either TCP or HTTP. ||
|#

## TcpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions}

Configuration option for a TCP health check.

#|
||Field | Description ||
|| port | **int64**

Port to use for TCP health checks. ||
|#

## HttpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions}

Configuration option for an HTTP health check.

#|
||Field | Description ||
|| port | **int64**

Port to use for HTTP health checks. ||
|| path | **string**

URL path to set for health checking requests for every target in the target group.
For example `` /ping ``. The default path is `` / ``. ||
|#