[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud DNS > Data Sources > dns_firewall

# yandex_dns_firewall (DataSource)

A DNS firewall. For details about the concept, see [DNS firewalls](../../dns/concepts/dns-firewall).

## Example usage

```terraform
//
// Get information about existing DNS Firewall.
//
data "yandex_dns_firewall" "foo" {
  dns_firewall_id = yandex_dns_firewall.fw1.id
}

output "whitelist_fqdns" {
  value = data.yandex_dns_firewall.foo.whitelist_fqdns
}
```

## Arguments & Attributes Reference

- `blacklist_fqdns` (Set Of String). List of FQDNs that the DNS firewall blocks.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `deletion_protection` (Bool). Prevents accidental firewall removal.
- `description` (String). Description of the DNS firewall.
- `dns_firewall_id` (String). ID of the DNS firewall to return.

 To get a DNS firewall ID, make a [DnsFirewallService.List] request.
- `enabled` (Bool). Whether the DNS firewall is enabled.
- `folder_id` (String). ID of the folder that the DNS firewall belongs to.
- `id` (String). ID of the DNS firewall to return.

 To get a DNS firewall ID, make a [DnsFirewallService.List] request.
- `labels` (Map Of String). DNS firewall labels as `key:value` pairs.
- `name` (String). Name of the DNS firewall.
 The name is unique within the folder.
- `resource_config` [Block]. Resource settings.
 Specifies resources that the DNS firewall applies to.
  - `lock_resources` (Bool). Whether the locking policy is enabled.
  - `resource_ids` (Set Of String). Resource ids.
  - `type` (String). Type of the resource.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `whitelist_fqdns` (Set Of String). List of FQDNs that the DNS firewall allows to pass.