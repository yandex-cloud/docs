---
title: "Creating and editing parameters of a dedicated {{ ydb-short-name }} database in {{ yandex-cloud }}"
description: "This tutorial describes properties of the `yandex_ydb_database_dedicated` resource for creating a dedicated {{ ydb-short-name }} database in {{ yandex-cloud }}."
---


# Creating and editing parameters of a dedicated database

To create a dedicated database, use the `yandex_ydb_database_dedicated` resource.

## Description of the `yandex_ydb_database_dedicated` resource {#database_dedicated_description}

Add the following code section to the project configuration file after the [provider initialization](./configure.md) section:

```tf
resource "yandex_ydb_database_dedicated" "my_database_2" {
  name = "dedicated-base"
  folder_id = "<folder_ID_in_Yandex_Cloud>"

  resource_preset_id = "medium"

  location_id = "{{ region-id }}"
  network_id  = "enpv06v9b6og********" # ID of the network to create the database in
  subnet_ids = [
    "e2lekh3vqf1p********", "e9bmliplcipm********", "b0cm0qpcf4q5********"
  ]

  scale_policy {
    fixed_scale {
      size = 2 # Number of VMs in the database
    }
  }

  storage_config {
    group_count = 1
    storage_type_id = "ssd"
  }
}
```

Properties of the `yandex_ydb_database_dedicated` resource fields:
* `name`: Name of the database. It may contain lowercase Latin letters, digits, and hyphens. The first character must be a letter, the last one cannot be a hyphen. It must be from 3 to 63 characters long. This is a required parameter.
* `folder_id`: ID of the directory (folder) in {{ yandex-cloud }} to create your database in. This is a required parameter.
* `resource_preset_id`: Name of the VM configuration template. You can use the following templates: `medium`, `medium-m64`, `medium-m96`, `large`, and `xlarge`. They differ in the processor platform, number of vCPUs, and amount of RAM. This [tutorial](../concepts/resources.md#resource-presets) gives a detailed description of the VM template configurations.
* `location_id`: Database location according to the availability zone set in the provider initialization block.
* `network_id`: Cloud network ID in the {{ yandex-cloud }} deployment.
* `subnet_ids`: List of IDs for subnets where the database will operate. It contains all subnets belonging to the network in the {{ yandex-cloud }} deployment.

Properties of the `scale_policy` section fields:
* `fixed_scale.size`: Number of VMs the database will use. The minimum recommended number of VMs is two (for the production environment).

Properties of the `storage_config` section fields:
* `group_count`: Number of [storage groups](https://ydb.tech/ru/docs/concepts/databases#storage-groups) which define the total storage size. One storage group is a multiple of 100 GB of disk space. You can only set integer values for storage groups.
* `storage_type_id`: Storage type, either `ssd` or `hdd`.

Once you have filled out all the fields of the `yandex_ydb_database_dedicated` resource and nested sections, run `terraform validate` to make sure the configuration file is error-free. Then run `terraform plan` to reconcile the changes contained in the configuration file with the current infrastructure configuration. Finally, run `terraform apply` to deploy the created resource in the cloud.

The time needed to create a dedicated database depends on the number of allocated VM instances and storage groups. To delete a dedicated database, remove the `yandex_ydb_database_dedicated` resource from the configuration file and run this command sequence: `terraform validate`, `terraform plan`, and `terraform apply`.