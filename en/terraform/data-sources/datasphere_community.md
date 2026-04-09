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

- `billing_account_id` (String). Billing account ID to associated with community
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `created_by` (*Read-Only*) (String). Creator account ID of the Datasphere Community
- `description` (String). 
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). 
- `name` (**Required**)(String). The resource name.
- `organization_id` (String). Organization ID where community would be created
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


