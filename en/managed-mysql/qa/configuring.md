# Configuring {{ MY }}

#### Setting a time zone {#time-zone}

A time zone is specified in terms of a UTC offset. Moscow's, for instance, is `'+03:00'`. Time zone names are not supported.

For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/5.7/en/time-zone-support.html#time-zone-variables).

#### Setting SQL mode (sql_mode) {#sql-mode}

Follow the instructions in [Managing databases](../operations/databases.md#sql-mode).

#### What value should be set for innodb_buffer_pool_size {#innodb-buffer-pool-size}

Recommended parameter range:
* A minimum of 25% of host RAM.
* A maximum of 85% of host RAM provided that at least 1 to 1.6 GB are left over for query execution, monitoring, and system processes.

#### Changing the character set and collation rules (CHARACTER SET, COLLATE) {#character-collate}

Follow the instructions in [Managing databases](../operations/databases.md#charset-collate).

#### Other settings {#params}

Editable {{ MY }} settings are listed in the [documentation](../concepts/settings-list.md). You can use one of the available interfaces (management console, CLI, API, or Terraform) to modify these. Follow the instructions in [Updating a cluster](../operations/update.md#change-mysql-config).
