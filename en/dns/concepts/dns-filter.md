# DNS filters

A *DNS filter* is a feature that enables you to control and filter outbound DNS queries from cloud resources using FQDN lists. You can use DNS filters on outbound DNS queries routed through the cloud [DNS resolver](./dns-resolver.md).

This feature protects cloud resources from DNS-related threats, such as DNS tunneling, and blocks access to phishing websites, botnets, and malware domains. You can also apply DNS filters when deploying resources in isolated environments (submarine mode).

## FQDN lists {#lists}

DNS filters support the following list types:
* Allowlist (whitelist): Contains FQDNs that will resolve successfully.
* Blocklist (blacklist): Contains FQDNs that will not resolve.

When creating FQDN lists, follow these rules:
* Each FQDN in the list must end with a dot (`.`).
* You may specify a domain name or its subdomains. You can use the `*` wildcard as a mask to represent any value but only at the beginning of a mask, e.g., `*.mydom.net.`.
* The list does not support regular expressions.

Examples of FQDN lists:
* `mydom.net.`
* `www.mydom1.net.,www.mydom2.net.`
* `mydom1.net.,*.mydom2.edu.`

## How to use DNS filters {#rules}

1. By default, DNS filters are created in the current folder depending on the management interface in use. To place a filter elsewhere, specify the target folder in the `folder-id` attribute during filter creation. This is especially important for [centralized filter management](#lock).

1. You can apply DNS filters to the following cloud resources:
    * [Cloud](../../resource-manager/concepts/resources-hierarchy.md#cloud)
    * [Folder](../../resource-manager/concepts/resources-hierarchy.md#folder)
    * [Network](../../vpc/concepts/network.md#network)
    * Subnet-level filtering is not supported.

1. You can create multiple filters for a single resource type.

1. When creating a filter, you can specify cloud resources to which it will apply.

1. A single filter can contain both allowlists and blocklists. You can explicitly allow a specific FQDN even if its parent domain is in the blocklist. Also, you can apply different list types to different cloud resources, e.g., use a blocklist at the cloud level and an allowlist for a specific network located in one of the cloud's folders.

1. If a single resource has multiple filters assigned to it:
    * All FQDNs from across allowlists of all filters are grouped into a single allowlist.
    * All FQDNs from across all blocklists are grouped into a single blocklist.
    * Domain resolution decisions are made based on these combined lists.

1. FQDN priority in the lists depends on the domain level, e.g., `google.com.` takes precedence over `*.com.`. If the domain levels are equal, the allowlist take precedence over the blocklist.

## Centralized filter management {#lock}

To implement centralized DNS filter management, restrict filter creation to a single folder. You can still apply these filters to any of the supported resource types listed above.

To activate centralized DNS filter management, create your first cloud-level DNS filter and bind it to a specific folder. This binding prohibits creating filters in any other folder within that cloud.

With centralized management on, attempts to create a filter in an unauthorized folder will fail with this error:

```
ERROR: rpc error: code = InvalidArgument desc = Resource "b1g28..........q7f5"
is locked by the DNS Firewall "dnsa5...........fgdpi" and must be used 
in the same folder as it
```
