# Creating and updating parameters of a serverless database {#ydb-serverless-create}

Open the configuration file in your project (it should already include a [provider initialization section](./configure.md)) and add the following code to it:

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
* The keyword `resource`.
* Resource name enclosed in quotes: `"yandex_ydb_database_serverless"`.
* Resource internal ID within the configuration file: `"database1"` (not the database name in the cloud).

The resource ID together with its name serve as an address for retrieving parameters of the created resource. We will demonstrate this technique further in the documentation. Now, let's describe the parameters of the `"yandex_ydb_database_serverless"` resource:
* `name`: Database name (Lowercase Latin letters, digits, and hyphens. The first character must be a letter, the last one cannot be a hyphen. Length: between 3 and 63 characters). Required parameter.
* `deletion_protection`: Database deletion protection (does not ensure protection of the database content). The default value is **false**.
* `enable_throttling_rcu_limit`: Enable the throttling limit. Optional parameter. The default value is **false**.
* `throttling_rcu_limit`: Limit on Request Units consumed per second. Optional parameter. The default value is 0.
* `provisioned_rcu_limit`: Shows the request unit usage per second charged on an hourly basis according to the service plan. If set to 0, hourly billing is disabled. Optional parameter. The default value is 0.
* `storage_size_limit`: Amount of data, in GB. Optional parameter. The default value is 50 GB.

Save the file and run the `terraform validate` command. This command checks all files in the project directory for errors. If there are no errors, the terminal will output the message: `Success! The configuration is valid`. If there are errors, the terminal will output a code section containing errors and specific erroneous lines of code.

If there are no errors, run the `terraform plan` command. This command will create a plan for infrastructure changes and generate a report with the resources to be created. No real cloud resources are created at this stage. To apply changes and create actual cloud resources, use the `terraform apply` command. To confirm the action, enter `yes` in the terminal.

Terraform will create all the required resources. You can check the changes using the [management console](https://console.cloud.yandex.com/) or this Yandex Cloud CLI command: `yc ydb database get <database_name>`. The terminal will display information about the created database.

If you need to change parameters of the created database, edit the configuration file and run this command sequence: `terraform validate`, `terraform plan`, and `terraform apply`. For example, you can change the database name (name), the data storage limit (`storage_size_limit`), etc. Be cautious: if you change the database ID (in our case, it is `"database1"`), the database will be recreated, and its data will be lost.