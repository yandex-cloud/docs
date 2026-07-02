[Документация Yandex Cloud](../../../../index.md) > [Yandex Compute Cloud](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Instance](index.md) > AddOneToOneNat

# Compute Cloud API, gRPC: InstanceService.AddOneToOneNat

Enables One-to-one NAT on the network interface.

## gRPC request

**rpc AddOneToOneNat ([AddInstanceOneToOneNatRequest](#yandex.cloud.compute.v1.AddInstanceOneToOneNatRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddInstanceOneToOneNatRequest {#yandex.cloud.compute.v1.AddInstanceOneToOneNatRequest}

```json
{
  "instance_id": "string",
  "network_interface_index": "string",
  "internal_address": "string",
  "one_to_one_nat_spec": {
    "ip_version": "IpVersion",
    "address": "string",
    "dns_record_specs": [
      {
        "fqdn": "string",
        "dns_zone_id": "string",
        "ttl": "int64",
        "ptr": "bool"
      }
    ]
  }
}
```

Enables One-to-one NAT on the network interface.

#|
||Field | Description ||
|| instance_id | **string**

ID of the instance to enable One-to-One NAT on. ||
|| network_interface_index | **string**

The index of the network interface to enable One-to-One NAT on. ||
|| internal_address | **string**

The network address that is assigned to the instance for this network interface. ||
|| one_to_one_nat_spec | **[OneToOneNatSpec](#yandex.cloud.compute.v1.OneToOneNatSpec)**

An external IP address configuration.
If not specified, then this instance will have no external internet access. ||
|#

## OneToOneNatSpec {#yandex.cloud.compute.v1.OneToOneNatSpec}

#|
||Field | Description ||
|| ip_version | enum **IpVersion**

External IP address version.

- `IPV4`: IPv4 address, for example 192.0.2.235.
- `IPV6`: IPv6 address. Not available yet. ||
|| address | **string**

set static IP by value ||
|| dns_record_specs[] | **[DnsRecordSpec](#yandex.cloud.compute.v1.DnsRecordSpec)**

External DNS configuration ||
|#

## DnsRecordSpec {#yandex.cloud.compute.v1.DnsRecordSpec}

#|
||Field | Description ||
|| fqdn | **string**

FQDN (required)
This field is required. ||
|| dns_zone_id | **string**

DNS zone id (optional, if not set, private zone used) ||
|| ttl | **int64**

DNS record ttl, values in 0-86400 (optional)
The value must be between 0 and 86400. ||
|| ptr | **bool**

When set to true, also create PTR DNS record (optional) ||
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