# Migrating a database from {{ mmy-name }} to a third-party {{ MY }} cluster

{% note info %}

To learn about migrating data from a third-party {{ MY }} cluster, see [this tutorial](../../managed-mysql/tutorials/data-migration/index.md).

{% endnote %}

To migrate a database deployed in a {{ mmy-name }} cluster to a third-party {{ MY }} cluster:

1. Transfer the data.
1. Disable data writes to the source database.
1. Switch all traffic to the third-party cluster.

You can migrate your databases from one {{ MY }} version to another, e.g., from {{ MY }} 5.7 to {{ MY }} 8. Note that the third-party cluster must run a major {{ MY }} version not lower than that on your {{ mmy-name }} cluster.

There are two ways to migrate data from a {{ mmy-name }} _source cluster_ to a third-party {{ MY }} _target cluster_:

* [Transfer data using {{ data-transfer-full-name }}](#data-transfer).

    This method enables you to migrate the entire database without downtime for users.

    Learn more in [{#T}](../../data-transfer/concepts/use-cases.md).

* [Transfer data using external replication](#binlog-replication).

    [_External replication_](https://dev.mysql.com/doc/refman/8.0/en/replication-configuration.html) enables you to migrate databases between {{ MY }} clusters using native DBMS tools.

    Use this approach only if, for some reason, transferring data with {{ data-transfer-full-name }} is not an option.

## Getting started {#before-you-begin}

Set up the target cluster:

* [Create a {{ MY }} database](https://dev.mysql.com/doc/refman/8.0/en/creating-database.html) with any suitable configuration.
* Make sure you can connect to the target cluster hosts from the internet.

Additionally, to migrate data using external {{ MY }} replication:

* Check that all source cluster hosts are accessible via public IP addresses to make sure the target cluster can connect to the source cluster. To do this:
   * [Add hosts](../../managed-mysql/operations/hosts.md#add) with public IP addresses.
   * [Delete hosts](../../managed-mysql/operations/hosts.md#remove) without public IP addresses.
* Install the [{{ mmy-name }} server SSL certificates](../../managed-mysql/operations/connect.md#get-ssl-cert) on the target cluster hosts. These certificates are required to connect to a publicly accessible source cluster.
* If required, set up a firewall and configure [security groups](../../managed-mysql/operations/connect.md#configuring-security-groups) to enable connections from the target cluster to the source cluster and to each cluster individually, e.g., using [mysql](https://dev.mysql.com/doc/refman/8.0/en/mysql.html).
* Make sure the target cluster hosts can connect to the source cluster hosts.
* Make sure you can [connect](../../managed-mysql/operations/connect.md) to both the source cluster and the target cluster using SSL.

## Transferring data using {{ data-transfer-full-name }} {#data-transfer}


### Required paid resources {#paid-resources-with-data-transfer}

* {{ mmy-name }} cluster: computing resources allocated to hosts, size of storage and backups (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Each transfer: use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


### Migrate the database {#database-migration}


{% include notitle [MMY moving data with Data Transfer](../../_tutorials/dataplatform/datatransfer/managed-mysql-to-mysql.md) %}

## Transferring data using external replication {#binlog-replication}

1. [Transfer the logical database dump](#migrate-schema).
1. [Configure the user in the source cluster to manage replication](#configure-user).
1. [Start replication in the target cluster](#start-replica).
1. [Monitor the migration process](#monitor-migration) until it is complete.
1. [Complete your migration](#finish-migration).


### Required paid resources {#paid-resources-binlog-replication}

* {{ mmy-name }} cluster: computing resources allocated to hosts, size of storage and backups (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


### Transfer the logical database dump {#migrate-schema}

A _logical dump_ is a file with a sequence of commands that can restore the database state. You can create it with [mysqldump](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html). Before creating a logical dump, pause database writes to ensure its completeness.

{% note warning %}

If your database contains user-defined stored procedures, [grant](../../managed-mysql/operations/grant.md#grant-privilege) the database owner the [SHOW ROUTINE](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) administrative privilege to perform a logical dump.

{% endnote %}

1. Get the current binary log position to ensure consistency when restoring the logical dump:

    ```sql
    SHOW MASTER STATUS;
    ```

    ```text
    +-------------------------+----------+--------------+------------------+-----------------------------+
    | File                    | Position | Binlog_Do_DB | Binlog_Ignore_DB | Executed_Gtid_Set           |
    +-------------------------+----------+--------------+------------------+-----------------------------+
    | mysql-bin-log-...000224 |  2058567 |              |                  | d827098b-...00b86:1-1575866 |
    +-------------------------+----------+--------------+------------------+-----------------------------+
    1 row in set (0.00 sec)
    ```

    Save the `File` and `Position` values, as you will need them to start replication.

1. Create a dump of the source cluster database:

   ```bash
   mysqldump \
       --databases=<DB_name> \
       --routines \
       --host=<master_host_FQDN> \
       --ssl-ca=<path_to_SSL_certificate> \
       --user=<DB_owner_username> > <dump_file>
   ```

   {% include [spec-fqdn](../_tutorials_includes/special-fqdn-master-mmy.md) %}

1. Restore the database from the dump in the target cluster:

    {% list tabs group=connection %}

    - Connecting with SSL {#with-ssl}

       ```bash
       mysql --host=<master_host_FQDN> \
             --user=<username> \
             --password \
             --port=3306 \
             --ssl-ca=<path_to_SSL_certificate> \
             --ssl-mode=VERIFY_IDENTITY \
             --line-numbers \
             <DB_name> < <dump_file>
       ```

    - Connecting without SSL {#without-ssl}

       ```bash
       mysql --host=<master_host_FQDN> \
             --user=<username> \
             --password \
             --port=3306 \
             --line-numbers \
             <DB_name> < <dump_file>
       ```

    {% endlist %}

1. Create a user in the target cluster with full permissions for the database being migrated:

   ```sql
   CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
   GRANT ALL PRIVILEGES ON <DB_name>.* TO '<username>'@'%';
   ```

### Configure the user in the source cluster to manage replication {#configure-user}

{{ MY }} uses the <q>master-replica</q> model for replication: the target cluster copies the source cluster's binary log changes to its own relay log. The replica host applies these changes to its data.

To capture binary log changes and manage replication in the source cluster:
1. [Create a user](../../managed-mysql/operations/cluster-users.md#adduser).
1. [Assign](../../managed-mysql/operations/grant.md) it the `ALL_PRIVILEGES` role for the source cluster database.
1. [Grant](../../managed-mysql/operations/cluster-users.md#update-settings) the user the `REPLICATION CLIENT` and `REPLICATION SLAVE` global privileges as well.

The target cluster will connect to the source cluster as this user.

### Start replication in the target cluster {#start-replica}

1. Edit the `/etc/mysql/my.cnf` file containing the target cluster configuration to start replication:

   ```bash
   [mysqld]
   ...
   log_bin = mysql-bin
   server_id = 2
   relay-log = /var/lib/mysql/mysql-relay-bin
   relay-log-index = /var/lib/mysql/mysql-relay-bin.index

   gtid-mode = on
   enforce-gtid-consistency = on
   ```

   Where:

   * `log_bin`: Binary log name in the target cluster.
   * `server_id`: Target cluster ID. The default value is `1`. However, to run replication, make sure the values of the source and target cluster IDs are different.
   * `relay-log`: Path to the relay log.
   * `relay-log-index`: Path to the relay log index.

   Also, enable `gtid-mode` and `enforce-gtid-consistency` for replication. In {{ mmy-name }} clusters, they are always enabled.

1. Restart `mysql`:

    ```bash
    sudo systemctl restart mysql
    ```

1. Connect to the target cluster as the user with full access to the database you want to migrate.
1. Enable replication for this database and disable it for system databases, since they replicate by default:

   ```sql
   CHANGE REPLICATION FILTER
       REPLICATE_DO_DB=(
           <target_cluster_DB_name>
       ),
       REPLICATE_IGNORE_DB=(
           sys,
           mysql,
           performance_schema,
           information_schema
       );
   ```

1. To assign a master for the target cluster, specify the parameters of the master host in the source cluster:

   {% include [spec-fqdn](../_tutorials_includes/special-fqdn-master-mmy.md) %}

   ```sql
   CHANGE MASTER TO
         MASTER_HOST = '<master_host_FQDN>',
         MASTER_USER = '<user_for_replication>',
         MASTER_PASSWORD = '<user_password>',
         MASTER_LOG_FILE = '<File_value_from_binary_log_position_query>',
         MASTER_LOG_POS = <Position_value_from_binary_log_position_query>,
         MASTER_SSL_CA = '<path_to_SSL_certificate>',
         MASTER_SSL_VERIFY_SERVER_CERT = 0,
         MASTER_SSL = 1;
   ```

1. Start applying the relay log:

   ```sql
   START SLAVE;
   ```

   This initiates data migration from the source cluster database to the target cluster database.

1. After successfully starting the replication, run this command once:

   ```sql
   STOP SLAVE;
   CHANGE MASTER TO MASTER_AUTO_POSITION = 1;
   START SLAVE;
   ```

   This is to ensure the replication will be reconfigured to use the new master host if the master host in the source cluster changes. For more information about configurations, see this [{{ MY }} article](https://dev.mysql.com/doc/refman/8.0/en/change-master-to.html).

### Monitor your data migration {#monitor-migration}

Run the command that returns the *replication status*:

```sql
SHOW SLAVE STATUS\G
```

```text
*************************** 1. row ***************************
           Slave_IO_State: Waiting for master to send event
              Master_Host: rc1a-hxk9audl********.{{ dns-zone }}
              Master_User: replica-my
              Master_Port: 3306
            Connect_Retry: 60
          Master_Log_File: mysql-bin-log-rc1a-hxk9audl********-mdb-yandexcloud-net.000225
      Read_Master_Log_Pos: 1702815
           Relay_Log_File: 6b6d647a39b6-relay-bin.000084
            Relay_Log_Pos: 409
            ...
```

The following fields contain info on the replication status:

* `Slave_IO_State` and `Slave_SQL_Running_State`: I/O state of the binary log and relay log streams. If replication is successful, both streams are active.
* `Read_Master_Log_Pos`: Last position read from the master host log.
* `Seconds_Behind_Master`: Replica's lag behind the master, in seconds.
* `Last_IO_Error` and `Last_SQL_Error`: Replication errors.

For more information about the replication status, see [this {{ MY }} article](https://dev.mysql.com/doc/refman/8.0/en/replication-administration-status.html).

### Complete your migration {#finish-migration}

1. Stop all writes to the source cluster and make sure the application does not write data to its database. You can do this by [updating the `MAX_UPDATES_PER_HOUR` user-defined setting of the source cluster](../../managed-mysql/operations/cluster-users.md#update-settings) to `1`.
1. Wait for the `Seconds_Behind_Master` value to decrease to zero. This means that all changes that occurred in the source cluster after creating the logical dump have been transferred to the target cluster.
1. Stop replication in the target cluster:

   ```sql
   STOP SLAVE;
   ```

1. Switch the load to the target cluster.
1. [Delete the user](../../managed-mysql/operations/cluster-users.md#removeuser) managing replication in the source cluster.
1. Delete the user with full access to the migrated database in the target cluster if this user is no longer needed.
