---
subcategory: DataSphere
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/datasphere_project.md
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

- `community_id` (**Required**)(String). Community ID where project would be created.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `created_by` (*Read-Only*) (String). Creator account ID of the Datasphere Project.
- `description` (String). The resource name.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `limits` [Block]. Datasphere Project limits configuration.
  - `balance` (Number). The number of units available to the project.
  - `max_units_per_execution` (Number). The number of units that can be spent on the one execution.
  - `max_units_per_hour` (Number). The number of units that can be spent per hour.
- `name` (**Required**)(String). The resource name.
- `settings` [Block]. Datasphere Project settings configuration.
  - `data_proc_cluster_id` (String). ID of the DataProcessing cluster.
  - `default_folder_id` (String). Default project folder ID.
  - `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
  - `service_account_id` (String). [Service account](https://yandex.cloud/docs/iam/concepts/users/service-accounts) which linked to the resource.
  - `stale_exec_timeout_mode` (String). The timeout to automatically stop stale executions. The following modes can be used:
 * `ONE_HOUR`: Setting to automatically stop stale execution after one hour with low consumption.
  * `THREE_HOURS`: Setting to automatically stop stale execution after three hours with low consumption.
  * `NO_TIMEOUT`: Setting to never automatically stop stale executions.

  - `subnet_id` (String). ID of the subnet where the DataProcessing cluster resides. Currently only subnets created in the availability zone `ru-central1-a` are supported.


