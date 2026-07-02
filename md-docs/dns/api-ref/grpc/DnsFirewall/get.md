[Документация Yandex Cloud](../../../../index.md) > [Yandex Cloud DNS](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [DnsFirewall](index.md) > Get

# Cloud DNS API, gRPC: DnsFirewallService.Get

Returns the specified DNS firewall.
To get the list of all available DNS firewalls, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetDnsFirewallRequest](#yandex.cloud.dns.v1.GetDnsFirewallRequest)) returns ([DnsFirewall](#yandex.cloud.dns.v1.DnsFirewall))**

## GetDnsFirewallRequest {#yandex.cloud.dns.v1.GetDnsFirewallRequest}

```json
{
  "dns_firewall_id": "string"
}
```

#|
||Field | Description ||
|| dns_firewall_id | **string**

Required field. ID of the DNS firewall to return.
To get a DNS firewall ID, make a [DnsFirewallService.List](list.md#List) request. ||
|#

## DnsFirewall {#yandex.cloud.dns.v1.DnsFirewall}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
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

A DNS firewall. For details about the concept, see [DNS firewalls](../../../concepts/dns-firewall).

#|
||Field | Description ||
|| id | **string**

ID of the DNS firewall. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the DNS firewall belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the DNS firewall.
The name is unique within the folder. ||
|| description | **string**

Description of the DNS firewall. ||
|| labels | **object** (map<**string**, **string**>)

DNS firewall labels as `key:value` pairs. ||
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