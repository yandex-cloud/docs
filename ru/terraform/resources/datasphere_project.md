---
subcategory: DataSphere
---

# yandex_datasphere_project (Resource)

Allows management of Yandex Cloud Datasphere Projects.

## Example usage

```terraform
//
// Create a new Datasphere Project.
//
resource "yandex_datasphere_project" "my-project" {
  name        = "example-datasphere-project"
  description = "Datasphere Project description"

  labels = {
    "foo" : "bar"
  }

  community_id = yandex_datasphere_community.my-community.id

  limits = {
    max_units_per_hour      = 10
    max_units_per_execution = 10
    balance                 = 10
  }

  settings = {
    service_account_id      = yandex_iam_service_account.my-account.id
    subnet_id               = yandex_vpc_subnet.my-subnet.id
    commit_mode             = "AUTO"
    data_proc_cluster_id    = "foo-data-proc-cluster-id"
    security_group_ids      = [yandex_vpc_security_group.my-security-group.id]
    ide                     = "JUPYTER_LAB"
    default_folder_id       = "foo-folder-id"
    stale_exec_timeout_mode = "ONE_HOUR"
  }
}

resource "yandex_datasphere_community" "my-community" {
  name               = "example-datasphere-community"
  description        = "Description of community"
  billing_account_id = "example-organization-id"
  labels = {
    "foo" : "bar"
  }
  organization_id = "example-organization-id"
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

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_datasphere_project.<resource Name> <resource Id>
terraform import yandex_datasphere_project.my-project ...
```
