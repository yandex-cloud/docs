---
editable: false
apiPlayground:
  - url: https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}
    method: patch
    path:
      type: object
      properties:
        networkLoadBalancerId:
          description: |-
            **string**
            Required field. ID of the network load balancer to update.
            To get the network load balancer ID, use a [NetworkLoadBalancerService.List](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#List) request.
          type: string
      required:
        - networkLoadBalancerId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        name:
          description: |-
            **string**
            Name of the network load balancer.
            The name must be unique within the folder.
          pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
          type: string
        description:
          description: |-
            **string**
            Description of the network load balancer.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `` key:value `` pairs.
            The existing set of `` labels `` is completely replaced with the provided set.
          type: object
          additionalProperties:
            type: string
            pattern: '[-_0-9a-z]*'
            maxLength: 63
          propertyNames:
            type: string
            pattern: '[a-z][-_0-9a-z]*'
            maxLength: 63
            minLength: 1
          maxProperties: 64
        listenerSpecs:
          description: |-
            **[ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec)**
            A list of listeners and their specs for the network load balancer.
          type: array
          items:
            $ref: '#/definitions/ListenerSpec'
        attachedTargetGroups:
          description: |-
            **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**
            A list of attached target groups for the network load balancer.
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
              If you provide a static public IP address for the [NetworkLoadBalancerService.Update](#Update)
              method, it will replace the existing listener address.
            type: string
          ipVersion:
            description: |-
              **enum** (IpVersion)
              IP version.
              - `IP_VERSION_UNSPECIFIED`
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
              - `IP_VERSION_UNSPECIFIED`
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
              Required field. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long.
            pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
            type: string
          port:
            description: |-
              **string** (int64)
              Port for incoming traffic.
            type: string
            format: int64
          protocol:
            description: |-
              **enum** (Protocol)
              Required field. Protocol for incoming traffic.
              - `PROTOCOL_UNSPECIFIED`
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
        required:
          - name
          - protocol
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
            type: string
            format: int64
      HttpOptions:
        type: object
        properties:
          port:
            description: |-
              **string** (int64)
              Port to use for HTTP health checks.
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
              Required field. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long.
            pattern: '|[a-z][-a-z0-9]{1,61}[a-z0-9]'
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
            type: string
            format: int64
          healthyThreshold:
            description: |-
              **string** (int64)
              Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2.
            type: string
            format: int64
          tcpOptions:
            description: |-
              **[TcpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions)**
              Options for TCP health check.
              Includes only one of the fields `tcpOptions`, `httpOptions`.
              Protocol to use for the health check. Either TCP or HTTP.
            $ref: '#/definitions/TcpOptions'
          httpOptions:
            description: |-
              **[HttpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions)**
              Options for HTTP health check.
              Includes only one of the fields `tcpOptions`, `httpOptions`.
              Protocol to use for the health check. Either TCP or HTTP.
            $ref: '#/definitions/HttpOptions'
        required:
          - name
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
              Required field. ID of the target group.
            type: string
          healthChecks:
            description: |-
              **[HealthCheck](#yandex.cloud.loadbalancer.v1.HealthCheck)**
              A health check to perform on the target group.
              For now we accept only one health check per AttachedTargetGroup.
            type: array
            items:
              $ref: '#/definitions/HealthCheck'
        required:
          - targetGroupId
sourcePath: en/_api-ref/loadbalancer/v1/api-ref/NetworkLoadBalancer/update.md
---

# Network Load Balancer API, REST: NetworkLoadBalancer.Update

Updates the specified network load balancer.

## HTTP request

```
PATCH https://load-balancer.{{ api-host }}/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}
```

## Path parameters

#|
||Field | Description ||
|| networkLoadBalancerId | **string**

Required field. ID of the network load balancer to update.
To get the network load balancer ID, use a [NetworkLoadBalancerService.List](/docs/network-load-balancer/api-ref/NetworkLoadBalancer/list#List) request. ||
|#

## Body parameters {#yandex.cloud.loadbalancer.v1.UpdateNetworkLoadBalancerRequest}

```json
{
  "updateMask": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| name | **string**

Name of the network load balancer.
The name must be unique within the folder. ||
|| description | **string**

Description of the network load balancer. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs.

The existing set of `` labels `` is completely replaced with the provided set. ||
|| listenerSpecs[] | **[ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec)**

A list of listeners and their specs for the network load balancer. ||
|| attachedTargetGroups[] | **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup)**

A list of attached target groups for the network load balancer. ||
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

Required field. Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. ||
|| port | **string** (int64)

Port for incoming traffic. ||
|| protocol | **enum** (Protocol)

Required field. Protocol for incoming traffic.

- `PROTOCOL_UNSPECIFIED`
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
If you provide a static public IP address for the [NetworkLoadBalancerService.Update](#Update)
method, it will replace the existing listener address. ||
|| ipVersion | **enum** (IpVersion)

IP version.

- `IP_VERSION_UNSPECIFIED`
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

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4
- `IPV6`: IPv6 ||
|#

## AttachedTargetGroup {#yandex.cloud.loadbalancer.v1.AttachedTargetGroup}

An AttachedTargetGroup resource. For more information, see [Targets and groups](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| targetGroupId | **string**

Required field. ID of the target group. ||
|| healthChecks[] | **[HealthCheck](#yandex.cloud.loadbalancer.v1.HealthCheck)**

A health check to perform on the target group.
For now we accept only one health check per AttachedTargetGroup. ||
|#

## HealthCheck {#yandex.cloud.loadbalancer.v1.HealthCheck}

A HealthCheck resource. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. ||
|| interval | **string** (duration)

The interval between health checks. The default is 2 seconds. ||
|| timeout | **string** (duration)

Timeout for a target to return a response for the health check. The default is 1 second. ||
|| unhealthyThreshold | **string** (int64)

Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. ||
|| healthyThreshold | **string** (int64)

Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. ||
|| tcpOptions | **[TcpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions)**

Options for TCP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`.

Protocol to use for the health check. Either TCP or HTTP. ||
|| httpOptions | **[HttpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions)**

Options for HTTP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`.

Protocol to use for the health check. Either TCP or HTTP. ||
|#

## TcpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions}

Configuration option for a TCP health check.

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for TCP health checks. ||
|#

## HttpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions}

Configuration option for an HTTP health check.

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for HTTP health checks. ||
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
  "metadata": {
    "networkLoadBalancerId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    "regionId": "string",
    "status": "string",
    "type": "string",
    "sessionAffinity": "string",
    "listeners": [
      {
        "name": "string",
        "address": "string",
        "port": "string",
        "protocol": "string",
        "targetPort": "string",
        "subnetId": "string",
        "ipVersion": "string"
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
    "allowZonalShift": "boolean",
    "disableZoneStatuses": [
      {
        "zoneId": "string",
        "disabledUntil": "string"
      }
    ]
  }
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
|| metadata | **[UpdateNetworkLoadBalancerMetadata](#yandex.cloud.loadbalancer.v1.UpdateNetworkLoadBalancerMetadata)**

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
|| response | **[NetworkLoadBalancer](#yandex.cloud.loadbalancer.v1.NetworkLoadBalancer)**

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

## UpdateNetworkLoadBalancerMetadata {#yandex.cloud.loadbalancer.v1.UpdateNetworkLoadBalancerMetadata}

#|
||Field | Description ||
|| networkLoadBalancerId | **string**

ID of the NetworkLoadBalancer resource that is being updated. ||
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

## NetworkLoadBalancer {#yandex.cloud.loadbalancer.v1.NetworkLoadBalancer}

A NetworkLoadBalancer resource. For more information, see [Network Load Balancer](/docs/network-load-balancer/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the network load balancer. ||
|| folderId | **string**

ID of the folder that the network load balancer belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the network load balancer. The name is unique within the folder. 3-63 characters long. ||
|| description | **string**

Optional description of the network load balancer. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|| regionId | **string**

ID of the region that the network load balancer belongs to. ||
|| status | **enum** (Status)

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
|| type | **enum** (Type)

Type of the network load balancer. Only external network load balancers are available now.

- `TYPE_UNSPECIFIED`
- `EXTERNAL`: External network load balancer.
- `INTERNAL`: Internal network load balancer. ||
|| sessionAffinity | **enum** (SessionAffinity)

Type of the session affinity. Only 5-tuple affinity is available now.

- `SESSION_AFFINITY_UNSPECIFIED`
- `CLIENT_IP_PORT_PROTO`: 5-tuple affinity. ||
|| listeners[] | **[Listener](#yandex.cloud.loadbalancer.v1.Listener)**

List of listeners for the network load balancer. ||
|| attachedTargetGroups[] | **[AttachedTargetGroup](#yandex.cloud.loadbalancer.v1.AttachedTargetGroup2)**

List of target groups attached to the network load balancer. ||
|| deletionProtection | **boolean**

Specifies if network load balancer protected from deletion. ||
|| allowZonalShift | **boolean**

Specifies if network load balancer available to zonal shift. ||
|| disableZoneStatuses[] | **[DisableZoneStatus](#yandex.cloud.loadbalancer.v1.DisableZoneStatus)**

List of disabled zones for the network load balancer. ||
|#

## Listener {#yandex.cloud.loadbalancer.v1.Listener}

A Listener resource. For more information, see [Listener](/docs/network-load-balancer/concepts/listener)

#|
||Field | Description ||
|| name | **string**

Name of the listener. The name must be unique for each listener on a single load balancer. 3-63 characters long. ||
|| address | **string**

IP address for the listener. ||
|| port | **string** (int64)

Port. ||
|| protocol | **enum** (Protocol)

Network protocol for incoming traffic.

- `PROTOCOL_UNSPECIFIED`
- `TCP`
- `UDP` ||
|| targetPort | **string** (int64)

Port of a target. ||
|| subnetId | **string**

ID of the subnet. ||
|| ipVersion | **enum** (IpVersion)

IP version of the external address.

- `IP_VERSION_UNSPECIFIED`
- `IPV4`: IPv4
- `IPV6`: IPv6 ||
|#

## AttachedTargetGroup {#yandex.cloud.loadbalancer.v1.AttachedTargetGroup2}

An AttachedTargetGroup resource. For more information, see [Targets and groups](/docs/network-load-balancer/concepts/target-resources).

#|
||Field | Description ||
|| targetGroupId | **string**

Required field. ID of the target group. ||
|| healthChecks[] | **[HealthCheck](#yandex.cloud.loadbalancer.v1.HealthCheck2)**

A health check to perform on the target group.
For now we accept only one health check per AttachedTargetGroup. ||
|#

## HealthCheck {#yandex.cloud.loadbalancer.v1.HealthCheck2}

A HealthCheck resource. For more information, see [Health check](/docs/network-load-balancer/concepts/health-check).

#|
||Field | Description ||
|| name | **string**

Required field. Name of the health check. The name must be unique for each target group that attached to a single load balancer. 3-63 characters long. ||
|| interval | **string** (duration)

The interval between health checks. The default is 2 seconds. ||
|| timeout | **string** (duration)

Timeout for a target to return a response for the health check. The default is 1 second. ||
|| unhealthyThreshold | **string** (int64)

Number of failed health checks before changing the status to `` UNHEALTHY ``. The default is 2. ||
|| healthyThreshold | **string** (int64)

Number of successful health checks required in order to set the `` HEALTHY `` status for the target. The default is 2. ||
|| tcpOptions | **[TcpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions2)**

Options for TCP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`.

Protocol to use for the health check. Either TCP or HTTP. ||
|| httpOptions | **[HttpOptions](#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions2)**

Options for HTTP health check.

Includes only one of the fields `tcpOptions`, `httpOptions`.

Protocol to use for the health check. Either TCP or HTTP. ||
|#

## TcpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.TcpOptions2}

Configuration option for a TCP health check.

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for TCP health checks. ||
|#

## HttpOptions {#yandex.cloud.loadbalancer.v1.HealthCheck.HttpOptions2}

Configuration option for an HTTP health check.

#|
||Field | Description ||
|| port | **string** (int64)

Port to use for HTTP health checks. ||
|| path | **string**

URL path to set for health checking requests for every target in the target group.
For example `` /ping ``. The default path is `` / ``. ||
|#

## DisableZoneStatus {#yandex.cloud.loadbalancer.v1.DisableZoneStatus}

Status of the disabled zone.

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of zone. ||
|| disabledUntil | **string** (date-time)

Timestamp until which the zone will be disabled.
If not present then zone will be disabled until it is removed through a separate call.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#