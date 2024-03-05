{% list tabs %}

- {{ mmy-name }}

   1. [Enable full binary logging](../../../../managed-mysql/operations/update.md#change-mysql-config) on the source by setting the [**Binlog row image** parameter](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image) to `FULL` or `NOBLOB`.

   1. (Optional) [Set a limit](../../../../managed-mysql/operations/update.md#change-mysql-config) on the size of data chunks to be sent using the **Max allowed packet** parameter.

   1. [Create a user](../../../../managed-mysql/operations/cluster-users.md#adduser) for connecting to the source.

      1. [Grant the user](../../../../managed-mysql/operations/grant.md#grant-privilege) the `ALL_PRIVILEGES` privilege for the source database.

      1. [Grant the user](../../../../managed-mysql/concepts/settings-list#setting-administrative-privileges) the `REPLICATION CLIENT` and `REPLICATION SLAVE` administrative privileges.

   1. {% include [primary-keys-mysql](../../primary-keys-mysql.md) %}

      {% note info %}

      If, when creating a primary key, you get an error saying _`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`_, [increase](../../../../managed-mysql/operations/update.md#change-mysql-config) the [`Innodb log file size` parameter](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) value in the DBMS settings.

      {% endnote %}

   1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ MY }} source](../../../../data-transfer/operations/endpoint/source/mysql.md#additional-settings).

- {{ MY }}

   1. {% include notitle [White IP list](../../configure-white-ip.md) %}

   1. Make sure the source uses the MyISAM or InnoDB low-level storage subsystem. If you use other subsystems, the transfer may fail.

   1. [Enable full binary logging](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) on the source by setting the `binlog_row_image` parameter to `FULL` or `NOBLOB`.

   1. [Specify row format for the binary log](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_format) on the source by setting the `binlog_format` parameter to `ROW`.

   1. If the replication source is a cluster that is behind the load balancer, enable GTID mode for it (`GTID-MODE = ON`).

      If it is not possible to enable GTID mode for any reason, make sure the binary log name template contains the host name.

      In both cases, this will allow replication to continue even after changing the master host.

   1. (Optional) [Set a limit](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) on the size of data chunks to be sent using the `max_allowed_packet` parameter.

   1. Create a user to connect to the source and grant them the required privileges:

      ```sql
      CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
      GRANT ALL PRIVILEGES ON <database_name>.* TO '<username>'@'%';
      GRANT REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO '<username>'@'%';
      ```

   1. {% include [Tables without primary keys](../../primary-keys-mysql.md) %}

      {% note info %}

      If, when creating a primary key, you get an error saying _`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`_, increase the [`inno_db_log_file_size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) parameter value in the DBMS settings.

      {% endnote %}

   1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ MY }} source](../../../../data-transfer/operations/endpoint/source/mysql.md#additional-settings).

{% endlist %}