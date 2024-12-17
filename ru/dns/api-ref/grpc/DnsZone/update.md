---
editable: false
sourcePath: en/_api-ref-grpc/dns/v1/api-ref/grpc/DnsZone/update.md
---

# Cloud DNS API, gRPC: DnsZoneService.Update

Updates the specified DNS zone.

## gRPC request

**rpc Update ([UpdateDnsZoneRequest](#yandex.cloud.dns.v1.UpdateDnsZoneRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateDnsZoneRequest {#yandex.cloud.dns.v1.UpdateDnsZoneRequest}

```json
{
  "dns_zone_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "private_visibility": {
    "network_ids": [
      "string"
    ]
  },
  "public_visibility": "PublicVisibility",
  "deletion_protection": "bool"
}
```

#|
||Field | Description ||
|| dns_zone_id | **string**

ID of the DNS zone to update.

To get the DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/grpc/DnsZone/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask specifying which fields of the DNS zone resource are going to be updated. ||
|| name | **string**

New name for the DNS zone.
The name must be unique within the folder. ||
|| description | **string**

New description of the DNS zone. ||
|| labels | **object** (map<**string**, **string**>)

DNS zone labels as `key:value` pairs.

Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [DnsZoneService.Get](/docs/dns/api-ref/grpc/DnsZone/get#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field. ||
|| private_visibility | **[PrivateVisibility](#yandex.cloud.dns.v1.PrivateVisibility)**

Change network IDs for private visibility. ||
|| public_visibility | **[PublicVisibility](#yandex.cloud.dns.v1.PublicVisibility)**

Public visibility configuration. ||
|| deletion_protection | **bool**

Prevents accidental zone removal. ||
|#

## PrivateVisibility {#yandex.cloud.dns.v1.PrivateVisibility}

Configuration for privately visible zones.

#|
||Field | Description ||
|| network_ids[] | **string**

Network IDs. ||
|#

## PublicVisibility {#yandex.cloud.dns.v1.PublicVisibility}

Configuration for publicly visible zones.

#|
||Field | Description ||
|| Empty | > ||
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
  "metadata": {
    "dns_zone_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "zone": "string",
    "private_visibility": {
      "network_ids": [
        "string"
      ]
    },
    "public_visibility": "PublicVisibility",
    "deletion_protection": "bool"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateDnsZoneMetadata](#yandex.cloud.dns.v1.UpdateDnsZoneMetadata)**

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
|| response | **[DnsZone](#yandex.cloud.dns.v1.DnsZone)**

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

## UpdateDnsZoneMetadata {#yandex.cloud.dns.v1.UpdateDnsZoneMetadata}

#|
||Field | Description ||
|| dns_zone_id | **string**

ID of the DNS zone that is being updated. ||
|#

## DnsZone {#yandex.cloud.dns.v1.DnsZone}

A DNS zone. For details about the concept, see [DNS zones](/docs/dns/concepts/dns-zone).

#|
||Field | Description ||
|| id | **string**

ID of the DNS zone. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the DNS zone belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the DNS zone.
The name is unique within the folder. ||
|| description | **string**

Description of the DNS zone. ||
|| labels | **object** (map<**string**, **string**>)

DNS zone labels as `key:value` pairs. ||
|| zone | **string**

DNS zone suffix. ||
|| private_visibility | **[PrivateVisibility](#yandex.cloud.dns.v1.PrivateVisibility2)**

Privately visible zone settings.
Specifies whether records within the zone are visible from a VPC networks only. ||
|| public_visibility | **[PublicVisibility](#yandex.cloud.dns.v1.PublicVisibility2)**

Publicly visible zone settings.
Indicates whether records within the zone are publicly visible. ||
|| deletion_protection | **bool**

Prevents accidental zone removal. ||
|#

## PrivateVisibility {#yandex.cloud.dns.v1.PrivateVisibility2}

Configuration for privately visible zones.

#|
||Field | Description ||
|| network_ids[] | **string**

Network IDs. ||
|#

## PublicVisibility {#yandex.cloud.dns.v1.PublicVisibility2}

Configuration for publicly visible zones.

#|
||Field | Description ||
|| Empty | > ||
|#