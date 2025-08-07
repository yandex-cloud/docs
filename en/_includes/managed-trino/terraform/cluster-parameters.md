Here is an example of the configuration file structure:

```hcl
resource "yandex_trino_cluster" "<cluster_name>" {
  name                = "<cluster_name>"
  service_account_id  = "<service_account_ID>"
  subnet_ids          = [yandex_vpc_subnet.<subnet_name>.id]
  security_group_ids  = [<list_of_security_group_IDs>]
  deletion_protection = <protect_cluster_from_deletion>

  coordinator = {
    resource_preset_id = "<class_of_computing_resources>"
  }

  worker = {
    fixed_scale = {
      count = 4
    }
    resource_preset_id = "<class_of_computing_resources>"
  }
}

resource "yandex_vpc_network" "<network_name>" {
  name = "<network_name>"
}

resource "yandex_vpc_subnet" "<subnet_name>" {
  name           = "<subnet_name>"
  zone           = "<availability_zone>"
  network_id     = "yandex_vpc_network.<network_name>.id"
  v4_cidr_blocks = ["<range>"]
}
```

Where:

* `name`: Cluster name. It must be unique within the folder.
* `service_account_id`: Service account ID.
* `subnet_ids`: Subnet IDs list.
* `security_group_ids`: List of security group IDs.
* `deletion_protection`: Cluster protection from accidental deletion, `true` or `false`.

    Even if it is enabled, one can still connect to the cluster manually and delete it.

* `coordinator`: [Coordinator](../../../managed-trino/concepts/index.md#coordinator) configuration.

    * `resource_preset_id`: Class of coordinator’s computing resources. The possible values are:

        {% include [resource-preset-id](../resource-preset-id.md) %}

* `worker`: [Worker](../../../managed-trino/concepts/index.md#workers) configuration:

    * `resource_preset_id`: Class of worker’s computing resources. The possible values are:

        {% include [resource-preset-id](../resource-preset-id.md) %}

    * `fixed_scale`: Fixed worker scaling policy.

        * `count`: Number of workers.

    * `auto_scale`: Worker autoscaling policy.

        * `min_count`: Minimum number of workers.
        * `max_count`: Maximum number of workers.

    Specify either a fixed number of workers (`fixed_scale.count`), or minimum and maximum number of workers (`auto_scale.min_count`, `auto_scale.max_count`) for autoscaling.
