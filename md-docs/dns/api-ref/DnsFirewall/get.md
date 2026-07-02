[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud DNS](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [DnsFirewall](index.md) > Get

# Cloud DNS API, REST: DnsFirewall.Get

Returns the specified DNS firewall.
To get the list of all available DNS firewalls, make a [List](list.md#List) request.

## HTTP request

```
GET https://dns.api.cloud.yandex.net/dns/v1/firewalls/{dnsFirewallId}
```

## Path parameters

#|
||Field | Description ||
|| dnsFirewallId | **string**

Required field. ID of the DNS firewall to return.
To get a DNS firewall ID, make a [DnsFirewallService.List](list.md#List) request. ||
|#

## Response {#yandex.cloud.dns.v1.DnsFirewall}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "deletionProtection": "boolean",
  "enabled": "boolean",
  "resourceConfig": {
    "type": "string",
    "resourceIds": [
      "string"
    ],
    "lockingPolicyEnabled": "boolean"
  },
  "whitelistFqdns": [
    "string"
  ],
  "blacklistFqdns": [
    "string"
  ]
}
```

A DNS firewall. For details about the concept, see [DNS firewalls](../../concepts/dns-firewall).

#|
||Field | Description ||
|| id | **string**

ID of the DNS firewall. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the DNS firewall belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the DNS firewall.
The name is unique within the folder. ||
|| description | **string**

Description of the DNS firewall. ||
|| labels | **object** (map<**string**, **string**>)

DNS firewall labels as `key:value` pairs. ||
|| deletionProtection | **boolean**

Prevents accidental firewall removal. ||
|| enabled | **boolean**

Whether the DNS firewall is enabled. ||
|| resourceConfig | **[ResourceConfig](#yandex.cloud.dns.v1.DnsFirewall.ResourceConfig)**

Resource settings.
Specifies resources that the DNS firewall applies to. ||
|| whitelistFqdns[] | **string**

List of FQDNs that the DNS firewall allows to pass.

The maximum string length in characters for each value is 255. The maximum number of elements is 255. ||
|| blacklistFqdns[] | **string**

List of FQDNs that the DNS firewall blocks.

The maximum string length in characters for each value is 255. The maximum number of elements is 255. ||
|#

## ResourceConfig {#yandex.cloud.dns.v1.DnsFirewall.ResourceConfig}

#|
||Field | Description ||
|| type | **enum** (ResourceType)

Type of the resource.

- `NETWORK`: VPC network resource type.
- `FOLDER`: Folder resource type.
- `CLOUD`: Cloud resource type. ||
|| resourceIds[] | **string**

Resource ids.

The maximum string length in characters for each value is 64. The number of elements must be in the range 0-100. ||
|| lockingPolicyEnabled | **boolean**

Whether the locking policy is enabled. ||
|#