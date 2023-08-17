# Preparing for the transfer

## Preparing a source {#source}

### Airbyte® sources {#source-airbyte}

#### AWS CloudTrail source {#source-aws}

Get an AWS key ID and secret access key by following the [AWS instructions](https://docs.aws.amazon.com/powershell/latest/userguide/pstools-appendix-sign-up.html).

For more information, see the [Airbyte® documentation](https://docs.airbyte.com/integrations/sources/aws-cloudtrail/).

#### BigQuery source {#source-bigquery}

1. [Create a Google Cloud service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts).
1. [Add the service account](https://cloud.google.com/iam/docs/granting-changing-revoking-access#granting-console) as a participant to the Google Cloud project with the `BigQuery User` role.
1. [Create a Google Cloud service account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys).

For more information, see the [Airbyte® documentation](https://docs.airbyte.com/integrations/sources/bigquery).

#### Microsoft SQL Server source {#source-mssql}

1. Make sure your database can be accessed from the computer that Airbyte® is running on.
1. Create a dedicated Airbyte® user with read-only permissions and access to any tables that require replication.

For more information, see the [Airbyte® documentation](https://docs.airbyte.com/integrations/sources/mssql).

#### S3 source {#source-s3}

If you are using a private bucket as a source, grant the `read` and `list` permissions to the account you will use for connection.

For more information, see the [Airbyte® documentation](https://docs.airbyte.com/integrations/sources/s3/).

### {{ KF }} source {#source-kf}

{% list tabs %}

- {{ mkf-name }}

   [Create a user](../../managed-kafka/operations/cluster-accounts.md#create-account) with the `ACCESS_ROLE_CONSUMER` role for the source topic.

- {{ KF }}

   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. [Configure access to the source cluster from {{ yandex-cloud }}](../concepts/network.md#source-external).

   1. [Configure user access rights](https://kafka.apache.org/documentation/#multitenancy-security) to the topic you need.

   1. (Optional) To use username and password authorization, [configure SASL authentication](https://kafka.apache.org/documentation/#security_sasl).

{% endlist %}

### {{ CH }} source {#source-ch}

{% list tabs %}

* {{ mch-name }}

   1. Make sure that the transferred tables use the `MergeTree` engines. Only these tables and [materialized views]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView) will transfer.
   1. [Create a user](../../managed-clickhouse/operations/cluster-users.md) with access to the source database.

* {{ CH }}

   1. Make sure that the transferred tables use the `MergeTree` engines. Only these tables and [materialized views]({{ ch.docs }}/engines/table-engines/special/materializedview/) (MaterializedView) will transfer.
   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. [Configure access to the source cluster from {{ yandex-cloud }}](../concepts/network.md#source-external).

   1. Create a user with access to the source database.

{% endlist %}

### {{ GP }} source {#source-gp}

{% list tabs %}


- {{ mgp-name }}

   1. Create a user account the transfer will use to connect to the source. To do this, run the following command:

      ```pgsql
      CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
      ```

   1. Configure the source cluster to enable the user you created to connect to all the cluster's [master hosts](../../managed-greenplum/concepts/index.md).

   1. If you are going to use [parallel copy](../concepts/sharded.md), configure the source cluster to enable the user you created to connect to all the cluster's [segment hosts](../../managed-greenplum/concepts/index.md) in utility mode. To do this, make sure that the "Access from {{ data-transfer-name }}" setting is enabled for the cluster.

   1. Grant the user you created the `SELECT` privilege for the tables to be transferred and the `USAGE` privilege for the schemas these tables belong to.

      Privileges must be granted to entire tables. Access to certain table columns only is not supported.

      Tables without the required privileges are unavailable to {{ data-transfer-name }}. These tables are processed as if they did not exist.

      This example issues privileges to all the tables in the selected schema:

      ```pgsql
      GRANT SELECT ON ALL TABLES IN SCHEMA <schema name> TO <username>;
      GRANT USAGE ON SCHEMA <schema name> TO <username>;
      ```


- {{ GP }}

   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. Create a user account the transfer will use to connect to the source. To do this, run the following command:

      ```pgsql
      CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
      ```

   1. Configure the source cluster to enable the user you created to connect to all the cluster's [master hosts](../../managed-greenplum/concepts/index.md).

   1. If you are going to use [parallel copy](../concepts/sharded.md), configure the source cluster to enable the user you created to connect to all the cluster's [segment hosts](../../managed-greenplum/concepts/index.md) in utility mode.

   1. Grant the user you created the `SELECT` privilege for the tables to be transferred and the `USAGE` privilege for the schemas these tables belong to.

      Privileges must be granted to entire tables. Access to certain table columns only is not supported.

      Tables without the required privileges are unavailable to {{ data-transfer-name }}. These tables are processed as if they did not exist.

      This example grants privileges to all the database tables:

      ```pgsql
      GRANT SELECT ON ALL TABLES IN SCHEMA <schema name> TO <username>;
      GRANT USAGE ON SCHEMA <schema name> TO <username>;
      ```

{% endlist %}

{{ data-transfer-name }} works with {{ GP }} differently depending on the transfer configuration and the source cluster contents. Detailed information is available in the section on [{{ GP }} source endpoint settings](../operations/endpoint/source/greenplum.md).


### {{ MG }} source {#source-mg}

{% list tabs %}


- {{ mmg-name }}

   1. Estimate the total number of databases for transfer and the total {{ mmg-name }} workload. If database workload exceeds 10,000 writes per second, create several endpoints and transfers. For more information, see [{#T}](../../data-transfer/operations/endpoint/source/mongodb.md).
   1. [Create a user](../../managed-mongodb/operations/cluster-users.md#adduser) with the `readWrite` role for each source database to be replicated. The `readWrite` role is required so that a transfer can write data to the `__dt_cluster_time` service collection.


- {{ MG }}

   1. Estimate the total number of databases for transfer and the total {{ MG }} workload. If database workload exceeds 10,000 writes per second, create several endpoints and transfers. For more information, see [{#T}](../../data-transfer/operations/endpoint/source/mongodb.md).

   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. Make sure that the {{ MG }} version on the target is `4.0` or higher.

   1. [Configure access to the source cluster from {{ yandex-cloud }}](../concepts/network.md#source-external). To configure a [source cluster](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) for connections from the internet:

      1. In the configuration file, change the `net.bindIp` setting from `127.0.0.1` to `0.0.0.0`:

         ```yaml
         # network interfaces
         net:
           port: 27017
           bindIp: 0.0.0.0
         ```

      1. Restart the `mongod` service:

         ```bash
         sudo systemctl restart mongod.service
         ```

   1. If the source cluster doesn't use replication, enable replication:

      1. Add replication settings to the `/etc/mongod.conf` configuration file:

         ```yaml
         replication:
           replSetName: <replica set name>
         ```

      1. Restart the `mongod` service:

         ```bash
         sudo systemctl restart mongod.service
         ```

      1. Connect to {{ MG }} and initialize the replica set with this command:

         ```javascript
         rs.initiate({
             _id: "<replica set name>",
             members: [{
                 _id: 0,
                 host: "<IP address listening to mongod>:<port>"
             }]
         });
         ```

   1. Create a user with the [`readWrite`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-readWrite) role for all source databases to be replicated:

      ```javascript
      use admin
      db.createUser({
          user: "<username>",
          pwd: "<password>",
          mechanisms: ["SCRAM-SHA-1"],
          roles: [
              {
                  db: "<name of source database 1>",
                  role: "readWrite"
              },
              {
                  db: "<name of source database 2>",
                  role: "readWrite"
              },
              ...
          ]
      });
      ```

      Once started, the transfer will connect to the source on behalf of this user. The `readWrite` role is required so that a transfer can write data to the `__dt_cluster_time` service collection.

      {% note info %}

      For {{ MG }} 3.6 or older, it's enough to assign the created user the [`read`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-read) role for databases to replicate.

      {% endnote %}

   1. When using {{ MG }} versions 3.4 and 3.6 for a transfer, the user must have read access to the `local.oplog.rs` collection and read and write access to the `__data_transfer.__dt_cluster_time` collection. To assign a user the [`clusterAdmin`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-clusterAdmin) role granting these privileges, connect to {{ MG }} and run the following commands:

      ```js
      use admin;
      db.grantRolesToUser("<username>", ["clusterAdmin"]);
      ```

      To issue more granular privileges, you can assign the [`clusterMonitor`](https://www.mongodb.com/docs/manual/reference/built-in-roles/#mongodb-authrole-clusterMonitor) role required for read access to the `local.oplog.rs` and grant read and write access to the `__data_transfer.__dt_cluster_time` system collection.

{% endlist %}

### {{ MY }} source {#source-my}

{% list tabs %}

- {{ mmy-name }}

   1. [Enable full binary logging](../../managed-mysql/operations/update.md#change-mysql-config) on the source by setting the [**Binlog row image** parameter](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_row_image) to `FULL` or `NOBLOB`.

   1. (Optional) [Set a limit](../../managed-mysql/operations/update.md#change-mysql-config) on the size of data chunks to be sent using the **Max allowed packet** parameter.

   1. [Create a user](../../managed-mysql/operations/cluster-users.md#adduser) for connecting to the source.

      1. [Grant the user](../../managed-mysql/operations/grant.md#grant-privilege) the `ALL_PRIVILEGES` privilege for the source database.

      1. [Grant the user](../../managed-mysql/concepts/settings-list#setting-administrative-privileges) the `REPLICATION CLIENT` and `REPLICATION SLAVE` administrative privileges.

   1. {% include [primary-keys-mysql](../../_includes/data-transfer/primary-keys-mysql.md) %}

      {% note info %}

      If the creation of a primary key returns an error saying <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, [increase](../../managed-mysql/operations/update.md#change-mysql-config) the [`Innodb log file size` parameter value](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) in the DBMS settings.

      {% endnote %}

   1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ MY }} source](./endpoint/source/mysql.md#additional-settings).

- {{ MY }}

   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. Make sure the source uses the MyISAM or InnoDB low-level storage subsystem. If you use other subsystems, the transfer may fail.

   1. [Enable full binary logging](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) on the source by setting the `binlog_row_image` parameter to `FULL` or `NOBLOB`.

   1. [Specify row format for the binary log](https://dev.mysql.com/doc/refman/5.7/en/replication-options-binary-log.html#sysvar_binlog_format) on the source by setting the `binlog_format` parameter to `ROW`.

   1. If the replication source is a cluster that is behind the load balancer, enable GTID mode for it (`GTID-MODE = ON`).

      If it is not possible to enable GTID mode for any reason, make sure the binary log name template contains the host name.

      In both cases, this lets replication continue even after changing the master host.

   1. (Optional) [Set a limit](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) on the size of data chunks to be sent using the `max_allowed_packet` parameter.

   1. Create a user to connect to the source and grant them the required privileges:

      ```sql
      CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
      GRANT ALL PRIVILEGES ON <database name>.* TO '<username>'@'%';
      GRANT REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO '<username>'@'%';
      ```

   1. {% include [Tables without primary keys](../../_includes/data-transfer/primary-keys-mysql.md) %}

      {% note info %}

      If the creation of a primary key returns an error saying <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, increase the [`inno_db_log_file_size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) parameter value in the DBMS settings.

      {% endnote %}

   1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ MY }} source](./endpoint/source/mysql.md#additional-settings).

{% endlist %}

### Oracle source {#source-oracle}

{% note info %}

Some versions of Oracle use `V_$` instead of `V$` as the prefix for system objects. For example, `V_$DATABASE` instead of `V$DATABASE`.

If you get an error like "`can only select from fixed tables/views`" when granting permissions to system objects, try changing the prefixes.

{% endnote %}

{% list tabs %}

- Oracle

   * To prepare the source for the _{{ dt-type-copy }}_ transfer:

      1. Create a user account the transfer will utilize to connect to the source:

         ```sql
         CREATE USER <username> IDENTIFIED BY <password>;
         GRANT CREATE SESSION TO <username>;
         ```

      1. Grant privileges to the created user:

           ```sql
           GRANT SELECT ON V$DATABASE TO <username>;
           GRANT SELECT ON DBA_EXTENTS TO <username>;
           GRANT SELECT ON DBA_OBJECTS TO <username>;
           GRANT FLASHBACK ANY TABLE TO <username>;
           ```

           If required, you can only grant the `FLASHBACK` privileges to the tables you need to copy rather than to `ANY TABLE`.

      1. Grant the user the [privilege to read the tables](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html) to be copied.

   * To prepare the source for the _{{ dt-type-repl }}_ transfer:

      1. Create a user account the transfer will utilize to connect to the source:

           ```sql
           CREATE USER <username> IDENTIFIED BY <password>;
           ALTER USER <username> DEFAULT tablespace USERS TEMPORARY tablespace TEMP;
           ALTER USER <username> quote unlimited on USERS;

           GRANT
               CREATE SESSION,
               execute_catalog_role,
               SELECT ANY TRANSACTION,
               SELECT ANY DISCTIONARY,
               CREATE PROCEDURE,
               LOGMINING
           TO <username>;
           ```

      1. Grant privileges to the created user:

            ```sql
            GRANT SELECT ON V$DATABASE TO <username>;
            GRANT SELECT ON V$LOG TO <username>;
            GRANT SELECT ON V$LOGFILE TO <username>;
            GRANT SELECT ON V$ARCHIVED_LOG TO <username>;

            GRANT SELECT ON dba_objects TO <username>;
            GRANT SELECT ON dba_extents TO <username>;

            GRANT EXECUTE ON SYS.DBMS_LOGMNR TO <username>;
            GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO <username>;
            GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO <username>;
            GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO <username>;
            GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO <username>;
            ```

        1. Grant the user the [privilege to read the tables](https://docs.oracle.com/en/database/oracle/oracle-database/21/sqlrf/GRANT.html) to be replicated.
        1. Enable [Minimal Supplemental Logging](https://docs.oracle.com/database/121/SUTIL/GUID-D2DDD67C-E1CC-45A6-A2A7-198E4C142FA3.htm#SUTIL1583) with primary keys as follows:

            ```sql
            ALTER DATABASE ADD SUPPLEMENTAL LOG DATA (PRIMARY KEY) COLUMNS;
            ```

    * If you are using the [CDB environment](https://docs.oracle.com/database/121/CNCPT/cdbovrvw.htm#CNCPT89234), configure the following settings:

        1. Create a [user](https://docs.oracle.com/en/database/oracle/oracle-database/19/multi/overview-of-managing-a-multitenant-environment.html#GUID-7D303718-2D59-495F-90FB-E51A377B1AD2) `Common User`:

            ```sql
            CREATE USER C##<username> IDENTIFIED BY <password> CONTAINER=all;
            ALTER USER C##<username> DEFAULT TABLESPACE USERS temporary tablespace TEMP CONTAINER=all;
            ALTER USER C##<username> quota unlimited on USERS CONTAINER=all;
            ALTER USER C##<username> SET container_data = (cdb$root, <your PCB name>) CONTAINER=current;

            GRANT
                CREATE SESSION,
                execute_catalog_role,
                SELECT ANY TRANSACTION,
                SELECT ANY DICTIONALY,
                CREATE PROCEDURE,
                LOGMINING,
                SET CONTAINER
            TO C##<username> CONTAINER=ALL;
            ```

            If required, you can only specify the `cdb$root` container and the container with the tables to transfer.

        1. To allow the user to switch to the `cdb$root` container, grant them the `ALTER SESSION` privileges:

            ```sql
            GRANT ALTER SESSION TO C##<username>;
            ```

        1. Grant privileges to the created user:

            ```sql
            GRANT SELECT ON V$DATABASE TO C##<username> CONTAINER=ALL;
            GRANT SELECT ON V$LOG TO C##<username> CONTAINER=ALL;
            GRANT SELECT ON V$LOGFILE TO C##<username> CONTAINER=ALL;
            GRANT SELECT ON V$ARCHIVED_LOG TO C##<username> CONTAINER=ALL;

            GRANT SELECT ON dba_objects TO C##<username> CONTAINER=ALL;
            GRANT SELECT ON dba_extents TO C##<username> CONTAINER=ALL;

            GRANT EXECUTE ON SYS.DBMS_LOGMNR TO C##<username> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_COL$ TO C##<username> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_OBJ$ TO C##<username> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_USER$ TO C##<username> CONTAINER=ALL;
            GRANT SELECT ON SYSTEM.LOGMNR_UID$ TO C##<username> CONTAINER=ALL;
            ```

{% endlist %}

### {{ PG }} source {#source-pg}

{% note info %}

When performing a transfer from {{ PG }} to a target of any type, objects of the [large object](https://www.postgresql.org/docs/current/largeobjects.html) type will not get transferred.

Large objects in the [TOAST storage system](https://www.postgresql.org/docs/12/storage-toast.html) and those of the [bytea](https://www.postgresql.org/docs/12/datatype-binary.html) type get transferred without restrictions.

{% endnote %}

{% list tabs %}

- {{ mpg-name }}

    1. Configure the user the transfer will connect to the source under:

        1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser).

        1. For the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types, [assign the role](../../managed-postgresql/operations/grant.md#grant-role) `mdb_replication` to this user.

        1. [Connect to the database](../../managed-postgresql/operations/connect.md) that you want to migrate as the database owner and [configure privileges](../../managed-postgresql/operations/grant.md#grant-privilege):

            * `SELECT` for all the database tables to be transferred.
            * `SELECT` for all the database sequences to be transferred.
            * `USAGE` for the schemas of these tables and sequences.
            * `ALL PRIVILEGES` (`CREATE` and `USAGE`) to the `__consumer_keeper` and `__data_transfer_mole_finder` housekeeping table schema defined by the [endpoint parameter](./endpoint/source/postgresql.md#additional-settings) if the endpoint is going to be used for the _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ transfer types.

    1. If the replication source is a cluster, [enable](../../managed-postgresql/operations/extensions/cluster-extensions.md) the `pg_tm_aux` extension for it. This lets replication continue even after changing the master host. In certain cases, a transfer may return an error when you change masters in a cluster. For more information, see [Troubleshooting](../troubleshooting/index.md#master-change).

    1. {% include [Tables without primary keys](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Disable the transfer of external keys at the step of creating a source endpoint. Recreate them once the transfer is completed.

    1. Find and terminate DDL queries that are running for too long. To do this, run a `SELECT` query against the {{ PG }} `pg_stat_activity` housekeeping table:

        ```sql
        SELECT NOW() - query_start AS duration, query, state
        FROM pg_stat_activity
        WHERE state != 'idle' ORDER BY 1 DESC;
        ```

        This will return a list of queries running on the server. Check queries that have a large value for the `duration` parameter.

    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ PG }} source](./endpoint/source/postgresql.md#additional-settings).

    1. To enable parallel data reads from the table, set its primary key to [serial mode](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).

        Then specify the number of jobs and threads in the [transfer parameters](transfer.md#create) under **Runtime environment**.

- {{ PG }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Create a user account the transfer will utilize to connect to the source:

        * For the _{{ dt-type-copy }}_ transfer type, create a user with the following command:

            ```sql
            CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
            ```

      * For the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types, create a user with the `REPLICATION` privilege using this command:

         ```sql
         CREATE ROLE <username> WITH REPLICATION LOGIN ENCRYPTED PASSWORD '<password>';
         ```

   1. Grant the created user the privilege to perform a `SELECT` on all the database tables to be transferred and the `USAGE` privilege for the schemas of these tables:

      ```sql
      GRANT SELECT ON ALL TABLES IN SCHEMA <schema name> TO <username>;
      GRANT USAGE ON SCHEMA <schema name> TO <username>;
      ```

   1. Grant the created user the privileges to the `__consumer_keeper` and `__data_transfer_mole_finder` housekeeping table schema defined by the [endpoint parameter](./endpoint/source/postgresql.md#additional-settings) if the endpoint is going to be used for the _{{ dt-type-repl }}_ or _{{ dt-type-copy-repl }}_ transfer types.

      ```sql
      GRANT ALL PRIVILEGES ON SCHEMA <schema name> TO <username>;
      ```

   1. Install and enable the [wal2json](https://github.com/eulerto/wal2json) extension.

      **Installation**

      * Linux

         1. Add the [{{ PG }} official repository](https://www.postgresql.org/download/) for your distribution.
         1. Update the list of available packages and install the `wal2json` package for the active version of {{ PG }}:

      * Windows 10, 11

         1. If you don't have Microsoft Visual Studio installed yet, download and install it. To build the wal2json extension, the [Community Edition](https://visualstudio.microsoft.com/vs/community/) is sufficient. During installation, select the following components:

            * MSBuild,
            * MSVC v141 x86/x64 build tools,
            * C++\CLI support for v141 build tools,
            * MSVC v141 — VS 2017 C++ x64\x86 build tools,
            * MSVC v141 — VS 2017 C++ x64\x86 Spectre-mitigated libs,
            * The latest version of the Windows SDK for the active OS version.
            * Other dependencies that are installed automatically for selected components.

            Take note of the version number of the installed Windows SDK. You will need it when you are asked to specify the wal2json build parameters.

         1. Download the wal2json source code from the [project page](https://github.com/eulerto/wal2json/releases).
         1. Unpack the archive with the source code to the `C:\wal2json\` folder.
         1. Go to `C:\wal2json`.
         1. In one PowerShell session, make changes to the `wal2json.vcxproj` file:

            * Replace the lines `C:\postgres\pg103` with the path to the installed {{ PG }} version, for example:

               ```powershell
               (Get-Content .\wal2json.vcxproj).replace('C:\postgres\pg103', 'C:\PostgreSQL\14') | `
                Set-Content .\wal2json.vcxproj
               ```

            * Replace the `/MP` extension parameter to `/MT`, for example:

               ```powershell
               (Get-Content .\wal2json.vcxproj).replace('/MP', '/MT') | Set-Content .\wal2json.vcxproj
               ```

            * Specify the version number of the installed Windows SDK in `<WindowsTargetPlatformVersion>`:

               ```powershell
               (Get-Content .\wal2json.vcxproj).replace('<WindowsTargetPlatformVersion>8.1', '<WindowsTargetPlatformVersion><installed version of Windows SDK>') | `
                Set-Content .\wal2json.vcxproj
               ```

            1. Enter the value of the extension variable required for building wal2json. For example, for Visual Studio Community Edition 2022:

               ```powershell
               $VCTargetsPath='C:\Program Files\Microsoft Visual Studio\2022\Comminuty\MSBuild\Microsoft\VC\v150'
               ```

            1. Run the build:

               ```powershell
               & 'C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe' /p:Configuration=Release /p:Platform=x64
               ```

            1. Copy `wal2json.dll` from the `build/release` folder to the `lib` folder of the installed {{ PG }} version.

      {% endlist %}

      **Configuration**

      1. In the `postgresql.conf` file, change the value of the `wal_level` parameter to `logical`:

         ```conf
         wal_level = logical
         ```

      1. Restart PostgreSQL.

   1. If the replication source is a cluster, install and enable the [pg_tm_aux](https://github.com/x4m/pg_tm_aux) extension on its hosts. This lets replication continue even after changing the master host. In certain cases, a transfer may return an error when you change masters in a cluster. For more information, see [Troubleshooting](../troubleshooting/index.md#master-change).

   1. {% include [Tables without primary keys](../../_includes/data-transfer/primary-keys-postgresql.md) %}

   1. Disable the transfer of external keys at the step of creating a source endpoint. Recreate them once the transfer is completed.

   1. Find and terminate DDL queries that are running for too long. To do this, run a `SELECT` query against the {{ PG }} `pg_stat_activity` housekeeping table:

      ```sql
      SELECT NOW() - query_start AS duration, query, state
      FROM pg_stat_activity
      WHERE state != 'idle' ORDER BY 1 DESC;
      ```

      This will return a list of queries running on the server. Check queries that have a large value for the `duration` parameter.

   1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ PG }} source](./endpoint/source/postgresql.md#additional-settings).

   1. To enable parallel data reads from the table, set its primary key to [serial mode](https://www.postgresql.org/docs/current/datatype-numeric.html#DATATYPE-SERIAL).

      Then specify the number of jobs and threads in the [transfer parameters](transfer.md#create) under **Runtime environment**.

   1. If replication via [Patroni](https://github.com/zalando/patroni) is configured on the source, add an [ignore_slots](https://patroni.readthedocs.io/en/latest/SETTINGS.html?highlight=ignore_slots#dynamic-configuration-settings) block to the source configuration:

      ```yaml
      ignore_slots:
        - database: <name of database that the transfer is configured for>
          name: <replication slot name>
          plugin: wal2json
          type: logical
      ```

      The database and the replication slot names must match the values specified in the [source endpoint settings](../../data-transfer/operations/endpoint/source/postgresql.md). By default, the `replication slot name` is the same as the `transfer ID`.

      Otherwise, the start of the replication phase will fail:

      ```
      Warn(Termination): unable to create new pg source: Replication slotID <replication slot name> does not exist.
      ```

{% endlist %}

{% note info %}

For things to note about data transfer from {{ PG }} to {{ CH }} using _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfers, see [Asynchronously replicating data from {{ PG }} to {{ CH }}](../tutorials/rdbms-to-clickhouse.md).

{% endnote %}


### {{ yds-full-name }} source {#source-yds}

1. [Create a service account](../../iam/operations/sa/create.md) with the `yds.editor` role.
1. [Create a data stream](../../data-streams/operations/manage-streams.md#create-data-stream).
1. (Optional) [Create a processing function](../../functions/operations/function/function-create.md).

   {% cut "Processing function example" %}

   ```javascript
   const yc = require("yandex-cloud");
   const { Parser } = require("@robojones/nginx-log-parser");
   module.exports.handler = async function (event, context) {
       const schema =
           '$remote_addr - $remote_user [$time_local] "$request" $status $bytes_sent "$http_referer" "$http_user_agent"';
       const parser = new Parser(schema);
       return {
           Records: event.Records.map((record) => {
               const decodedData = new Buffer(record.kinesis.data, "base64")
                   .toString("ascii")
                   .trim();
               try {
                   const result = parser.parseLine(decodedData);
                   if (result.request == "") {
                       // empty request - drop message
                       return {
                           eventID: record.eventID,
                           invokeIdentityArn: record.invokeIdentityArn,
                           eventVersion: record.eventVersion,
                           eventName: record.eventName,
                           eventSourceARN: record.eventSourceARN,
                           result: "Dropped"
                       };
                   }
                   return {
                       // successfully parsed message
                       eventID: record.eventID,
                       invokeIdentityArn: record.invokeIdentityArn,
                       eventVersion: record.eventVersion,
                       eventName: record.eventName,
                       eventSourceARN: record.eventSourceARN,
                       kinesis: {
                           data: new Buffer(JSON.stringify(result)).toString(
                               "base64"
                           ),
                       },
                       result: "Ok"
                   };
               } catch (err) {
                   // error - fail message
                   return {
                       eventID: record.eventID,
                       invokeIdentityArn: record.invokeIdentityArn,
                       eventVersion: record.eventVersion,
                       eventName: record.eventName,
                       eventSourceARN: record.eventSourceARN,
                       result: "ProcessingFailed",
                   };
               }
           })
       };
   };
   ```

   {% endcut %}

1. (Optional) Prepare a data schema file in JSON format.

   Sample file with a data schema:

   ```json
   [
       {
           "name": "<field name>",
           "type": "<type>"
       },
       ...
       {
           "name": "<field name>",
           "type": "<type>"
       }
   ]
   ```

   Supported types:

   * `any`
   * `boolean`
   * `datetime`
   * `double`
   * `int8`
   * `int16`
   * `int32`
   * `int64`
   * `string`
   * `uint8`
   * `uint16`
   * `uint32`
   * `uint64`
   * `utf8`


## Preparing a target {#target}

### {{ CH }} target {#target-ch}

{% list tabs %}

- {{ mch-name }}

   1. [Create a target database](../../managed-clickhouse/operations/databases.md#add-db).

      Its name must be the same as the source database name. If you need to transfer multiple databases, create a separate transfer for each of them.

   1. [Create a user](../../managed-clickhouse/operations/cluster-users.md#adduser) with access to the target database.

      Once started, the transfer will connect to the target on behalf of this user.

- {{ CH }}

   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. Create a target database. Its name must be the same as the source database name. If you need to transfer multiple databases, create a separate transfer for each of them.

   1. Create a user with access to the target database.

      Once started, the transfer will connect to the target on behalf of this user.

{% endlist %}

### {{ ES }} target {#target-es}

{% list tabs %}


- {{ mes-name }}

   {% include [prepare-es](../../_includes/data-transfer/prepare-es.md) %}


- {{ ES }}

   * {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   {% include [prepare-es](../../_includes/data-transfer/prepare-es.md) %}

{% endlist %}

### {{ GP }} target {#target-gp}

{% list tabs %}


- {{ mgp-name }}

   1. Disable the following settings on the target:

        * Integrity checks for foreign keys.
        * Triggers.
        * Other constraints.

      {% note warning %}

      Do not reactivate these settings before the transfer is complete. This will ensure data integrity with respect to foreign keys.

      {% endnote %}

   1. Create a user:

      ```sql
      CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
      ```

   1. Grant the user all privileges for the database, schemas, and tables to be transferred:

      ```sql
      GRANT ALL PRIVILEGES ON DATABASE <database name> TO <username>;
      ```

      If the database is not empty, the user must be its owner:

      ```sql
      ALTER DATABASE <database name> OWNER TO <username>;
      ```

      Once started, the transfer will connect to the target on behalf of this user.


- {{ GP }}

   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. Disable the following settings on the target:

      * Integrity checks for foreign keys.
      * Triggers.
      * Other constraints.

      {% note warning %}

      Do not reactivate these settings before the transfer is complete. This will ensure data integrity with respect to foreign keys.

      {% endnote %}

   1. Create a user:

      ```sql
      CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
      ```

   1. Grant the user all privileges for the database, schemas, and tables to be transferred:

      ```sql
      GRANT ALL PRIVILEGES ON DATABASE <database name> TO <username>;
      ```

      If the database is not empty, the user must be its owner:

      ```sql
      ALTER DATABASE <database name> OWNER TO <username>;
      ```

      Once started, the transfer will connect to the target on behalf of this user.

{% endlist %}


### {{ MG }} target {#target-mg}

{% list tabs %}


- {{ mmg-name }}

   1. [Create a database](../../managed-mongodb/operations/databases.md#add-db) a with the same name as the source database.
   1. [Create a user](../../managed-mongodb/operations/cluster-users.md#adduser) with the [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) role for the created database.
   1. To shard migrating collections in the {{ mmg-full-name }} target cluster:
      1. Following the [instructions](../../managed-mongodb/tutorials/sharding.md), in the target database, create and configure blank sharded collections with the same names as in the source one.

         {{ data-transfer-name }} doesn't automatically shard migrating collections. Sharding large collections may take a long time and slow down the transfer.

      1. If sharding is performed by any key other than the default `_id`, [assign the user](../../managed-mongodb/operations/cluster-users.md#updateuser) the `mdbShardingManager` role.

      1. When [creating a target endpoint](./endpoint/target/mongodb.md), select the `DISABLED` or `TRUNCATE` clean policy.

         {% include [MongoDB endpoint DROP clean policy warning](../../_includes/data-transfer/note-mongodb-clean-policy.md) %}

      Learn more about sharding in the [{{ MG }} documentation](https://docs.mongodb.com/manual/sharding/).


- {{ MG }}

   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. Make sure that the {{ MG }} version on the target is not lower than that on the source.

   1. [Configure the target cluster](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) to allow connections from the internet:

      1. In the configuration file, change the `net.bindIp` setting from `127.0.0.1` to `0.0.0.0`:

         ```yaml
         # network interfaces
         net:
           port: 27017
           bindIp: 0.0.0.0
         ```

      1. Restart the `mongod` service:

         ```bash
         sudo systemctl restart mongod.service
         ```

   1. If the target cluster doesn't use replication, enable replication:

      1. Add replication settings to the `/etc/mongod.conf` configuration file:

         ```yaml
         replication:
           replSetName: <replica set name>
         ```

      1. Restart the `mongod` service:

         ```bash
         sudo systemctl restart mongod.service
         ```

      1. Connect to {{ MG }} and initialize the replica set with this command:

         ```javascript
         rs.initiate({
             _id: "<replica set name>",
             members: [{
                 _id: 0,
                 host: "<IP address listening to mongod>:<port>"
             }]
         });
         ```

   1. Connect to the cluster and create a target database with the same name as the source database:

      ```javascript
      use <database name>
      ```

   1. Create a user with the `readWrite` role for the target database:

      ```javascript
      use admin;
      db.createUser({
          user: "<username>",
          pwd: "<password>",
          mechanisms: ["SCRAM-SHA-1"],
          roles: [
              {
                  db: "<target database name>",
                  role: "readWrite"
              }
          ]
      });
      ```

      Once started, the transfer will connect to the target on behalf of this user.

   1. To shard collections being migrated in the target cluster:

      1. Prepare the database and create blank collections with the same names as in the source database.

         {{ data-transfer-name }} doesn't automatically shard migrating collections. Sharding large collections may take a long time and slow down the transfer.

      1. Enable target database sharding:

         ```javascript
         sh.enableSharding("<target database name>")
         ```

      1. Shard every collection based on its namespace:

         ```javascript
         sh.shardCollection("<target database name>.<collection name>", { <field name>: <1|"hashed">, ... });
         ```

         For more information about the `shardCollection()` function, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/sh.shardCollection/#mongodb-method-sh.shardCollection).

      1. To verify that sharding is set up and enabled, get a list of available shards:

         ```javascript
         sh.status()
         ```

      1. If sharding is performed by any key other than the default `_id`, assign the `clusterManager` system role to the user that {{ data-transfer-name }} will connect to the target cluster as.

         ```javascript
         use admin;
         db.grantRolesToUser("<username>", ["clusterManager"]);
         ```

      1. When [creating a target endpoint](./endpoint/target/mongodb.md), select the `DISABLED` or `TRUNCATE` clean policy.

         {% include [MongoDB endpoint DROP clean policy warning](../../_includes/data-transfer/note-mongodb-clean-policy.md) %}

      Learn more about sharding in the [{{ MG }} documentation](https://docs.mongodb.com/basics/sharding/).

{% endlist %}

### {{ MY }} target {#target-my}

{% list tabs %}

- {{ mmy-name }}

   1. Make sure that the major version of {{ MY }} on the target is not lower than that on the source.

   1. [Set SQL Mode](../../managed-mysql/operations/update.md#change-mysql-config), which matches the source.

   1. [Create a user](../../managed-mysql/operations/cluster-users.md#adduser) for connecting to the source.

      1. [Assign the user](../../managed-mysql/operations/grant.md#grant-role)the `ALL_PRIVILEGES` role for the source database.

- {{ MY }}

   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. Make sure that the major version of {{ MY }} on the target is not lower than that on the source.

   1. Make sure the target uses the MyISAM or InnoDB low-level storage subsystem.

   1. [Set SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting), which matches the source.

   1. Create a user to connect to the target and grant them the required privileges:

      ```sql
      CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
      GRANT ALL PRIVILEGES ON <database name>.* TO '<username>'@'%';
      ```

{% endlist %}

### {{ objstorage-full-name }} target {#target-storage}


1. [Create a bucket](../../storage/operations/buckets/create.md) in the desired configuration.
1. [Create a service account](../../iam/operations/sa/create.md) with the `storage.uploader` role.


### {{ OS }} target {#target-os}

{% list tabs %}


- {{ mos-name }}

   {% include [prepare-os](../../_includes/data-transfer/prepare-os.md) %}


- {{ OS }}

   * {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   {% include [prepare-os](../../_includes/data-transfer/prepare-os.md) %}

{% endlist %}

### {{ PG }} target {#target-pg}

{% list tabs %}

- {{ mpg-name }}

   1. Make sure that the major version of {{ PG }} on the target is not lower than that on the source.

   1. Disable the following settings on the target:

        * Integrity checks for foreign keys.
        * Triggers.
        * Other constraints.

      {% note warning %}

      Do not reactivate these settings before the transfer is complete. This will ensure data integrity with respect to foreign keys.

      If you use the _{{ dt-type-copy-repl }}_ transfer type, you can enable the settings again after the [copy stage](../concepts/transfer-lifecycle.md#copy-and-replication) is completed.

      {% endnote %}

   1. In the target database, [enable the same extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) that are enabled in the source database.

   1. Make sure the target has the `DROP transfer tables` cleanup policy selected.

   1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser) with access to the target database.

   1. Grant the user all privileges for the database, schemas, and tables to be transferred:

      ```sql
      GRANT ALL PRIVILEGES ON DATABASE <database name> TO <username>;
      ```

      If the database is not empty, the user must be its owner:

      ```sql
      ALTER DATABASE <database name> OWNER TO <username>;
      ```

      Once started, the transfer will connect to the target on behalf of this user.
   1. If the target has the [Save transaction boundaries](endpoint/target/postgresql.md#additional-settings) option enabled, grant the created user all privileges to create the `__data_transfer_lsn` housekeeping table in the [current schema](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (usually it's `public`) on the target:

      ```sql
      GRANT ALL PRIVILEGES ON SCHEMA <schema name> TO <username>;
      ```

- {{ PG }}

   1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

   1. Make sure that the major version of {{ PG }} on the target is not lower than that on the source.

   1. Disable the following settings on the target:

      * Integrity checks for foreign keys.
      * Triggers.
      * Other constraints.

      {% note warning %}

      Do not reactivate these settings before the transfer is complete. This will ensure data integrity with respect to foreign keys.

      If you use the _{{ dt-type-copy-repl }}_ transfer type, you can enable the settings again after the [copy stage](../concepts/transfer-lifecycle.md#copy-and-replication) is completed.

      {% endnote %}

   1. In the target database, enable the same extensions that are enabled in the source database.

   1. Make sure the target has the `DROP transfer tables` cleanup policy selected.

   1. Create a user:

      ```sql
      CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
      ```

   1. Grant the user all privileges for the database, schemas, and tables to be transferred:

      ```sql
      GRANT ALL PRIVILEGES ON DATABASE <database name> TO <username>;
      ```

      If the database is not empty, the user must be its owner:

      ```sql
      ALTER DATABASE <database name> OWNER TO <username>;
      ```

      Once started, the transfer will connect to the target on behalf of this user.

   1. If the target has the [Save transaction boundaries](endpoint/target/postgresql.md#additional-settings) option enabled, grant the created user all privileges to create the `__data_transfer_lsn` housekeeping table in the [current schema](https://www.postgresql.org/docs/current/ddl-schemas.html#DDL-SCHEMAS-PATH) (usually it's `public`) on the target:

      ```sql
      GRANT ALL PRIVILEGES ON SCHEMA <schema name> TO <username>;
      ```

{% endlist %}

The service does not transfer `MATERIALIZED VIEWS`. For more information, see [Service specifics for sources and targets](../concepts/index.md#postgresql).


### {{ ydb-full-name }} target {#target-ydb}


[Create a service account](../../iam/operations/sa/create.md) with the `ydb.editor` role.


{% include [airbyte-trademark](../../_includes/data-transfer/airbyte-trademark.md) %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

