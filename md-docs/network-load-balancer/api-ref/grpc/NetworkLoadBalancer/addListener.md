[Документация Yandex Cloud](../../../../index.md) > [Yandex Network Load Balancer](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [NetworkLoadBalancer](index.md) > AddListener

# Network Load Balancer API, gRPC: NetworkLoadBalancerService.AddListener

Adds a listener to the specified network load balancer.

## gRPC request

**rpc AddListener ([AddNetworkLoadBalancerListenerRequest](#yandex.cloud.loadbalancer.v1.AddNetworkLoadBalancerListenerRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddNetworkLoadBalancerListenerRequest {#yandex.cloud.loadbalancer.v1.AddNetworkLoadBalancerListenerRequest}

```json
{
  "network_load_balancer_id": "string",
  "listener_spec": {
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
}
```

#|
||Field | Description ||
|| network_load_balancer_id | **string**

ID of the network load balancer to add a listener to.
To get the network load balancer ID, use a [NetworkLoadBalancerService.List](list.md#List) request.
The length must be less than or equal to 50.
This field is required. ||
|| listener_spec | **[ListenerSpec](#yandex.cloud.loadbalancer.v1.ListenerSpec)**

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