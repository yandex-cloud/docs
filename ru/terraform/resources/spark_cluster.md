---
subcategory: Managed Spark
---

# yandex_spark_cluster (Resource)

Managed Spark cluster.

## Example usage

```terraform
//
// Create a new Spark Cluster.
//
resource "yandex_spark_cluster" "my_spark_cluster" {

  name               = "spark-cluster-1"
  description        = "created by terraform"
  service_account_id = yandex_iam_service_account.for-spark.id

  labels = {
    my_key = "my_value"
  }

  config = {
    spark_version = "3.5.7"

    resource_pools = {
      driver = {
        resource_preset_id = "c2-m8"
        size               = 1
      }
      executor = {
        resource_preset_id = "c4-m16"
        min_size           = 1
        max_size           = 2
      }
    }
    dependencies = {
      pip_packages = ["numpy==2.2.2"]
    }
  }

  network = {
    subnet_ids         = [yandex_vpc_subnet.a.id]
    security_group_ids = [yandex_vpc_security_group.spark-sg1.id]
  }

  logging = {
    enabled   = true
    folder_id = var.folder_id
  }

  maintenance_window = {
    type = "WEEKLY"
    day  = "TUE"
    hour = 10
  }
}
```

## Arguments & Attributes Reference

- `config` [Block]. Configuration of the Spark cluster.
  - `dependencies` [Block]. Environment dependencies.
    - `deb_packages` (Set Of String). Deb-packages that need to be installed using system package manager.
    - `pip_packages` (Set Of String). Python packages that need to be installed using pip (in pip requirement format).
  - `history_server` [Block]. History Server configuration.
    - `enabled` (Bool). Enable Spark History Server. Default: true.
  - `metastore` [Block]. Metastore configuration.
    - `cluster_id` (String). Metastore cluster ID for default spark configuration.
  - `resource_pools` [Block]. Computational resources.
    - `driver` [Block]. Computational resources for the driver pool.
      - `max_size` (Number). Maximum node count for the driver pool with autoscaling.
      - `min_size` (Number). Minimum node count for the driver pool with autoscaling.
      - `resource_preset_id` (**Required**)(String). Resource preset ID for the driver pool.
      - `size` (Number). Node count for the driver pool with fixed size.
    - `executor` [Block]. Computational resources for the executor pool.
      - `max_size` (Number). Maximum node count for the executor pool with autoscaling.
      - `min_size` (Number). Minimum node count for the executor pool with autoscaling.
      - `resource_preset_id` (**Required**)(String). Resource preset ID for the executor pool.
      - `size` (Number). Node count for the executor pool with fixed size.
  - `spark_version` (String). Version of Apache Spark.
- `created_at` (*Read-Only*) (String). The timestamp when the cluster was created.
- `deletion_protection` (Bool). The `true` value means that resource is protected from accidental deletion.
- `description` (String). Description of the cluster. 0-256 characters long.
- `folder_id` (String). ID of the cloud folder that the cluster belongs to.
- `id` (*Read-Only*) (String). Unique ID of the cluster.
- `labels` (Map Of String). Cluster labels as key/value pairs.
- `logging` [Block]. Cloud Logging configuration.
  - `enabled` (Bool). Enable log delivery to Cloud Logging. Default: true.
  - `folder_id` (String). Logs will be written to **default log group** of specified folder. Exactly one of the attributes `folder_id` or `log_group_id` should be specified.
  - `log_group_id` (String). Logs will be written to the **specified log group**. Exactly one of the attributes `folder_id` or `log_group_id` should be specified.
- `maintenance_window` [Block]. Configuration of the window for maintenance operations.
  - `day` (String). Day of week for maintenance window. One of `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.
  - `hour` (Number). Hour of day in UTC time zone (1-24) for maintenance window.
  - `type` (String). Type of maintenance window. Can be either `ANYTIME` or `WEEKLY`. If `WEEKLY`, day and hour must be specified.
- `name` (**Required**)(String). Name of the cluster. The name is unique within the folder.
- `network` [Block]. Network configuration.
  - `security_group_ids` (Set Of String). Network security groups.
  - `subnet_ids` (**Required**)(Set Of String). Network subnets.
- `service_account_id` (**Required**)(String). The service account used by the cluster to access cloud resources.
- `status` (*Read-Only*) (String). Status of the cluster.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_spark_cluster.<resource Name> <resource Id>
terraform import yandex_spark_cluster.my_spark_cluster ...
```
