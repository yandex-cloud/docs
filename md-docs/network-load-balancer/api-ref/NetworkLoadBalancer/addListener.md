[Документация Yandex Cloud](../../../index.md) > [Yandex Network Load Balancer](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [NetworkLoadBalancer](index.md) > AddListener

# Network Load Balancer API, REST: NetworkLoadBalancer.AddListener

Adds a listener to the specified network load balancer.

## HTTP request

```
POST https://load-balancer.api.cloud.yandex.net/load-balancer/v1/networkLoadBalancers/{networkLoadBalancerId}:addListener
```

## Path parameters

#|
||Field | Description ||
|| networkLoadBalancerId | **string**

Required field. ID of the network load balancer to add a listener to.
To get the network load balancer ID, use a [NetworkLoadBalancerService.List](list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|#

## Body parameters {#yandex.cloud.loadbalancer.v1.AddNetworkLoadBalancerListenerRequest}

```json
{
  "listenerSpec": {
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
}
```

#|
||Field | Description ||
|| listenerSpec | **[ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec)**

Listener spec.
This field is required. ||
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
If you provide a static public IP address for the [NetworkLoadBalancerService.Update](update.md#Update)
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

An Operation resource. For more information, see [Operation](../../../api-design-guide/concepts/operation.md).

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