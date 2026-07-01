---
editable: false
apiPlayground:
  - url: https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:attachTargetGroup
    method: post
    path:
      type: object
      properties:
        networkLoadBalancerId:
          description: |-
            **string**
            ID of the network load balancer to attach the target group to.
            To get the network load balancer ID, use a [NetworkLoadBalancerService.List](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#List) request.
            The length must be less than or equal to 50.
            This field is required.
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        attachedTargetGroup:
          description: |-
            **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**
            ID of the attached target group to attach to the network load balancer.
            To get the network load balancer ID, use a [NetworkLoadBalancerService.List](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#List) request.
            This field is required.
          $ref: '#/definitions/AttachedTargetGroup'
      additionalProperties: false
    definitions:
      TcpOptions:
        type: object
        properties:
          port:
            description: |-
              **string** (int64)
              Port to use for TCP health checks.
              The value must be between 1 and 65535.
            type: string
            format: int64
      HttpOptions:
        type: object
        properties:
          port:
            description: |-
              **string** (int64)
              Port to use for HTTP health checks.
              The value must be between 1 and 65535.
            type: string
            format: int64
          path:
            description: |-
              **string**
              URL path to set for health checking requests for every target in the target group.
              For example `` /ping ``. The default path is `` / ``.
            type: string
      HealthCheck:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.
              The value must match the regular expression: `|[a-z][-a-z0-9]{1,61}[a-z0-9]`.
              This field is required.
            type: string
          interval:
            description: |-
              **string** (duration)
              The interval between health checks. The default is 2 seconds.
            type: string
            format: duration
          timeout:
            description: |-
              **string** (duration)
              Timeout for a target to return a response for the health check. The default is 1 second.
            type: string
            format: duration
          unhealthyThreshold:
            description: |-
              **string** (int64)
              Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2.
              The value must be between 2 and 10.
            type: string
            format: int64
          healthyThreshold:
            description: |-
              **string** (int64)
              Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2.
              The value must be between 2 and 10.
            type: string
            format: int64
          tcpOptions:
            description: |-
              **[TcpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions)**
              Options for TCP health check.
              Includes only one of the fields `tcpOptions`, `httpOptions`.
              Protocol to use for the health check. Either TCP or HTTP.
              Only one field must be specified.
            $ref: '#/definitions/TcpOptions'
          httpOptions:
            description: |-
              **[HttpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions)**
              Options for HTTP health check.
              Includes only one of the fields `tcpOptions`, `httpOptions`.
              Protocol to use for the health check. Either TCP or HTTP.
              Only one field must be specified.
            $ref: '#/definitions/HttpOptions'
        oneOf:
          - required:
              - tcpOptions
          - required:
              - httpOptions
      AttachedTargetGroup:
        type: object
        properties:
          targetGroupId:
            description: |-
              **string**
              ID of the target group.
              The length must be less than or equal to 50.
              This field is required.
            type: string
          healthChecks:
            description: |-
              **[HealthCheck](#yandex.cloud.loadbalancer.v1.HealthCheck)**
              A health check to perform on the target group.
              For now we accept only one health check per AttachedTargetGroup.
              The number of elements must be exactly 1.
            type: array
            items:
              $ref: '#/definitions/HealthCheck'
---

# Network Load Balancer API, REST: NetworkLoadBalancer.AttachTargetGroup

Attaches a target group to the specified network load balancer.

## HTTP request

```
POST https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:attachTargetGroup
```

## Path parameters

#|
||Field | Description ||
|| networkLoadBalancerId | **string**

Required field. ID of the network load balancer to attach the target group to.
To get the network load balancer ID, use a [NetworkLoadBalancerService.List](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#List) request.
The length must be less than or equal to 50.
This field is required. ||
|#

## Body parameters {#yandex.cloud.loadbalancer.v1.AttachNetworkLoadBalancerTargetGroupRequest}

```json
{
  "attachedTargetGroup": {
    "targetGroupId": "string",
    "healthChecks": [
      {
        "name": "string",
        "interval": "string",
        "timeout": "string",
        "unhealthyThreshold": "string",
        "healthyThreshold": "string",
        // Includes only one of the fields `tcpOptions`, `httpOptions`
        "tcpOptions": {
          "port": "string"
        },
        "httpOptions": {
          "port": "string",
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
|| attachedTargetGroup | **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**

ID of the attached target group to attach to the network load balancer.
To get the network load balancer ID, use a [NetworkLoadBalancerService.List](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#List) request.
This field is required. ||
|#

## AttachedTargetGroup {#yandex.cloud.loadbalancer.v1.AttachedTargetGroup}

An AttachedTargetGroup resource. For more information, see [Targets and groups](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| targetGroupId | **string**

ID of the target group.
The length must be less than or equal to 50.
This field is required. ||
|| healthChecks[] | **[HealthCheck](#yandex.cloud.loadbalancer.v1.HealthCheck)**

A health check to perform on the target group.
For now we accept only one health check per AttachedTargetGroup.
The number of elements must be exactly 1. ||
|#

## HealthCheck {#yandex.cloud.loadbalancer.v1.HealthCheck}

A HealthCheck resource. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check).

#|
||Field | Description ||
|| name | **string**

Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.
The value must match the regular expression: ```|[a-z][-a-z0-9]{1,61}[a-z0-9]```.
This field is required. ||
|| interval | **string** (duration)

The interval between health checks. The default is 2 seconds. ||
|| timeout | **string** (duration)

Timeout for a target to return a response for the health check. The default is 1 second. ||
|| unhealthyThreshold | **string** (int64)

Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2.
The value must be between 2 and 10. ||
|| healthyThreshold | **string** (int64)

Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2.
The value must be between 2 and 10. ||
|| tcpOptions | **[TcpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions)**

Options for TCP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`.

Protocol to use for the health check. Either TCP or HTTP.
Only one field must be specified. ||
|| httpOptions | **[HttpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions)**

Options for HTTP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`.

Protocol to use for the health check. Either TCP or HTTP.
Only one field must be specified. ||
|#

## TcpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions}

Configuration option for a TCP health check.

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for TCP health checks.
The value must be between 1 and 65535. ||
|#

## HttpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions}

Configuration option for an HTTP health check.

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for HTTP health checks.
The value must be between 1 and 65535. ||
|| path | **string**

URL path to set for health checking requests for every target in the target group.
For example `` /ping ``. The default path is `` / ``. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **object**

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

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#