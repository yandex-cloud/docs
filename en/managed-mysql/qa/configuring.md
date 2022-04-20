# Configuring {{ MY }}

#### How do I set a time zone {#time-zone}

A time zone is specified in terms of a UTC offset. Moscow's, for instance, is `'+03:00'`. Time zone names are not supported.

For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/5.7/en/time-zone-support.html#time-zone-variables).

#### How do I set the SQL mode (sql_mode) {#sql-mode}

Use the instructions provided in [Database management](../operations/databases.md#sql-mode).

#### What value should I set for innodb_buffer_pool_size {#innodb-buffer-pool-size}

Recommended parameter range:
* A minimum of 25% of host's RAM.
* A maximum of 85% of host's RAM provided that at least 1 to 1.6 GB are left over for query execution, monitoring, and system processes.

#### How do I modify the character set and character comparison rules (CHARACTER SET, COLLATE) {#character-collate}

Use the instructions provided in [Database management](../operations/databases.md#charset-collate).

#### Configuring other parameters {#params}

Editable {{ MY }} settings are listed in the [documentation](../concepts/settings-list.md). You can use one of the available interfaces (management console, CLI, API, or Terraform) to modify these. To do this, follow the instructions provided in [Changing cluster settings](../operations/update.md#change-mysql-config).
