# Migrating a database from {{ mmy-name }} to a third-party {{ MY }} cluster

{% note info %}

To learn about data migration from a third-party {{ MY }} cluster, see this article: [{#T}](../../managed-mysql/tutorials/data-migration.md).

{% endnote %}

To migrate a database deployed in a {{ mmy-name }} cluster to a third-party {{ MY }} cluster:

1. Transfer data.
1. Disable data writes to the source database.
1. Transfer the load to a third-party cluster.

Migration across versions is supported. For example, you can move databases from {{ MY }} 5.7 to 8. The {{ MY }} major version on a third-party cluster must be the same or higher than the version in the {{ mmy-name }} cluster.

There are two ways to migrate data from a {{ mmy-name }} _source cluster_ to a third-party {{ MY }} _target cluster_:

* [Transferring data using {{ data-transfer-full-name }}](#data-transfer).

    This method allows you to migrate the entire database without interrupting user service.

    For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

* [Transferring data using external replication](#binlog-replication).

    [_External replication_](https://dev.mysql.com/doc/refman/8.0/en/replication-configuration.html) allows you to migrate databases across {{ MY }} clusters using built-in DBMS tools.

    Use this method only if, for some reason, it is not possible to migrate data using {{ data-transfer-full-name }}.

## Getting started {#before-you-begin}

Prepare the target cluster:

* Create a [{{ MY }} database](https://dev.mysql.com/doc/refman/8.0/en/creating-database.html) in any suitable configuration.
* Make sure that you can connect to the target cluster hosts from the internet.

Additionally, to migrate data using external {{ MY }} replication:

* Make sure all the source cluster's hosts are accessible by a public IP address so that the target cluster can connect to the source. To do this:
   * [Add hosts](../../managed-mysql/operations/hosts.md#add) with public IP addresses.
   * [Delete hosts](../../managed-mysql/operations/hosts.md#remove) without public IP addresses.
* Install [{{ mmy-name }} server SSL certificates](../../managed-mysql/operations/connect.md#get-ssl-cert) on the target cluster's hosts. They are required to connect to the publicly available source cluster.
* If you need to, set up a firewall and [security groups](../../managed-mysql/operations/connect.md#configuring-security-groups) so you can connect to the source cluster, as well as to each cluster separately, e.g., using the [mysql utility](https://dev.mysql.com/doc/refman/8.0/en/mysql.html), from the target cluster.
* Make sure you can connect to the source cluster's hosts from the target cluster's hosts.
* Make sure that you can [connect to the source cluster](../../managed-mysql/operations/connect.md) and the target cluster via SSL.

## Transferring data using {{ data-transfer-full-name }} {#data-transfer}


{% include notitle [MMY moving data with Data Transfer](../../_tutorials/dataplatform/datatransfer/managed-mysql-to-mysql.md) %}


### Required paid resources {#paid-resources-with-data-transfer}

Cost of transferring data with {{ data-transfer-full-name }} includes:

* {{ mmy-name }} cluster fee: use of computing resources allocated to hosts and disk space (see [{{ MY }} pricing](../../managed-mysql/pricing.md)).
* Fee for public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Transfer fee: use of computing resources and number of transferred data rows (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing.md)).


## Transferring data using external replication {#binlog-replication}

1. [Transfer a logical dump of the database](#migrate-schema).
1. [Configure the user in the source cluster to manage replication](#configure-user).
1. [Start replication in the target cluster](#start-replica).
1. [Monitor the migration process](#monitor-migration) until it is complete.
1. [Complete your migration](#finish-migration).


### Required paid resources {#paid-resources-binlog-replication}

The cost of transferring data using external replication includes:

* {{ mmy-name }} cluster fee: use of computing resources allocated to hosts and disk space (see [{{ MY }} pricing](../../managed-mysql/pricing.md)).
* Fee for public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


### Transfer a logical dump of the database {#migrate-schema}

A _logical dump_ is a file with a set of commands running which one by one you can restore the state of a database. It is created using the [mysqldump utility](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html). To ensure that a logical dump is complete, pause data writes to the database before creating it.

{% note warning %}

If the database stores custom procedures, [grant](../../managed-mysql/operations/grant.md#grant-privilege) the database owner the [SHOW ROUTINE](../../managed-mysql/concepts/settings-list.md#setting-administrative-privileges) administrative privilege to perform a logical dump.

{% endnote %}

1. Request the current position of the binary log to make sure that restoring the logical dump is consistent:

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

    Write down the `File` and `Position` values. You will need them when starting replication.

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

1. Restore the database from the dump on the target cluster:

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

1. Create a user with full access rights to the database being migrated in the target cluster:

   ```sql
   CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
   GRANT ALL PRIVILEGES ON <DB_name>.* TO '<username>'@'%';
   ```

### Configure the user in the source cluster to manage replication {#configure-user}

{{ MY }} uses the <q>master-replica</q> model when performing replication: the target cluster replicates the changes of the source cluster's binary log to its relay log. The host replica reproduces the changes from the relay log applying them to its own data.

To get binary log changes and manage the replication flow in the source cluster:
1. [Create a user](../../managed-mysql/operations/cluster-users.md#adduser).
1. [Assign the `ALL_PRIVILEGES` role](../../managed-mysql/operations/grant.md) for the source cluster database to that user.
1. [Assign the `REPLICATION CLIENT` and `REPLICATION SLAVE` global privileges](../../managed-mysql/operations/cluster-users.md#update-settings) to that user.

The target cluster will connect to the source cluster on behalf of this user.

### Start replication in the target cluster {#start-replica}

1. Change the target cluster's `/etc/mysql/my.cnf` configuration file to start replication:

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
   * `server_id`: Target cluster ID. The default value is `1`. However, to run replication, make sure that the values of the source and target cluster IDs are different.
   * `relay-log`: Path to the relay log.
   * `relay-log-index`: Path to the relay log index.

   Also enable `gtid-mode` and `enforce-gtid-consistency` for replication. In {{ mmy-name }} clusters, they are always activated.

1. Restart `mysql`:

    ```bash
    sudo systemctl restart mysql
    ```

1. Connect to the target cluster on behalf of the user that is granted full access rights to the database being migrated.
1. Enable replication for this database and disable replication for service databases (they are replicated by default):

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

1. To assign a master for the target cluster, specify the parameters of the source cluster's master host:

   {% include [spec-fqdn](../_tutorials_includes/special-fqdn-master-mmy.md) %}

   ```sql
   CHANGE MASTER TO
         MASTER_HOST = '<master_host_FQDN>',
         MASTER_USER = '<user_for_replication>',
         MASTER_PASSWORD = '<user_password>',
         MASTER_LOG_FILE = '<File_value_from_binary_log_position_request>',
         MASTER_LOG_POS = <Position_value_from_binary_log_position_request>,
         MASTER_SSL_CA = '<path_to_SSL_certificate>',
         MASTER_SSL_VERIFY_SERVER_CERT = 0,
         MASTER_SSL = 1;
   ```

1. Start the relay log's replication:

   ```sql
   START SLAVE;
   ```

   This starts the process of migrating data from the source cluster's database to the target cluster's database.

1. After successfully starting the replication, run this command only once:

   ```sql
   STOP SLAVE;
   CHANGE MASTER TO MASTER_AUTO_POSITION = 1;
   START SLAVE;
   ```

   This is to ensure the replication will be reconfigured to use the new master host if the master host in the source cluster changes. For more information about configurations, see this [{{ MY }} guide](https://dev.mysql.com/doc/refman/8.0/en/change-master-to.html).

### Track the migration process {#monitor-migration}

Use the command that returns the *replication status*:

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

For more information about replication status, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/replication-administration-status.html).

### Complete your migration {#finish-migration}

1. Remove the load from the source cluster and make sure that the application does not write data to the source cluster database. To do this, [update the `MAX_UPDATES_PER_HOUR` user-defined setting of the source cluster](../../managed-mysql/operations/cluster-users.md#update-settings) to `1`.
1. Wait for the `Seconds_Behind_Master` metric value to decrease to zero. This means that all changes that occurred in the source cluster after creating the logical dump are transferred to the target cluster.
1. Stop replication in the target cluster:

   ```sql
   STOP SLAVE;
   ```

1. Transfer the load to the target cluster.
1. [Remove the user](../../managed-mysql/operations/cluster-users.md#removeuser) managing replication on the source cluster.
1. Remove the user with full access rights to the migrated database on the target cluster if you no longer need this user.
