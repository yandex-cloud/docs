#### How do I set a time zone? {#time-zone}

Time zones are set as UTC offsets. For example, use `'+03:00'` for Moscow. Time zone names are not supported.

For more information, see [this {{ MY }} article](https://dev.mysql.com/doc/refman/5.7/en/time-zone-support.html#time-zone-variables).

#### How do I set SQL mode? {#sql-mode}

Follow the steps described in [Managing databases](../../managed-mysql/operations/databases.md#sql-mode).

#### What value should I set for innodb_buffer_pool_size? {#innodb-buffer-pool-size}

We recommend to set it within the following limits:
* Minimum: 25% of the host RAM.
* Maximum: 75% of the host RAM, provided that at least 1 to 1.6 GB are free for running queries, monitoring, and system processes.

#### How do I disable InnoDB strict mode? {#innodb-strict-mode}

By default, [InnoDB strict mode](../../managed-mysql/concepts/settings-list.md#setting-strict-mode) is enabled. If you disable it with {{ MY }} tools, the following error will occur:

```text
Mysql query error: (1227) Access denied; you need (at least one of) the SYSTEM_VARIABLES_ADMIN or SESSION_VARIABLES_ADMIN privilege(s) for this operation (400)
```

To disable strict mode, change the `innodb_strict_mode` value via the [{{ yandex-cloud }} interfaces](../../managed-mysql/operations/update.md#change-mysql-config). Also, make sure your configuration contains no command that disables strict mode, such as `$connection–>queryExecute("SET innodb_strict_mode=0");`.

#### How do I change character sets and collation rules? {#character-collate}

Follow the steps described in [Managing databases](../../managed-mysql/operations/databases.md#charset-collate).

#### How do I configure other settings? {#params}

The {{ MY }} settings you can update are listed in [this article](../../managed-mysql/concepts/settings-list.md). To change their values, use one of the available interfaces, such as the management console, CLI, API, or {{ TF }}. For this, follow the steps outlined in [Updating a cluster](../../managed-mysql/operations/update.md#change-mysql-config).
