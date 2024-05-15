#### How do I set a time zone? {#time-zone}

A time zone is specified in terms of a UTC offset. Moscow's, for instance, is `'+03:00'`. Time zone names are not supported.

For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/5.7/en/time-zone-support.html#time-zone-variables).

#### How do I set the SQL mode (sql_mode)? {#sql-mode}

Follow the steps described in [Managing databases](../../managed-mysql/operations/databases.md#sql-mode).

#### What value should I set for innodb_buffer_pool_size? {#innodb-buffer-pool-size}

Recommended parameter range:
* Minimum 25% of host RAM.
* Maximum 75% of host RAM provided that at least 1 to 1.6 GB are free for running queries, monitoring, and system processes.

#### How do I disable InnoDB strict mode? {#innodb-strict-mode}

By default, [InnoDB strict mode](../../managed-mysql/concepts/settings-list.md#setting-strict-mode) is enabled. If you disable this mode using {{ MY }} tools, the following error will occur:

```text
Mysql query error: (1227) Access denied; you need (at least one of) the SYSTEM_VARIABLES_ADMIN or SESSION_VARIABLES_ADMIN privilege(s) for this operation (400)
```

To disable strict mode, change the `innodb_strict_mode` parameter value via the [{{ yandex-cloud }} interfaces](../../managed-mysql/operations/update.md#change-mysql-config). You should also make sure that your configuration contains no command that disables strict mode, such as `$connection–>queryExecute("SET innodb_strict_mode=0");`.

#### How do I change character sets and collation rules (CHARACTER SET, COLLATE)? {#character-collate}

Follow the steps described in [Managing databases](../../managed-mysql/operations/databases.md#charset-collate).

#### How do I configure other parameters? {#params}

Editable {{ MY }} settings are listed in the [documentation](../../managed-mysql/concepts/settings-list.md). You can use one of the available interfaces (management console, CLI, API, or {{ TF }}) to modify these. Follow the instructions in [Updating a cluster](../../managed-mysql/operations/update.md#change-mysql-config).
