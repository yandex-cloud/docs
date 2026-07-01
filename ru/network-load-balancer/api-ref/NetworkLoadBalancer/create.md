---
editable: false
apiPlayground:
  - url: https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to create a network load balancer in.
            To get the folder ID, use a [NetworkLoadBalancerService.List](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#List) request.
            The length must be less than or equal to 50.
            This field is required.
          type: string
        name:
          description: |-
            **string**
            Name of the network load balancer.
            The name must be unique within the folder.
            The value must match the regular expression: `|[a-z][-a-z0-9]{1,61}[a-z0-9]`.
          type: string
        description:
          description: |-
            **string**
            Description of the network load balancer.
            The length must be less than or equal to 256.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `` key:value `` pairs.
            Each map key must match the regular expression: `[a-z][-_0-9a-z]*`.
            Each map value must match the regular expression: `[-_0-9a-z]*`.
            The length of each map key must be between 1 and 63.
            The length of each map value must be less than or equal to 63.
            The number of elements must be less than or equal to 64.
          type: object
          additionalProperties:
            type: string
        regionId:
          description: |-
            **string**
            ID of the region where the network load balancer resides.
            The length must be less than or equal to 50.
          type: string
        type:
          description: |-
            **enum** (Type)
            Type of the network load balancer.
            This field is required.
            - `EXTERNAL`: External network load balancer.
            - `INTERNAL`: Internal network load balancer.
          type: string
          enum:
            - TYPE_UNSPECIFIED
            - EXTERNAL
            - INTERNAL
        listenerSpecs:
          description: |-
            **[ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec)**
            List of listeners and their specs for the network load balancer.
            The number of elements must be less than or equal to 1000.
          type: array
          items:
            $ref: '#/definitions/ListenerSpec'
        attachedTargetGroups:
          description: |-
            **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**
            List of attached target groups for the network load balancer.
            The number of elements must be less than or equal to 1000.
          type: array
          items:
            $ref: '#/definitions/AttachedTargetGroup'
        deletionProtection:
          description: |-
            **boolean**
            Specifies if network load balancer protected from deletion.
          type: boolean
        allowZonalShift:
          description: |-
            **boolean**
            Specifies if network load balancer available to zonal shift.
          type: boolean
      additionalProperties: false
    definitions:
      ExternalAddressSpec:
        type: object
        properties:
          address:
            description: |-
              **string**
              Public IP address for a listener.
              If you provide a static public IP address for the [NetworkLoadBalancerService.Update](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/update#Update)
              method, it will replace the existing listener address.
            type: string
          ipVersion:
            description: |-
              **enum** (IpVersion)
              IP version.
              - `IPV4`: IPv4
              - `IPV6`: IPv6
            type: string
            enum:
              - IP_VERSION_UNSPECIFIED
              - IPV4
              - IPV6
      InternalAddressSpec:
        type: object
        properties:
          address:
            description: |-
              **string**
              Internal IP address for a listener.
            type: string
          subnetId:
            description: |-
              **string**
              ID of the subnet.
            type: string
          ipVersion:
            description: |-
              **enum** (IpVersion)
              IP version.
              - `IPV4`: IPv4
              - `IPV6`: IPv6
            type: string
            enum:
              - IP_VERSION_UNSPECIFIED
              - IPV4
              - IPV6
      ListenerSpec:
        type: object
        properties:
          name:
            description: |-
              **string**
              Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.
              The value must match the regular expression: `|[a-z][-a-z0-9]{1,61}[a-z0-9]`.
              This field is required.
            type: string
          port:
            description: |-
              **string** (int64)
              Port for incoming traffic.
              The value must be between 1 and 65535.
            type: string
            format: int64
          protocol:
            description: |-
              **enum** (Protocol)
              Protocol for incoming traffic.
              This field is required.
              - `TCP`
              - `UDP`
            type: string
            enum:
              - PROTOCOL_UNSPECIFIED
              - TCP
              - UDP
          externalAddressSpec:
            description: |-
              **[ExternalAddressSpec](#yandex.cloud.loadbalancer.v1.ExternalAddressSpec)**
              External IP address specification.
              Includes only one of the fields `externalAddressSpec`, `internalAddressSpec`.
              IP address for incoming traffic. Either the ID of the previously created address or the address specification.
            $ref: '#/definitions/ExternalAddressSpec'
          internalAddressSpec:
            description: |-
              **[InternalAddressSpec](#yandex.cloud.loadbalancer.v1.InternalAddressSpec)**
              Internal IP address specification.
              Includes only one of the fields `externalAddressSpec`, `internalAddressSpec`.
              IP address for incoming traffic. Either the ID of the previously created address or the address specification.
            $ref: '#/definitions/InternalAddressSpec'
          targetPort:
            description: |-
              **string** (int64)
              Port of a target.
              Acceptable values are 1 to 65535, inclusive.
            type: string
            format: int64
        oneOf:
          - required:
              - externalAddressSpec
          - required:
              - internalAddressSpec
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

# Network Load Balancer API, REST: NetworkLoadBalancer.Create

Creates a network load balancer in the specified folder using the data specified in the request.

## HTTP request

```
POST https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers
```

## Body parameters {#yandex.cloud.loadbalancer.v1.CreateNetworkLoadBalancerRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "regionId": "string",
  "type": "string",
  "listenerSpecs": [
    {
      "name": "string",
      "port": "string",
      "protocol": "string",
      // Includes only one of the fields `externalAddressSpec`, `internalAddressSpec`
      "externalAddressSpec": {
        "address": "string",
        "ipVersion": "string"
      },
      "internalAddressSpec": {
        "address": "string",
        "subnetId": "string",
        "ipVersion": "string"
      },
      // end of the list of possible fields
      "targetPort": "string"
    }
  ],
  "attachedTargetGroups": [
    {
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
  ],
  "deletionProtection": "boolean",
  "allowZonalShift": "boolean"
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create a network load balancer in.
To get the folder ID, use a [NetworkLoadBalancerService.List](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#List) request.
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
|| regionId | **string**

ID of the region where the network load balancer resides.
The length must be less than or equal to 50. ||
|| type | **enum** (Type)

Type of the network load balancer.
This field is required.

- `EXTERNAL`: External network load balancer.
- `INTERNAL`: Internal network load balancer. ||
|| listenerSpecs[] | **[ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec)**

List of listeners and their specs for the network load balancer.
The number of elements must be less than or equal to 1000. ||
|| attachedTargetGroups[] | **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**

List of attached target groups for the network load balancer.
The number of elements must be less than or equal to 1000. ||
|| deletionProtection | **boolean**

Specifies if network load balancer protected from deletion. ||
|| allowZonalShift | **boolean**

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
|| port | **string** (int64)

Port for incoming traffic.
The value must be between 1 and 65535. ||
|| protocol | **enum** (Protocol)

Protocol for incoming traffic.
This field is required.

- `TCP`
- `UDP` ||
|| externalAddressSpec | **[ExternalAddressSpec](#yandex.cloud.loadbalancer.v1.ExternalAddressSpec)**

External IP address specification.

Includes only one of the fields `externalAddressSpec`, `internalAddressSpec`.

IP address for incoming traffic. Either the ID of the previously created address or the address specification. ||
|| internalAddressSpec | **[InternalAddressSpec](#yandex.cloud.loadbalancer.v1.InternalAddressSpec)**

Internal IP address specification.

Includes only one of the fields `externalAddressSpec`, `internalAddressSpec`.

IP address for incoming traffic. Either the ID of the previously created address or the address specification. ||
|| targetPort | **string** (int64)

Port of a target.
Acceptable values are 1 to 65535, inclusive. ||
|#

## ExternalAddressSpec {#yandex.cloud.loadbalancer.v1.ExternalAddressSpec}

External address specification that is used by [ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec).

#|
||Field | Description ||
|| address | **string**

Public IP address for a listener.
If you provide a static public IP address for the [NetworkLoadBalancerService.Update](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/update#Update)
method, it will replace the existing listener address. ||
|| ipVersion | **enum** (IpVersion)

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
|| subnetId | **string**

ID of the subnet. ||
|| ipVersion | **enum** (IpVersion)

IP version.

- `IPV4`: IPv4
- `IPV6`: IPv6 ||
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