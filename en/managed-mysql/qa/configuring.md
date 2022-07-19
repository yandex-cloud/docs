# Configuring {{ MY }}

#### How do I set a time zone? {#time-zone}

A time zone is specified in terms of a UTC offset. Moscow's, for instance, is `'+03:00'`. Time zone names are not supported.

For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/5.7/en/time-zone-support.html#time-zone-variables).

#### How do I set the SQL mode (sql_mode)? {#sql-mode}

Follow the instructions in [Managing databases](../operations/databases.md#sql-mode).

#### What value should I set for innodb_buffer_pool_size? {#innodb-buffer-pool-size}

Recommended parameter range:
* A minimum of 25% of host RAM.
* A maximum of 85% of host RAM provided that at least 1 to 1.6 GB are left over for query execution, monitoring, and system processes.

#### How do I change character sets and collation rules (CHARACTER SET, COLLATE)? {#character-collate}

Follow the instructions in [Managing databases](../operations/databases.md#charset-collate).

#### How do I configure other parameters? {#params}

Editable {{ MY }} settings are listed in the [documentation](../concepts/settings-list.md). You can use one of the available interfaces (management console, CLI, API, or {{ TF }}) to modify these. Follow the instructions in [Updating a cluster](../operations/update.md#change-mysql-config).
