# Preparing for the transfer

## Preparing a source {#source}

### {{ KF }} source {#source-kf}

{% list tabs %}

- {{ mkf-name }}

    [Create an account](../../managed-kafka/operations/cluster-accounts.md#create-account) with the `ACCESS_ROLE_CONSUMER` role for the source topic.

- {{ KF }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Set up the source cluster so that you can connect to it from the internet.

    1. [Configure access rights](https://kafka.apache.org/documentation/#multitenancy-security) to the desired topic for the account.

    1. (Optional) To use username and password authorization, [configure SASL authentication](https://kafka.apache.org/documentation/#security_sasl).

{% endlist %}

### {{ GP }} source {#source-gp}

{% list tabs %}

- {{ GP }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Create the user that the transfer will connect to the source as, by running the command:

        ```pgsql
        CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
        ```

    1. Configure the source cluster so that the created user can connect to all master hosts and all segment hosts of the cluster.

        Segment hosts are accessed in the utility mode without the need to interact with the master hosts.

    1. Grant the created user the privilege to perform a `SELECT` on all the database tables to be transferred and the `USAGE` privilege for the schemas of these tables.

        Privileges must be granted for entire tables, accessing only certain columns is not supported.

        You can grant privileges only for a limited set of tables. For this, list all tables to be transferred in the [additional settings](./endpoint/source/greenplum.md#additional-settings) of the source endpoint {{ GP }}.

        In this example, the privilege commands are issued for all database tables:

        ```pgsql
        GRANT SELECT ON ALL TABLES IN SCHEMA <schema name> TO <username>;
       GRANT USAGE ON SCHEMA <schema name> TO <username>;
        ```

    1. Grant the created user the privileges to access the schema that will host the [transfer's service objects](./endpoint/source/greenplum.md#additional-settings). These include privileges to create and use functions in the schema.

        To do this, run the command:

        ```pgsql
        GRANT USAGE ON SCHEMA <service schema name> TO <username>;
        GRANT CREATE ON SCHEMA <service schema name> TO <username>;
        GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA <service schema name> TO <username>;
        GRANT SELECT ON ALL TABLES IN SCHEMA <service schema name> TO <username>;
        ```

{% endlist %}

### {{ CH }} source {#source-ch}

{% list tabs %}

- {{ mch-name }}
    1. Make sure that the transferred tables use the `MergeTree` engines. Only these tables and [MaterializedViews]{% if lang == "ru" %}(https://clickhouse.tech/docs/ru/engines/table-engines/special/materializedview/){% endif %}{% if lang == "en" %}(https://clickhouse.tech/docs/en/engines/table-engines/special/materializedview/){% endif %} will be transferred.
    1. [Create a user](../../managed-clickhouse/operations/cluster-users.md) with access to the source database.

- {{ CH }}

    1. Make sure that the transferred tables use the `MergeTree` engines. Only these tables and [MaterializedViews]{% if lang == "ru" %}(https://clickhouse.tech/docs/ru/engines/table-engines/special/materializedview/){% endif %}{% if lang == "en" %}(https://clickhouse.tech/docs/en/engines/table-engines/special/materializedview/){% endif %} (MaterializedView) will be transferred.

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Set up the source cluster so that you can connect to it from the internet.
    1. Make sure that the transferred tables use the `MergeTree` engines. Only these tables and [MaterializedViews](https://clickhouse.tech/docs/en/engines/table-engines/special/materializedview/) will be transferred.
    1. Create a user with access to the source database.

{% endlist %}

### {{ MG }} source {#source-mg}

{% list tabs %}

- {{ mmg-name }}
    1. Estimate the total number of databases for transfer and the total {{ mmg-name }} workload. If the workload on the database exceeds 10000 writes per second, create several endpoints and transfers. For more information, see [{#T}](../../data-transfer/operations/endpoint/source/mongodb.md).
    1. [Create a user](../../managed-mongodb/operations/cluster-users.md#adduser) with the `readWrite` role for the source database.

- {{ MG }}

    1. Estimate the total number of databases for transfer and the total {{ MG }} workload. If the workload on the database exceeds 10000 writes per second, create several endpoints and transfers. For more information, see [{#T}](../../data-transfer/operations/endpoint/source/mongodb.md).

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Make sure that the version of {{ MG }} on the target is `4.0` or higher.

    1. [Configure the source cluster](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) so that you can connect to it from the internet:

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

        1. Connect to {{ MG }} and initialize the replica set with the command:

            ```javascript
            rs.initiate({
                _id: "<replica set name>",
                members: [{
                    _id: 0,
                    host: "<IP address listening to mongod>:<port>"
                }]
            });
            ```

    1. Create a user with the role `readWrite` for the source database:

        ```javascript
        use admin
        db.createUser({
            user: "<username>",
            pwd: "<password>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<name of source database>",
                    role: "readWrite"
                }
            ]
        });
        ```

        Once started, the transfer will connect to the source on behalf of this user.

    1. When using {{ MG }} 3.4 and 3.6, to run transfer, the user must have rights to read the `local.oplog.rs` collection. To assign a user the `clusterManager` role, which grants these rights, connect to {{ MG }} and run the following commands:

        ```js
        use admin;
        db.grantRolesToUser("<username>", ["clusterManager"]);
        ```

{% endlist %}

### {{ MY }} source {#source-my}

{% list tabs %}

- {{ mmy-name }}

    1. [Enable full binary logging](../../managed-mysql/operations/update.md#change-mysql-config) on the source using the **Binlog row image** parameter.

    1. (Optional) [Set a limit](../../managed-mysql/operations/update.md#change-mysql-config) on the size of data chunks to be sent using the **Max allowed packet** parameter.

    1. [Create a user](../../managed-mysql/operations/cluster-users.md#adduser) for connecting to the source.

        1. [Assign the user](../../managed-mysql/operations/grant.md#grant-role) the `ALL_PRIVILEGES` role for the source database.

        1. [Grant the user](../../managed-mysql/operations/grant.md#grant-privilege) the `REPLICATION CLIENT` and `REPLICATION SLAVE` privileges.

    1. {% include [primary-keys-mysql](../../_includes/data-transfer/primary-keys-mysql.md) %}

        {% note info %}

        If the creation of a primary key returns the error <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, [update the DBMS settings](../../managed-mysql/operations/update.md#change-mysql-config) by increasing the value of the [`Innodb log file size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) parameter.

        {% endnote %}

    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ MY }} source](./endpoint/source/mysql.md#additional-settings).

- {{ MY }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}
    1. Make sure the source uses the MyISAM or InnoDB low-level storage subsystem. If you use other subsystems, the transfer may fail.

    1. [Enable full binary logging](https://dev.mysql.com/doc/refman/8.0/en/replication-options-binary-log.html#sysvar_binlog_row_image) on the source using the `binlog_row_image` parameter.

    1. If the replication source is a cluster that is behind the load balancer, enable GTID mode for it (`GTID-MODE = ON`).

        If for some reason it's not possible to enable GTID mode, make sure the binary log name template contains the host name.

        In both cases, this lets replication continue even after changing the master host.

    1. (Optional) [Set a limit](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_max_allowed_packet) on the size of data chunks to be sent using the `max_allowed_packet` parameter.

    1. Create a user to connect to the source and grant them the necessary privileges:

        ```sql
       CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
        GRANT ALL PRIVILEGES ON <database name>.* TO '<username>'@'%';
        GRANT REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO '<username>'@'%';
        ```

    1. {% include [primary-keys-mysql](../../_includes/data-transfer/primary-keys-mysql.md) %}

        {% note info %}

        If the creation of a primary key returns an error saying <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, increase the value of the [inno_db_log_file_size](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) parameter in the DBMS settings.

        {% endnote %}

    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ MY }} source](./endpoint/source/mysql.md#additional-settings).

{% endlist %}

### {{ PG }} source {#source-pg}

{% list tabs %}

- {{ mpg-name }}

    1. Configure the user the transfer will connect to the source under:

        1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser).

        1. For the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types, [assign the role](../../managed-postgresql/operations/grant.md#grant-role) `mdb_replication` to this user.

        1. [Connect to the database](../../managed-postgresql/operations/connect.md) to migrate on behalf of the database owner and [set up the privileges](../../managed-postgresql/operations/grant.md#grant-privilege):
            * `SELECT` for all the database tables to be transferred.
            * `SELECT` for all the database sequences to be transferred.
            * `USAGE` for the schemas of these tables and sequences.

    1. If the replication source is a cluster, [enable](../../managed-postgresql/operations/cluster-extensions.md) the `pg_tm_aux` extension for it. This lets replication continue even after changing the master host.

    1. {% include [primary-keys-postgresql](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ PG }} source](./endpoint/source/postgresql.md#additional-settings).

- {{ PG }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}
    1. Configure the user that the transfer will connect to the source as:

        * For the _{{ dt-type-copy }}_ transfer type, create a user with the following command:

            ```sql
            CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
            ```

        * For the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types, create a user with the `REPLICATION` privilege with the command:

            ```sql
            CREATE ROLE <username> WITH REPLICATION LOGIN ENCRYPTED PASSWORD '<password>';
            ```

    1. Grant the created user the privilege to perform a `SELECT` on all the database tables to be transferred and the `USAGE` privilege for the schemas of these tables:

        ```sql
        GRANT SELECT ON ALL TABLES IN SCHEMA <schema name> TO <username>;
        GRANT USAGE ON SCHEMA <schema name> TO <username>;
        ```

    1. Install and enable the [wal2json](https://github.com/eulerto/wal2json) extension.

        **Installation**

        * Linux

            1. Add the [{{ PG }} official repository](https://www.postgresql.org/download/) for your distribution.
            1. Update the list of available packages and install the `wal2json` package for the used version of {{ PG }}.

        * Windows 10, 11

            1. If you don't have Microsoft Visual Studio installed yet, download and install it. To build the wal2json extension, the [Community Edition](https://visualstudio.microsoft.com/ru/vs/community/) is sufficient. During installation, select the following components:

                * MSBuild,
                * MSVC v141 x86/x64 build tools,
                * C++\CLI support for v141 build tools,
                * MSVC v141 — VS 2017 C++ x64\x86 build tools,
                * MSVC v141 — VS 2017 C++ x64\x86 Spectre-mitigated libs,
                * The latest version of the Windows SDK for the used OS version,
                * Other dependencies that are installed automatically for selected components.

                Remember the version number of the installed Windows SDK — you'll need it when you're asked to specify wal2json parameters.

            1. Download the wal2json source code from the [project page](https://github.com/eulerto/wal2json/releases).
            1. Unpack the archive with the source code to the `C:\wal2json\` folder.
            1. Go to `C:\wal2json`.
            1. Within one PowerShell session, make changes to the `wal2json.vcxproj` file:

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

                1. Enter the value of the extension variable required for building wal2json. For example, for Visual Studio Comminity Edition 2022:

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

    1. If the replication source is a cluster, install and enable the [pg_tm_aux](https://github.com/x4m/pg_tm_aux) extension on its hosts. This lets replication continue even after changing the master host.

    1. {% include [primary-keys-mysql](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types). For more information, see the [description of additional endpoint settings for the {{ PG }} source](./endpoint/source/postgresql.md#additional-settings).

    1. If replication via [Patroni](https://github.com/zalando/patroni) is configured on the source, add an [ignore_slots block](https://patroni.readthedocs.io/en/latest/SETTINGS.html?highlight=ignore_slots#dynamic-configuration-settings) to the source configuration:

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

### {{ yds-full-name }} source {#source-yds}

{% if audience == "external" %}
1. [Create a data stream](../../data-streams/operations/manage-streams.md#create-data-stream).

1. (Optional) [Create a data processing function](../../functions/operations/function/function-create.md).
{% else %}

1. Create a data stream.

1. (Optional) Create a processing function. {% endif %}

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

### {{ MG }} target {#target-mg}

{% list tabs %}

- {{ mmg-name }}

    1. [Create a database](../../managed-mongodb/operations/databases.md#add-db) with the same name as the source database name.

    1. [Create a user](../../managed-mongodb/operations/cluster-users.md#adduser) with the role [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) for the created database.

    1. To shard collections being transferred in a target {{ mmg-full-name }} cluster:

        1. Following the [instructions](../../managed-mongodb/tutorials/sharding.md), create and configure empty sharded target database collections with the same names as those in the source.

            {{ data-transfer-name }} does not automatically shard collections being transferred. Sharding large collections can take a long time and reduce transfer performance.

        1. If sharding occurs based on any key other than `_id` (default), [assign your user](../../managed-mongodb/operations/cluster-users.md#updateuser) the `mdbShardingManager` role.

        1. When [creating an endpoint for the receiver](./endpoint/target/mongodb.md), select the cleanup policy `DISABLED` or `TRUNCATE`.

            {% include [MongoDB endpoint DROP clean policy warning](../../_includes/data-transfer/note-mongodb-clean-policy.md) %}

        For more on sharding, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/sharding/).

- {{ MG }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Make sure that the {{ MG }} version on the target is not lower than that on the source.

    1. [Configure the target cluster](https://docs.mongodb.com/manual/core/security-mongodb-configuration/) so that you can connect to it from the internet:

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

        1. Connect to {{ MG }} and initialize the replica set with the command:

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

    1. To shard collections being transferred in a target cluster:

        1. Set up a database and populate it with empty collections with the same names as those in the source.

            {{ data-transfer-name }} does not automatically shard collections being transferred. Sharding large collections can take a long time and reduce transfer performance.

        1. Enable sharding for the target database:

            ```javascript
            sh.enableSharding("<target database name>")
            ```

        1. Create an index for each sharded collection:

            ```javascript
            db.<collection name>.createIndex(<index properties>)
            ```

            For a description of the `createIndex()` function, review the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/db.collection.createIndex/#mongodb-method-db.collection.createIndex).

        1. Configure sharding for each collection based on its namespace:

            ```javascript
            sh.shardCollection("<DB target name>.<collection name>", {"<index>": "<index type>"});
            ```

            For a description of the `shardCollection()` function, see the [{{ MG }} documentation](https://docs.mongodb.com/manual/reference/method/sh.shardCollection/#mongodb-method-sh.shardCollection).

        1. To make sure that sharding is configured and enabled, retrieve a list of available shards:

            ```javascript
            sh.status()
            ```

        1. If you use a key other than `_id` (default) for sharding, assign the `clusterManager` system role to the user that the {{ data-transfer-name }} service will utilize to connect to the target cluster:

            ```javascript
            use admin;
            db.grantRolesToUser("<username>", ["clusterManager"]);
            ```

        1. When [creating an endpoint for the receiver](./endpoint/target/mongodb.md) select the cleanup policy `DISABLED` or `TRUNCATE`.

            {% include [MongoDB endpoint DROP clean policy warning](../../_includes/data-transfer/note-mongodb-clean-policy.md) %}

        To learn more about sharding, see the [{{ MG }} documentation](https://docs.mongodb.com/basics/sharding/).

{% endlist %}

### {{ MY }} target {#target-my}

{% list tabs %}

- {{ mmy-name }}

    1. Make sure that the major version of {{ MY }} on the target is not lower than that on the source.

    1. [Set SQL Mode](../../managed-mysql/operations/update.md#change-mysql-config) that corresponds to the source.

    1. [Create a user](../../managed-mysql/operations/cluster-users.md#adduser) for connecting to the source.

        1. [Assign the user](../../managed-mysql/operations/grant.md#grant-role) the `ALL_PRIVILEGES` role for the source database.

- {{ MY }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Make sure that the major version of {{ MY }} on the target is not lower than that on the source.

    1. Make sure the target uses the MyISAM or InnoDB low-level storage subsystem.

    1. [Set SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting) that corresponds to the source.

    1. Create a user to connect to the target and grant them the necessary privileges:

        ```sql
        CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
        GRANT ALL PRIVILEGES ON <database name>.* TO '<username>'@'%';
        ```

{% endlist %}

### {{ objstorage-full-name }} target {#target-storage}

{% if audience != "internal" %}

   1. [Create a bucket](../../storage/operations/buckets/create.md) in the desired configuration.
   1. [Create a service account](../../iam/operations/sa/create.md) with the `storage.uploader` role.

{% else %}

   1. Create a bucket in the desired configuration.
   1. Create a service account with the `storage.uploader` role.

{% endif %}

### {{ PG }} target {#target-pg}

{% list tabs %}

- {{ mpg-name }}

    1. Make sure that the major version of {{ PG }} on the target is not lower than that on the source.

    1. On the target, disable the following:

        * Integrity checks for foreign keys.
        * Triggers.
        * Other constraints.

        {% note warning %}

        These settings should not be enabled again until the transfer ends to ensure the integrity of data in foreign keys.

        If you use the _{{ dt-type-copy-repl }}_ transfer type, you can enable the settings again after the [copy stage](../concepts/transfer-lifecycle.md#copy-and-replication) is completed.

        {% endnote %}

    1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser) with access to the target database.

        Once started, the transfer will connect to the target on behalf of this user.

- {{ PG }}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. {% include notitle [White IP list](../../_includes/data-transfer/configure-white-ip.md) %}

    1. Make sure that the major version of {{ PG }} on the target is not lower than that on the source.

    1. On the target, disable the following:

        * Integrity checks for foreign keys.
        * Triggers.
        * Other constraints.

        {% note warning %}

        These settings should not be enabled again until the transfer ends to ensure the integrity of data in foreign keys.

        If you use the _{{ dt-type-copy-repl }}_ transfer type, you can enable the settings again after the [copy stage](../concepts/transfer-lifecycle.md#copy-and-replication) is completed.

        {% endnote %}

    1. Create a user with the command:

        ```sql
        CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
        ```

    1. Run the following command to grant the user all privileges for the database, schemas, and tables to be transferred:

        ```sql
        GRANT ALL PRIVILEGES ON DATABASE <basa name> TO <username>;
        ```

        If the database is not empty, the user must be its owner:

        ```sql
        ALTER DATABASE <basa name> OWNER TO <username>;
        ```

        Once started, the transfer will connect to the target on behalf of this user.

{% endlist %}

The service does not transfer any materialized views (`MATERIALIZED VIEW`). For more information, see [Service specifics for sources and targets](../concepts/index.md#postgresql).

### {{ ydb-full-name }} {#prepare-source-ydb}

To receive data in {{ ydb-full-name }}, no setup is necessary.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}

