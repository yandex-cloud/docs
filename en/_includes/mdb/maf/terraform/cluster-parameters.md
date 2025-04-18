Here is the configuration file example:

```hcl
resource "yandex_airflow_cluster" "<cluster_name>" {
  name        = "<cluster_name>"
  description = "<cluster_description>"

  labels = { <label_list> }

  admin_password     = "<administrator_password>"
  service_account_id = "<service_account_ID>"
  subnet_ids         = ["<list_of_subnet_IDs>"]
  security_group_ids = ["<list_of_security_group_IDs>"]

  webserver = {
    count              = <number_of_instances>
    resource_preset_id = "<resource_ID>"
  }

  scheduler = {
    count              = <number_of_instances>
    resource_preset_id = "<resource_ID>"
  }

  worker = {
    min_count          = <minimum_number_of_instances>
    max_count          = <maximum_number_of_instances>
    resource_preset_id = "<resource_ID>"
  }

  triggerer = {
    count              = <number_of_instances>
    resource_preset_id = "<resource_ID>"
  }

  pip_packages = ["list_of_pip_packages"]
  deb_packages = ["list_of_deb_packages"]

  code_sync = {
    s3 = {
      bucket = "<bucket_name>"
    }
  }

  deletion_protection = <deletion_protection>

  lockbox_secrets_backend = {
    enabled = <usage_of_secrets>
  }

  airflow_config = {
    <configuration_section> = {
      <key> = "<value>"
    }
  }

  logging = {
    enabled   = <use_of_logging>
    folder_id = "<folder_ID>"
    min_level = "<logging_level>"
  }
}

resource "yandex_vpc_network" "<network_name>" { name = "<network_name>" }

resource "yandex_vpc_subnet" "<subnet_name>" {
  name           = "<subnet_name>"
  zone           = "<availability_zone>"
  network_id     = "<network_ID>"
  v4_cidr_blocks = ["<range>"]
}
```

Where:

* `name`: Cluster name.
* `description`: Cluster description.
* `labels`: List of labels. Provide labels in `<key> = "<value>"` format.
* `admin_password`: Admin user password. The password must be not less than 8 characters long and contain at least:

    * One uppercase letter
    * One lowercase letter
    * One number
    * One special character

* `service_account_id`: Service account ID.