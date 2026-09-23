---
subcategory: DataSphere
---

# yandex_datasphere_project (DataSource)



## Example usage

```terraform
//
// Get information about existing Datasphere Project.
//
data "yandex_datasphere_project" "my_datasphere_project" {
  project_id = "project-id"
}
```

## Arguments & Attributes Reference

- `community_id` (*Read-Only*) (String). 
- `created_at` (*Read-Only*) (String). 
- `created_by` (*Read-Only*) (String). 
- `description` (*Read-Only*) (String). 
- `id` (**Required**)(String). 
- `labels` (*Read-Only*) (Map Of String). 
- `limits` [Block]. 
  - `balance` (*Read-Only*) (Number). 
  - `max_units_per_execution` (*Read-Only*) (Number). 
  - `max_units_per_hour` (*Read-Only*) (Number). 
- `name` (*Read-Only*) (String). 
- `settings` [Block]. 
  - `data_proc_cluster_id` (*Read-Only*) (String). 
  - `default_folder_id` (*Read-Only*) (String). 
  - `security_group_ids` (*Read-Only*) (Set Of String). 
  - `service_account_id` (*Read-Only*) (String). 
  - `stale_exec_timeout_mode` (*Read-Only*) (String). 
  - `subnet_id` (*Read-Only*) (String). 
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


