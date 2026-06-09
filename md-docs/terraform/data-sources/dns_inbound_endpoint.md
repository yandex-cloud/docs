# yandex_dns_inbound_endpoint (DataSource)



## Example usage

```terraform
//
// Get information about existing DNS Inbound Endpoint.
//
data "yandex_dns_inbound_endpoint" "foo" {
  dns_inbound_endpoint_id = yandex_dns_inbound_endpoint.endpoint1.id
}

output "address" {
  value = data.yandex_dns_inbound_endpoint.foo.address
}
```

## Arguments & Attributes Reference

- `address` (*Read-Only*) (String). IP address of the DNS inbound endpoint.
- `address_id` (**Required**)(String). ID of the address resource.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `deletion_protection` (Bool). Prevents accidental endpoint removal.
- `description` (String). Description of the DNS inbound endpoint.
- `dns_inbound_endpoint_id` (String). ID of the DNS inbound endpoint to return.
- `folder_id` (String). ID of the folder that the DNS inbound endpoint belongs to.
- `id` (String). ID of the DNS inbound endpoint to return.
- `labels` (Map Of String). DNS inbound endpoint labels as `key:value` pairs.
- `name` (String). Name of the DNS inbound endpoint.
 The name is unique within the folder.
- `network_id` (**Required**)(String). ID of the network that the DNS inbound endpoint belongs to.
- `status` (*Read-Only*) (String). Status of the DNS inbound endpoint.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).