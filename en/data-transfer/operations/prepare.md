# Preparing for the transfer

## Preparing a source {#source}

### {{ KF }} source {#source-kf}

{% list tabs %}

* Managed Service for Apache Kafka®

    [Create an account](../../managed-kafka/operations/cluster-accounts.md#create-account) with the `ACCESS_ROLE_CONSUMER` role for the source topic.

* Apache Kafka®
    1. Set up the source cluster so that you can connect to it from the internet.
    1. [Configure access rights](https://kafka.apache.org/documentation/#multitenancy-security) to the desired topic for the account.
    1. (Optional) To use username and password authorization, [configure SASL authentication](https://kafka.apache.org/documentation/#security_sasl).

{% endlist %}

### {{ CH }} source {#source-ch}

{% list tabs %}

* {{ mch-name }}
    1. Make sure that the transferred tables use the `MergeTree` engines. Only these tables and [MaterializedViews](https://clickhouse.tech/docs/en/engines/table-engines/special/materializedview/) will be transferred.
    1. [Create a user](../../managed-clickhouse/operations/cluster-users.md) with access to the source database.

* {{ CH }}
    1. Make sure that the transferred tables use the `MergeTree` engines. Only these tables and [MaterializedViews](https://clickhouse.tech/docs/en/engines/table-engines/special/materializedview/) will be transferred.
    1. Set up the source cluster so that you can connect to it from the internet.
    1. Create a user with access to the source database.

{% endlist %}

### {{ MG }} source {#source-mg}

{% list tabs %}

* {{ mmg-name }}
    1. Estimate the total number of databases for transfer and the total {{ mmg-name }} workload. If the workload on the database exceeds 10000 writes per second, create several endpoints and transfers. For more information, see [Preparing a {{ MG }} source](../../data-transfer/operations/source-endpoint.md#settings-mongodb).
    1. [Create a user](../../managed-mongodb/operations/cluster-users.md#adduser) with the `readWrite` role for the source database.

* {{ MG }}

    1. Estimate the total number of databases for transfer and the total {{ MG }} workload. If the workload on the database exceeds 10000 writes per second, create several endpoints and transfers. For more information, see [Preparing a {{ MG }} source](../../data-transfer/operations/source-endpoint.md#settings-mongodb).

    1. Make sure that the major version of {{ MG }} on the target is `4.0` or higher.

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
        use <database name>
        db.createUser({
            user: "<username>",
            pwd: "<password>",
            mechanisms: ["SCRAM-SHA-1"],
            roles: [
                {
                    db: "<source database name>",
                    role: "readWrite"
                }
            ]
        });
        ```

        Once started, the transfer will connect to the source on behalf of this user.

{% endlist %}

### {{ MY }} source {#source-my}

{% list tabs %}

- {{ mmy-name }}

    1. [Enable full binary logging](../../managed-mysql/operations/update.md#change-mysql-config) on the source using the **Binlog row image** parameter.

    1. (Optional) [set a limit](../../managed-mysql/operations/update.md#change-mysql-config) on the size of data chunks to be sent using the **Max allowed packet** parameter.

    1. [Create a user](../../managed-mysql/operations/cluster-users.md#adduser) to connect to the source.

        1. [Assign the user the](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` role for the source database.

        1. [Grant the user](../../managed-mysql/operations/grant.md#grant-privilege) `REPLICATION CLIENT` and `REPLICATION SLAVE` privileges.

    1. {% include [primary-keys-mysql](../../_includes/data-transfer/primary-keys-mysql.md) %}

        {% note info %}

        If the creation of a primary key returns the error <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, [update the DBMS settings](../../managed-mysql/operations/update.md#change-mysql-config) by increasing the value of the [`Innodb log file size`](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) parameter.

        {% endnote %}

    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see [Source endpoint parameters {{ MY }}](source-endpoint.md#settings-mysql).

- {{ MY }}

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

        If the creation of a primary key returns the error <q>`Creating index 'PRIMARY' required more than 'innodb_online_alter_log_max_size' bytes of modification log. Please try again`</q>, increase the value of the [inno_db_log_file_size](https://dev.mysql.com/doc/refman/8.0/en/innodb-parameters.html#sysvar_innodb_log_file_size) parameter in the DBMS settings.

        {% endnote %}

    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }} transfer types). For more information, see [{{ MY }} source endpoint parameters](source-endpoint.md#settings-mysql).

{% endlist %}

### {{ PG }} source {#source-pg}

{% list tabs %}

* {{ mpg-name }}

    1. Configure the user that the transfer will connect to the source as:

        1. [Create a user](../../managed-postgresql/operations/cluster-users.md#adduser).

        1. For the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types [Assign the role](../../managed-postgresql/operations/grant.md#grant-role) `mdb_replication` to this user.

        1. [Connect to](../../managed-postgresql/operations/connect.md) to migrate on behalf of the database owner and [set up the privileges](../../managed-postgresql/operations/grant.md#grant-privilege):
            * `SELECT` for all the database tables to be transferred.
            * `SELECT` for all the database sequences to be transferred.
            * `USAGE` for the schemas of these tables and sequences.

    1. If the replication source is a cluster, [enable](../../managed-postgresql/operations/cluster-extensions.md) the `pg_tm_aux` extension for it. This lets replication continue even after changing the master host.

    1. {% include [primary-keys-postgresql](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see [{{ PG }} source endpoint parameters](source-endpoint.md#settings-postgresql).

* {{ PG }}

    1. Configure the user that the transfer will connect to the source as:

        * For the _{{ dt-type-copy }}_ transfer type, create a user with the following command:

            ```sql
            CREATE ROLE <username> LOGIN ENCRYPTED PASSWORD '<password>';
            ```

        * For the _{{ dt-type-repl }}_ and _{{ dt-type-copy-repl }}_ transfer types, create a user with the `REPLICATION` privilege using the command:

            ```sql
            CREATE ROLE <username> WITH REPLICATION LOGIN ENCRYPTED PASSWORD '<password>';
            ```

    1. Grant the created user the privilege to perform a `SELECT` on all the database tables to be transferred and the `USAGE` privilege for the schemas of these tables:

        ```sql
        GRANT SELECT ON ALL TABLES IN SCHEMA <schema name> TO <username>;
        GRANT USAGE ON SCHEMA <schema name> TO <username>;
        ```

    1. Install the [wal2json](https://github.com/eulerto/wal2json) plugin.

    1. If the replication source is a cluster, install the [pg_tm_aux](https://github.com/x4m/pg_tm_aux) plugin on its hosts. This lets replication continue even after changing the master host.

    1. {% include [primary-keys-postgresql](../../_includes/data-transfer/primary-keys-postgresql.md) %}

    1. Deactivate trigger transfer at the transfer initiation stage and reactivate it at the completion stage (for the _{{ dt-type-repl }}_ and the _{{ dt-type-copy-repl }}_ transfer types). For more information, see [{{ PG }} source endpoint parameters](source-endpoint.md#settings-postgresql).

{% endlist %}

### {{ yds-full-name }} source {#source-yds}


1. [Create a data stream](../../data-streams/operations/manage-streams.md#create-data-stream).

1. (Optional) [Create a data processing function](../../functions/operations/function/function-create.md).

    {% cut "Example of a data processing function" %}

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
    * `Int64`
    * `Int32`
    * `Int16`
    * `Int8`
    * `Uint64`
    * `Uint32`
    * `Uint16`
    * `Uint8`
    * `Double`
    * `Boolean`
    * `String`
    * `Utf8`
    * `Any`
    * `Datetime`

## Preparing a target {#target}

### {{ CH }} target {#target-ch}

{% list tabs %}

- {{ mch-name }}

    1. [Create a target database](../../managed-clickhouse/operations/databases.md#add-db).

        Its name must be the same as the source database name. If you need to transfer multiple databases, create a separate transfer for each of them.

    1. [Create a user](../../managed-clickhouse/operations/cluster-users.md#adduser) with access to the target database.

        Once started, the transfer will connect to the target on behalf of this user.

- {{ CH }}

    1. Create a target database. Its name must be the same as the source database name. If you need to transfer multiple databases, create a separate transfer for each of them.

    1. Create a user with access to the target database.

        Once started, the transfer will connect to the target on behalf of this user.

{% endlist %}

### {{ MG }} target {#target-mg}

{% list tabs %}

* MDB cluster
    1. [Create a database](../../managed-mongodb/operations/databases.md#add-db) with the same name as the source database name.
    1. [Create a user](../../managed-mongodb/operations/cluster-users.md#adduser) with the role [`readWrite`](../../managed-mongodb/concepts/users-and-roles.md#readWrite) for the created database.

* Custom installation

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

{% endlist %}

### {{ MY }} target {#target-my}

{% list tabs %}

* {{ mmy-name }}

    1. Make sure that the major version of {{ MY }} on the target is not lower than that on the source.

    1. [Install SQL Mode](../../managed-mysql/operations/update.md#change-mysql-config) that matches the source.

    1. [Create a user](../../managed-mysql/operations/cluster-users.md#adduser) to connect to the target.
        1. [Assign the user the](../../managed-mysql/operations/grant.md#grant-role) `ALL_PRIVILEGES` role for the target database.

* {{ MY }}

    1. Make sure that the major version of {{ MY }} on the target is not lower than that on the source.

    1. Make sure the target uses the MyISAM or InnoDB low-level storage subsystem.

    1. [Set the SQL Mode](https://dev.mysql.com/doc/refman/8.0/en/sql-mode.html#sql-mode-setting) so that it matches the source.

    1. Create a user to connect to the target and grant them the necessary privileges:

        ```sql
        CREATE USER '<username>'@'%' IDENTIFIED BY '<password>';
        GRANT ALL PRIVILEGES ON <database name>.* TO '<username>'@'%';
        ```

{% endlist %}

### {{ objstorage-name }} target {#target-storage}

1. [Create a bucket](../../storage/operations/buckets/create.md)  in the desired configuration.
1. [Create a service account](../../iam/operations/sa/create.md) with the `storage.uploader` role.

### {{ PG }} target {#target-pg}

{% list tabs %}

* {{ mpg-name }}

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

* {{ PG }}

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
        GRANT ALL PRIVILEGES ON DATABASE <database name> TO <username>;
        ```

        If the database is not empty, the user must be its owner:

        ```sql
        ALTER DATABASE <database name> OWNER TO <username>;
        ```

        Once started, the transfer will connect to the target on behalf of this user.

{% endlist %}

### {{ ydb-full-name }} {#prepare-source-ydb}

To receive data in {{ ydb-name }}, no setup is necessary.

