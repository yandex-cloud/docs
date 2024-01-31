{% list tabs %}

- {{ mmy-name }}

   1. Make sure that the {{ MY }} major version on the target is not lower than that on the source.

   1. [Set an SQL Mode](../../../../managed-mysql/operations/update.md#change-mysql-config) matching the source.

   1. [Create a user](../../../../managed-mysql/operations/cluster-users.md#adduser) for connecting to the source.

      1. [Assign the user](../../../../managed-mysql/operations/grant.md#grant-role) the `ALL_PRIVILEGES` role for the source database.

- {{ MY }}

   1. {% include notitle [White IP list](../../configure-white-ip.md) %}

   1. Make sure that the {{ MY }} major version on the target is not lower than that on the source.

   1. Make sure the target uses the MyISAM or InnoDB low-level storage subsystem.

   1. [Set an SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting) matching the source.

   1. Create a user to connect to the target and grant them the required privileges:

      ```sql
      CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
      GRANT ALL PRIVILEGES ON <database_name>.* TO '<username>'@'%';
      ```

{% endlist %}