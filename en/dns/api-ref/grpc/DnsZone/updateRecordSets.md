---
editable: false
sourcePath: en/_api-ref-grpc/dns/v1/api-ref/grpc/DnsZone/updateRecordSets.md
---

# Cloud DNS API, gRPC: DnsZoneService.UpdateRecordSets

Method with strict control for changing zone state. Returns error when:
1. Deleted record is not found.
2. Found record with matched type and name but different TTL or value.
3. Attempted to add record with existing name and type.
Deletions happen first. If a record with the same name and type exists in both lists,
then the existing record will be deleted, and a new one added.

## gRPC request

**rpc UpdateRecordSets ([UpdateRecordSetsRequest](#yandex.cloud.dns.v1.UpdateRecordSetsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateRecordSetsRequest {#yandex.cloud.dns.v1.UpdateRecordSetsRequest}

```json
{
  "dns_zone_id": "string",
  "deletions": [
    {
      "name": "string",
      "type": "string",
      "ttl": "int64",
      "data": [
        "string"
      ]
    }
  ],
  "additions": [
    {
      "name": "string",
      "type": "string",
      "ttl": "int64",
      "data": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| dns_zone_id | **string**

ID of the DNS zone to update record sets in.

To get a DNS zone ID, make a [DnsZoneService.List](/docs/dns/api-ref/grpc/DnsZone/list#List) request. ||
|| deletions[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet)**

List of record sets to delete. ||
|| additions[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet)**

List of record sets to add. ||
|#

## RecordSet {#yandex.cloud.dns.v1.RecordSet}

A record set. For details about the concept, see [Resource record](/docs/dns/concepts/resource-record).

#|
||Field | Description ||
|| name | **string**

Domain name. ||
|| type | **string**

Record type. ||
|| ttl | **int64**

Time to live in seconds. ||
|| data[] | **string**

Data of the record set. ||
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
  "metadata": "UpdateRecordSetsMetadata",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "additions": [
      {
        "name": "string",
        "type": "string",
        "ttl": "int64",
        "data": [
          "string"
        ]
      }
    ],
    "deletions": [
      {
        "name": "string",
        "type": "string",
        "ttl": "int64",
        "data": [
          "string"
        ]
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateRecordSetsMetadata](#yandex.cloud.dns.v1.UpdateRecordSetsMetadata)**

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
|| response | **[RecordSetDiff](#yandex.cloud.dns.v1.RecordSetDiff)**

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

## UpdateRecordSetsMetadata {#yandex.cloud.dns.v1.UpdateRecordSetsMetadata}

#|
||Field | Description ||
|| Empty | > ||
|#

## RecordSetDiff {#yandex.cloud.dns.v1.RecordSetDiff}

#|
||Field | Description ||
|| additions[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet2)**

List of record sets that were added ||
|| deletions[] | **[RecordSet](#yandex.cloud.dns.v1.RecordSet2)**

List of record sets that were deleted ||
|#

## RecordSet {#yandex.cloud.dns.v1.RecordSet2}

A record set. For details about the concept, see [Resource record](/docs/dns/concepts/resource-record).

#|
||Field | Description ||
|| name | **string**

Domain name. ||
|| type | **string**

Record type. ||
|| ttl | **int64**

Time to live in seconds. ||
|| data[] | **string**

Data of the record set. ||
|#