# Cloud DNS API, REST: DnsFirewall.List

Retrieves the list of DNS firewalls in the specified folder.

## HTTP request

```
GET https://dns.api.cloud.yandex.net/dns/v1/firewalls
```

## Query parameters {#yandex.cloud.dns.v1.ListDnsFirewallsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list DNS firewalls in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDnsFirewallsResponse.nextPageToken](#yandex.cloud.dns.v1.ListDnsFirewallsResponse)
that can be used to get the next page of results in subsequent list requests.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDnsFirewallsResponse.nextPageToken](#yandex.cloud.dns.v1.ListDnsFirewallsResponse) returned by a previous list request.

The maximum string length in characters is 1000. ||
|| filter | **string**

A filter expression that filters DNS firewalls listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on the [DnsFirewall.name](#yandex.cloud.dns.v1.DnsFirewall) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-dns-firewall`.

The maximum string length in characters is 1000. ||
|#

## Response {#yandex.cloud.dns.v1.ListDnsFirewallsResponse}

**HTTP Code: 200 - OK**

```json
{
  "dnsFirewalls": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| dnsFirewalls[] | **[DnsFirewall](#yandex.cloud.dns.v1.DnsFirewall)**

List of DNS firewalls in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDnsFirewallsRequest.pageSize](#yandex.cloud.dns.v1.ListDnsFirewallsRequest), use `next_page_token` as the value
for the [ListDnsFirewallsRequest.pageToken](#yandex.cloud.dns.v1.ListDnsFirewallsRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## DnsFirewall {#yandex.cloud.dns.v1.DnsFirewall}

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