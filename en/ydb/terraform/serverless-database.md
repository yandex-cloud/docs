---
title: Creating and editing parameters of a serverless {{ ydb-full-name }} database
description: Follow this guide to create or update parameters of a serverless {{ ydb-full-name }} database.
---

# Creating and editing parameters of a serverless database

To create a serverless database, use the `yandex_ydb_database_serverless` resource.

## Description of the `yandex_ydb_database_serverless` resource {#database_serverless_description}

The configuration file in your project should already include a [code section for initializing providers](./configure.md). Open the file and add this code:

```tf
resource "yandex_ydb_database_serverless" "database1" {
  name                = "test-ydb-serverless"
  deletion_protection = true

  serverless_database {
    enable_throttling_rcu_limit = false
    provisioned_rcu_limit       = 10
    storage_size_limit          = 50
    throttling_rcu_limit        = 0
  }
}
```

Note that the resource initialization strings consist of three parts:
* Keyword: `resource`.
* Resource name enclosed in quotes: `"yandex_ydb_database_serverless"`.
* Resource internal ID within the configuration file: `"database1"` (not the database name in the cloud).

The resource ID together with its name serve as an address for retrieving a field of the created resource, as is described further below. The `yandex_ydb_database_serverless` resource has the following field properties:
* `name`: Name of the database. It may contain lowercase Latin letters, digits, and hyphens. The first character must be a letter, the last one cannot be a hyphen. It must be from 3 to 63 characters long. This is a required parameter.
* `deletion_protection`: Database deletion protection (does not ensure protection of the database contents). The default value is `false`.
* `enable_throttling_rcu_limit`: Enable the throughput limit. This is an optional parameter. The default value is `false`.
* `throttling_rcu_limit`: Limit on Request Units consumed per second. This is an optional parameter. The default value is `0`.
* `provisioned_rcu_limit`: It shows the request unit usage per second charged on an hourly basis according to the service plan. If set to 0, hourly billing is disabled. This is an optional parameter. The default value is `0`.
* `storage_size_limit`: Amount of data, in GB. This is an optional parameter. The default value is `50`.

Save the file and run the `terraform validate` command. This command checks all files in the project directory for errors. If there are no errors, the terminal will output the message: `Success! The configuration is valid`. If there are errors, the terminal will output a code section containing errors and specific erroneous lines of code.

If there are no errors, run the `terraform plan` command. This command will create a plan for infrastructure changes and generate a report with the resources to be created. No real cloud resources are created at this stage. To apply changes and create actual cloud resources, use the `terraform apply` command. To confirm the action, enter `yes` in the terminal.

{{ TF }} will create all the required resources. You can check the update using the [management console]({{ link-console-main }}/) or this Yandex Cloud CLI command: `yc ydb database get <database_name>`. The terminal will display information about the created database.

If you need to change the parameters of the created database, edit the configuration file and run this command sequence: `terraform validate`, `terraform plan`, and `terraform apply`. For example, you can change the database name (name), the data storage limit (`storage_size_limit`), etc. Warning: If you change the database ID (`database1` in this case) the database will be recreated, and its data will be lost.