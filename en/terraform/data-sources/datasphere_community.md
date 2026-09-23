---
subcategory: DataSphere
---

# yandex_datasphere_community (DataSource)



## Example usage

```terraform
//
// Get information about existing Datasphere Community.
//
data "yandex_datasphere_community" "my_datasphere_community" {
  community_id = "community-id"
}
```

## Arguments & Attributes Reference

- `billing_account_id` (String). 
- `created_at` (*Read-Only*) (String). 
- `created_by` (*Read-Only*) (String). 
- `description` (*Read-Only*) (String). 
- `id` (**Required**)(String). 
- `labels` (*Read-Only*) (Map Of String). 
- `name` (*Read-Only*) (String). 
- `organization_id` (*Read-Only*) (String). 
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


