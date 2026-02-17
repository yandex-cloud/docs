---
subcategory: Managed Service for YDB
---

# yandex_ydb_database_dedicated (Resource)

Yandex Database (dedicated) resource. For more information, see [the official documentation](https://yandex.cloud/docs/ydb/concepts/serverless_and_dedicated).

## Example usage

```terraform
//
// Create a new YDB Dedicated Database.
//
resource "yandex_ydb_database_dedicated" "database1" {
  name      = "test-ydb-dedicated"
  folder_id = data.yandex_resourcemanager_folder.test_folder.id

  network_id = yandex_vpc_network.my-inst-group-network.id
  subnet_ids = ["${yandex_vpc_subnet.my-inst-group-subnet.id}"]

  resource_preset_id  = "medium"
  deletion_protection = true

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  storage_config {
    group_count     = 1
    storage_type_id = "ssd"
  }

  location {
    region {
      id = "ru-central1"
    }
  }
}
```
```terraform
//
// Create a new YDB Dedicated Database with auto-scale policy.
//
resource "yandex_ydb_database_dedicated" "database1" {
  name      = "test-ydb-dedicated"
  folder_id = data.yandex_resourcemanager_folder.test_folder.id

  network_id = yandex_vpc_network.my-inst-group-network.id
  subnet_ids = ["${yandex_vpc_subnet.my-inst-group-subnet.id}"]

  resource_preset_id  = "medium"
  deletion_protection = true

  scale_policy {
    auto_scale {
      min_size = 2
      max_size = 8
      target_tracking {
        cpu_utilization_percent = 70
      }
    }
  }

  labels = {
    # enable preview feature
    enable_autoscaling = "1"
  }

  storage_config {
    group_count     = 1
    storage_type_id = "ssd"
  }

  location {
    region {
      id = "ru-central1"
    }
  }
}
```

## Arguments & Attributes Reference

- `assign_public_ips` (Bool). Whether public IP addresses should be assigned to the Yandex Database cluster.
- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `database_path` (*Read-Only*) (String). Full database path of the Yandex Database cluster. Useful for SDK configuration.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). The resource description.
- `folder_id` (String). The folder identifier that resource belongs to. If it is not provided, the default provider `folder-id` is used.
- `id` (String). 
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `location_id` (String). Location ID for the Yandex Database cluster.
- `name` (**Required**)(String). The resource name.
- `network_id` (**Required**)(String). The `VPC Network ID` of subnets which resource attached to.
- `resource_preset_id` (**Required**)(String). The Yandex Database cluster preset. Available presets can be obtained via `yc ydb resource-preset list` command.
- `security_group_ids` (Set Of String). The list of security groups applied to resource or their components.
- `sleep_after` (Number). 
- `status` (*Read-Only*) (String). Status of the Yandex Database cluster.
- `subnet_ids` (**Required**)(Set Of String). The list of VPC subnets identifiers which resource is attached.
- `tls_enabled` (*Read-Only*) (Bool). Whether TLS is enabled for the Yandex Database cluster. Useful for SDK configuration.
- `ydb_api_endpoint` (*Read-Only*) (String). API endpoint of the Yandex Database cluster. Useful for SDK configuration.
- `ydb_full_endpoint` (*Read-Only*) (String). Full endpoint of the Yandex Database cluster.
- `location` [Block]. Location for the Yandex Database cluster.
  - `region` [Block]. Region for the Yandex Database cluster.
    - `id` (**Required**)(String). Region ID for the Yandex Database cluster.
- `scale_policy` [Block]. Scaling policy for the Yandex Database cluster.
  - `auto_scale` [Block]. Auto scaling policy for the Yandex Database cluster. This is a preview feature, and you need to enable it using the label `enable_autoscaling=1`.
    - `max_size` (**Required**)(Number). Maximum number of nodes to which autoscaling can scale the database.
    - `min_size` (**Required**)(Number). Minimum number of nodes to which autoscaling can scale the database.
    - `target_tracking` [Block]. A target tracking scaling policy automatically scales the capacity of your Yandex Database cluster based on a target metric value.
      - `cpu_utilization_percent` (**Required**)(Number). A percentage of database nodes average CPU utilization.
  - `fixed_scale` [Block]. Fixed scaling policy for the Yandex Database cluster.
    - `size` (**Required**)(Number). Number of instances for the Yandex Database cluster.
- `storage_config` [Block]. A list of storage configuration options for the Yandex Database cluster.
  - `group_count` (**Required**)(Number). Amount of storage groups of selected type for the Yandex Database cluster.
  - `storage_type_id` (**Required**)(String). Storage type ID for the Yandex Database cluster. Available presets can be obtained via `yc ydb storage-type list` command.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_ydb_database_dedicated.<resource Name> <resource Id>
terraform import yandex_ydb_database_dedicated.my_ydb ...
```
