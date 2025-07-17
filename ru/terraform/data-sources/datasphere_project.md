---
subcategory: Datasphere
page_title: 'Yandex: yandex_datasphere_project'
description: Get information about a Yandex Cloud Datasphere Project.
sourcePath: ru/terraform/tf-ref/data-sources/datasphere_project.md
---

# yandex_datasphere_project (Data Source)

Get information about a Yandex Cloud Datasphere Project.

## Example usage

```terraform
//
// Get information about existing Datasphere Project.
//
data "yandex_datasphere_project" "my_datasphere_project" {
  project_id = "project-id"
}
```

This data source is used to define Yandex Cloud Datasphere project that can be used by other resources.

## Argument Reference

The following arguments are supported:

* `project_id` - (Required) Yandex Cloud Datasphere project id used to define project

## Attributes Reference

The following attributes are exported:

* `community_id` - Community ID where project would be created
* `name` - Name of the Datasphere Project.
* `description` - Datasphere project description.
* `labels` - A set of key/value label pairs to assign to the Datasphere Project.
* `limits` - Datasphere Project limits configuration. The structure is documented below.
* `settings` - Datasphere Project settings configuration. The structure is documented below.
* `created_at` - Creation timestamp of the Yandex Datasphere Project.
* `created_by` - Creator account ID of the Yandex Datasphere Project.

---

The `limits` block supports:

* `max_units_per_hour` - The number of units that can be spent per hour.
* `max_units_per_execution` - The number of units that can be spent on the one execution.
* `balance` - The number of units available to the project.

---

The `settings` block supports:

* `service_account_id` - ID of the service account, on whose behalf all operations with clusters will be performed.
* `subnet_id` - ID of the subnet where the DataProc cluster resides. Currently only subnets created in the availability zone ru-central1-a are supported.
* `data_proc_cluster_id` - ID of the DataProc cluster.
* `commit_mode` - Commit mode that is assigned to the project.
* `security_group_ids` -List of network interfaces security groups.
* `ide` - Project IDE.
* `default_folder_id` - Default project folder ID.
* `stale_exec_timeout_mode` - Timeout to automatically stop stale executions.
