---
subcategory: Identity Hub
---

# yandex_organizationmanager_idp_userpool_domain (Resource)

A domain associated with a userpool.

## Example usage

```terraform
//
// Create a new OrganizationManager Idp Userpool Domain.
//
resource "yandex_organizationmanager_idp_userpool_domain" "example_domain" {
  userpool_id = "your_userpool_id"
  domain      = "example.com"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Timestamp when the domain was created.
- `domain` (**Required**)(String). Domain name.
- `id` (String). ID in format userpool_id:domain
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `userpool_id` (**Required**)(String). ID of the userpool to get a domain for.


