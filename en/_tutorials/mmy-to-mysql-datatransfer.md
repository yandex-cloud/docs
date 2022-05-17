To migrate a database deployed in a {{ mmy-name }} cluster to a third-party {{ MY }} cluster:

1. Transfer data.
1. Disable data writes to the source database.
1. Switch over the load to a third-party cluster.

Migration across versions is supported. For example, you can move databases from {{ MY }} ver. 5.7 to ver. 8. The {{ MY }} major version on a third-party cluster must be equal to or higher than the version in the {{ mmy-name }} cluster.

There are two ways to migrate data from a {{ mmy-name }} _source cluster_ to a third-party {{ MY }} _target cluster_:

* [Transferring data using {{ data-transfer-full-name }}](#data-transfer).

    This method lets you migrate the entire database without interrupting user service.

    For more information, see [{#T}](../data-transfer/concepts/use-cases.md).

* [Transferring data using external replication](#binlog-replication).

    [_External replication_](https://dev.mysql.com/doc/refman/8.0/en/replication-configuration.html) lets you migrate databases across {{ MY }} clusters using built-in DBMS tools.

    Use this method only if, for some reason, it's not possible to migrate data using {{ data-transfer-full-name }}.

## Before you start {#before-you-begin}

Prepare the target cluster:

* [Create a {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/creating-database.html) database with any suitable configuration.
* Make sure that you can connect to the target cluster hosts from the internet.

Additionally, to migrate data using external {{ MY }} replication:

* Make sure that all the source cluster's hosts are accessible by a public IP address so that the target cluster can connect to the source. To do this:
   * [Add hosts](../managed-mysql/operations/hosts.md#add) with public IP addresses.
   * [Delete hosts](../managed-mysql/operations/hosts.md#remove) without public IP addresses.
* Install [{{ mmy-name }} server SSL certificates](../managed-mysql/operations/connect.md#get-ssl-cert) on the hosts of the target cluster. They're required to connect to the source cluster that is publicly available.
* If necessary, configure the firewall and [security groups](../managed-mysql/operations/connect.md#configuring-security-groups) to be able to connect from the target cluster to the source cluster and to each cluster separately (for example, using the [mysql utility](https://dev.mysql.com/doc/refman/8.0/en/mysql.html)).
* Make sure that you can connect to the source cluster's hosts from the target cluster's hosts.
* Make sure you can [connect to the source cluster](../managed-mysql/operations/connect.md) and the target cluster using SSL.

## Transferring data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster database](../data-transfer/operations/prepare.md#source-my).

1. [Prepare the target cluster database](../data-transfer/operations/prepare.md#target-my).

1. [Create a source endpoint](../data-transfer/operations/source-endpoint.md#create-endpoint):

    * **Database type**: `{{ MY }}`.
    * **Connection settings**: `MDB cluster`.
        Specify the source cluster ID.

1. [Create a target endpoint](../data-transfer/operations/target-endpoint.md#create-endpoint):

    * **Database type**: `{{ MY }}`.
    * **Connection settings**: `Custom installation`.
        Specify the target cluster connection settings.

1. [Create a transfer](../data-transfer/operations/transfer.md#create) of the _{{ dt-type-copy-repl }}_ type that will use the created endpoints.

1. [Activate](../data-transfer/operations/transfer.md#activate) it.

    {% note warning %}

    Avoid any changes to the data schema in the source and target clusters during the transfer operation. For more information, see [{#T}](../data-transfer/operations/db-actions.md).

    {% endnote %}

1. Wait for the transfer to change to the **Replicated** status.

1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.

1. On the [transfer monitoring](../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery, [s]** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.

1. [Deactivate](../data-transfer/operations/transfer.md#deactivate) the transfer and wait for its status to change to **Stopped**.

    To learn more about the transfer lifecycle, see the [{{ data-transfer-full-name }} documentation](../data-transfer/concepts/transfer-lifecycle.md).

1. [Delete](../data-transfer/operations/transfer.md#delete) the stopped transfer.

1. [Delete the endpoint for the source](../data-transfer/operations/source-endpoint.md#delete-endpoint).

1. [Delete the endpoint for the target](../data-transfer/operations/target-endpoint.md#delete-endpoint).

## Transferring data using external replication {#binlog-replication}

1. [Transfer a logical dump of the database](#migrate-schema).
1. [Configure the user in the source cluster to manage replication](#configure-user).
1. [Start replication in the target cluster](#start-replica).
1. [Monitor the migration process](#monitor-migration) until it is completed.
1. [Finish the migration](#finish-migration).

### Transfer a logical dump of the database {#migrate-schema}

_A logical dump_ is a file with a set of commands running which one by one you can restore the state of a database. You can create it using [mysqldump](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html). To ensure that a logical dump is complete, pause data writes to the database before creating it.

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

    Write down the `File` and `Position` values. You'll need them when you start replication.

1. Create a dump of the source cluster database:

   ```bash
   mysqldump \
       --databases=<DB name> \
       --routines \
       --host=<master host FQDN> \
       --ssl-ca=<path to the SSL certificate> \
       --user=<DB owner username> > <dump file>
   ```

   {% include [spec-fqdn](_tutorials_includes/special-fqdn-master-mmy.md) %}

1. Restore the database from the dump on the target cluster:

    {% list tabs %}

    * Connecting via SSL

       ```bash
       mysql --host=<master host FQDN> \
             --user=<username> \
             --password \
             --port=3306 \
             --ssl-ca=<certificate file path> \
             --ssl-mode=VERIFY_IDENTITY \
             --line-numbers \
             <DB name> < <dump file>
       ```

    * Connecting without using SSL

       ```bash
       mysql --host=<master host FQDN> \
             --user=<username> \
             --password \
             --port=3306 \
             --line-numbers \
             <DB name> < <dump file>
       ```

    {% endlist %}

1. Create a user with full access rights to the database being migrated in the target cluster:

   ```sql
   CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
   GRANT ALL PRIVILEGES ON <database name>.* TO '<username>'@'%';
   ```

### Configure the user in the source cluster to manage replication {#configure-user}

{{ MY }} uses the <q>master-replica</q> model when performing replication: the target cluster replicates the changes of the source cluster's binary log to its relay log. The host replica reproduces the changes from the relay log applying them to its own data.

To get binary log changes and manage the replication flow in the source cluster:

1. [Create a user](../managed-mysql/operations/cluster-users.md#adduser).
1. [Assign the role]( ../managed-mysql/operations/grant.md) `ALL_PRIVILEGES` to this user for the source cluster database.
1. [Assign the global privileges](../managed-mysql/operations/cluster-users.md#update-settings) `REPLICATION CLIENT` and `REPLICATION SLAVE` to this user.

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
   * `log_bin` is the name of the binary log in the target cluster.
   * `server_id` is the target cluster ID. The default value is `1`. However, to run replication, make sure that the values of the source and target cluster IDs differ.
   * `relay-log` is the path to the relay log.
   * `relay-log-index` is the path to the relay log index.

   In addition, enable the `gtid-mode` and `enforce-gtid-consistency` options to prepare for replication. In {{ mmy-name }} clusters, they are always activated.

1. Restart the `mysql` service:

    ```bash
    sudo systemctl restart mysql
    ```

1. Connect to the target cluster on behalf of the user that is granted full access rights to the database being migrated.

1. Enable replication for this database and disable replication for service databases (they are replicated by default):

   ```sql
   CHANGE REPLICATION FILTER
       REPLICATE_DO_DB=(
           <target cluster DB name>
       ),
       REPLICATE_IGNORE_DB=(
           sys,
           mysql,
           performance_schema,
           information_schema
       );
   ```

1. To assign a master for the target cluster, specify the parameters of the source cluster's master host:

   {% include [spec-fqdn](_tutorials_includes/special-fqdn-master-mmy.md) %}

   ```sql
   CHANGE MASTER TO
         MASTER_HOST = '<master host FQDN>',
         MASTER_USER = '<user for managing replication>',
         MASTER_PASSWORD = '<user password>',
         MASTER_LOG_FILE = '<File value from the binary log position request>',
         MASTER_LOG_POS = <Position value from the binary log position request>,
         MASTER_SSL_CA = '<path to the SSL certificate>',
         MASTER_SSL_VERIFY_SERVER_CERT = 0,
         MASTER_SSL = 1;
   ```

1. Start the relay log's replication:

   ```sql
   START SLAVE;
   ```

This starts the process of migrating data from the source cluster's database to the target cluster's database.

### Track the migration process {#monitor-migration}

Use the command that returns the *replication status*:

```sql
SHOW SLAVE STATUS\G
```

```text
*************************** 1. row ***************************
           Slave_IO_State: Waiting for master to send event
              Master_Host: rc1a-hxk9audl2lsi53hc.mdb.yandexcloud.net
              Master_User: replica-my
              Master_Port: 3306
            Connect_Retry: 60
          Master_Log_File: mysql-bin-log-rc1a-hxk9audl2lsi53hc-mdb-yandexcloud-net.000225
      Read_Master_Log_Pos: 1702815
           Relay_Log_File: 6b6d647a39b6-relay-bin.000084
            Relay_Log_Pos: 409
            ...
```

The replication status is shown by the values of the fields:

* `Slave_IO_State` and `Slave_SQL_Running_State` that indicate the I/O state of the binary log and relay log streams. If replication is successful, both streams are active.
* `Read_Master_Log_Pos` is the last position read from the master host log.
* `Seconds_Behind_Master` is the replica's lag behind the master host (in seconds).
* `Last_IO_Error` and `Last_SQL_Error` are replication errors.

For more information about the replication status, see the [documentation for {{ MY }}](https://dev.mysql.com/doc/refman/8.0/en/replication-administration-status.html).

### Finish the migration {#finish-migration}

To complete the migration:

1. Remove the load from the source cluster and check that the application doesn't write data to the source cluster database. To do this, [change the user-defined setting of the source cluster](../managed-mysql/operations/cluster-users.md#update-settings) `MAX_UPDATES_PER_HOUR` to `1`.

1. Wait for the `Seconds_Behind_Master` metric value to decrease to zero. This means that all changes that occurred in the source cluster after creating the logical dump are transferred to the target cluster.

1. Stop replication in the target cluster:

   ```sql
   STOP SLAVE;
   ```

1. Switch over the load to the target cluster.

1. [Remove the user](../managed-mysql/operations/cluster-users.md#removeuser) managing replication on the source cluster.

1. Remove the user with full access rights to the migrated database on the target cluster if you no longer need this user.
