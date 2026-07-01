---
editable: false
---

# Cloud DNS API, gRPC: DnsFirewallService.List

Retrieves the list of DNS firewalls in the specified folder.

## gRPC request

**rpc List ([ListDnsFirewallsRequest](#yandex.cloud.dns.v1.ListDnsFirewallsRequest)) returns ([ListDnsFirewallsResponse](#yandex.cloud.dns.v1.ListDnsFirewallsResponse))**

## ListDnsFirewallsRequest {#yandex.cloud.dns.v1.ListDnsFirewallsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list DNS firewalls in.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListDnsFirewallsResponse.next_page_token](#yandex.cloud.dns.v1.ListDnsFirewallsResponse)
that can be used to get the next page of results in subsequent list requests.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListDnsFirewallsResponse.next_page_token](#yandex.cloud.dns.v1.ListDnsFirewallsResponse) returned by a previous list request.

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

## ListDnsFirewallsResponse {#yandex.cloud.dns.v1.ListDnsFirewallsResponse}

```json
{
  "dns_firewalls": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| dns_firewalls[] | **[DnsFirewall](#yandex.cloud.dns.v1.DnsFirewall)**

List of DNS firewalls in the specified folder. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListDnsFirewallsRequest.page_size](#yandex.cloud.dns.v1.ListDnsFirewallsRequest), use `next_page_token` as the value
for the [ListDnsFirewallsRequest.page_token](#yandex.cloud.dns.v1.ListDnsFirewallsRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## DnsFirewall {#yandex.cloud.dns.v1.DnsFirewall}

A DNS firewall. For details about the concept, see [DNS firewalls](/docs/dns/concepts/dns-firewall).

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