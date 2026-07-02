[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud DNS](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [DnsFirewall](index.md) > Update

# Cloud DNS API, gRPC: DnsFirewallService.Update

Updates the specified DNS firewall.

## gRPC request

**rpc Update ([UpdateDnsFirewallRequest](#yandex.cloud.dns.v1.UpdateDnsFirewallRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateDnsFirewallRequest {#yandex.cloud.dns.v1.UpdateDnsFirewallRequest}

```json
{
  "dns_firewall_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>",
  "deletion_protection": "bool",
  "enabled": "bool",
  "resource_config": {
    "type": "ResourceType",
    "resource_ids": [
      "string"
    ],
    "locking_policy_enabled": "bool"
  },
  "whitelist_fqdns": [
    "string"
  ],
  "blacklist_fqdns": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| dns_firewall_id | **string**

Required field. ID of the DNS firewall to update.

To get the DNS firewall ID, make a [DnsFirewallService.List](list.md#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask specifying which fields of the DNS firewall resource are going to be updated. ||
|| name | **string**

New name for the DNS firewall.
The name must be unique within the folder.

Value must match the regular expression ``` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? ```. ||
|| description | **string**

New description of the DNS firewall.

The maximum string length in characters is 256. ||
|| labels | **object** (map<**string**, **string**>)

DNS firewall labels as `key:value` pairs.
Existing set of labels is completely replaced by the provided set, so if you just want
to add or remove a label:
1. Get the current set of labels with a [DnsFirewallService.Get](get.md#Get) request.
2. Add or remove a label in this set.
3. Send the new set in this field.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\@0-9a-z]* `. Each value must match the regular expression ` [-_./\@0-9a-z]* `. No more than 64 per resource. ||
|| deletion_protection | **bool**

Prevents accidental firewall removal. ||
|| enabled | **bool**

Whether the DNS firewall is enabled. ||
|| resource_config | **[ResourceConfig](#yandex.cloud.dns.v1.DnsFirewall.ResourceConfig)**

Resource settings.
Specifies resources that the DNS firewall applies to. ||
|| whitelist_fqdns[] | **string**

List of FQDNs that the DNS firewall allows to pass.

The maximum string length in characters for each value is 255. The maximum number of elements is 255. ||
|| blacklist_fqdns[] | **string**

List of FQDNs that the DNS firewall blocks.

The maximum string length in characters for each value is 255. The maximum number of elements is 255. ||
|#

## ResourceConfig {#yandex.cloud.dns.v1.DnsFirewall.ResourceConfig}

#|
||Field | Description ||
|| type | enum **ResourceType**

Type of the resource.

- `NETWORK`: VPC network resource type.
- `FOLDER`: Folder resource type.
- `CLOUD`: Cloud resource type. ||
|| resource_ids[] | **string**

Resource ids.

The maximum string length in characters for each value is 64. The number of elements must be in the range 0-100. ||
|| locking_policy_enabled | **bool**

Whether the locking policy is enabled. ||
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