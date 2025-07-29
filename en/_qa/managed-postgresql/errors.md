#### Why do I get an error when using the TimescaleDB extension? {#timescale}

Error message:

```text
SQL Error [0A000]: ERROR: functionality not supported under the current "apache" license
Hint: Upgrade your license to 'timescale' to use this free community feature.
```

This error occurs when you attempt to use a function available only in TimescaleDB Community Edition.

The community edition is distributed under the [Timescale license (TSL)](https://www.timescale.com/legal/licenses). Clause 2.2 of the license prohibits using TimescaleDB Community Edition to provide DbaaS (Database as a Service) services, so this version is not available in {{ yandex-cloud }}.

The version installed in a {{ mpg-name }} cluster is TimescaleDB Apache 2 Edition, and its features are limited compared to the community version.

#### What should I do if I get the revocation check error when using PowerShell to obtain an SSL certificate? {#get-ssl-error}

Here is the full text of the error:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```

This means, when connecting to the website, the service was unable to check whether or not its certificate was listed among revoked ones.

To fix this error:

* Make sure the corporate network settings do not block the check.
* Run the command with the `--ssl-no-revoke` parameter.

    ```powershell
    mkdir $HOME\.postgresql; curl.exe --ssl-no-revoke -o $HOME\.postgresql\root.crt {{ crt-web-path }}
    ```

#### What should I do if I get the `SSL is required` error when connecting? {#ssl-req}

The error occurs because you are trying to connect to the cluster with a [public host](../../managed-postgresql/concepts/network.md#public-access-to-a-host). These hosts only support connections with an SSL certificate. You can:

* [Obtain an SSL certificate](../../managed-postgresql/operations/connect.md#get-ssl-cert) and add it to the application you are using to connect to the cluster.
* [Disable public access to hosts](../../managed-postgresql/operations/hosts.md#update) and connect to the cluster from a VM located in the same cloud network.

#### What should I do if I get the `too many active clients for user` error when connecting? {#connection-limit-error}

Connecting to cluster hosts may fail with the following error:

```text
too many active clients for user (pool_size for user <user_name> reached <limit_value>)
```

By default, a cluster reserves 50 connections to each host per user. If the connection limit per user is reached, any attempt to establish a new connection will fail with an error.

Solution: Increase the connection limit in the [**Conn limit** setting](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit).

To learn how to update {{ PG }} settings at the user level, see [this tutorial](../../managed-postgresql/operations/cluster-users.md#update-settings).

#### Why do I get an error when connecting to a custom database? {#database-error}

Connecting to a custom database may fail with the following error:

```text
ERROR: odyssey: ce3ea075f4ffa: route for '<DB_name>.<user_name>' is not found
```

The error means that the connection parameters contain an invalid database name.

#### Why do I get an error when creating a dump using pg_dumpall? {#dump-error}

You get this error when creating a dump using `pg_dumpall`:

```text
ERROR: odyssey: c16b9035a1f78: route for 'template1.<user_name>' is not found
```

This error is there because `pg_dumpall` tries to export all databases: both custom and system ones.

You cannot create a dump of all {{ mpg-name }} databases at the same time. Export dumps using `pg_dump` for each custom database one by one, excluding the system ones.

#### Why do I get an error when connecting to a postgres database? {#database-postgres-error}

Connecting to the `postgres` database fails with the following error:

```text
ERROR: odyssey: c76e2c1283a7a: route for 'postgres.<user_name>' is not found
```

`postgres` is a system database; connecting to it is prohibited in {{ mpg-name }}. Specify a different database in the connection parameters.

#### Why does a connection terminate with `terminating connection due to administrator command`? {#connection-error}

A {{ mpg-name }} cluster connection may be terminated with the following message:

```text
FATAL: terminating connection due to administrator command
```

This message does not indicate an error, it means that the session/transaction duration has exceeded the [Session duration timeout](../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout) setting value (default value: 12 hours).

#### Why cannot I connect to cluster hosts? {#host-error}

Connecting to cluster hosts may fail with the following error:

```text
could not translate host name "<regular or special FQDN>" to address: Name or service not known
```

This error occurs if public access to the host is denied or users are using custom DNS servers that do not allow domain names in the `mdb.yandexcloud.net` zone.

Solution:

* Enable public access for the host you are connecting to. When using a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns), enable public access for the host the special FQDN points to.

  {% include [special-fqdns-warning](../../_includes/mdb/special-fqdns-warning.md) %}

* We recommend that you enable public access for all cluster hosts. This will avoid connection errors during automatic master failover.
* For custom DNS servers, configure DNS forwarding for the `mdb.yandexcloud.net` zone.

#### Why cannot I stop a cluster? {#stop-cluster}

Error message:

```text
ERROR: rpc error: code = FailedPrecondition desc = Cluster has no backups
```

A cluster that has no backups cannot be [stopped](../../managed-postgresql/operations/cluster-stop.md#stop-cluster). To fix the error and stop the cluster, [create its backup](../../managed-postgresql/operations/cluster-backups.md#create-backup).

#### Why do I get the `max_connections is less than sum of users connection limit` error when modifying a cluster? {#max-connections-error}

This error may occur when downgrading a host class in a cluster if the sum of connection limits for all users is less then the total cluster connection limit ([Max connections](../../managed-postgresql/concepts/settings-list.md#setting-max-connections)).

Solution: First reduce the limits set for users so their sum is less than `<Max_connections_value> — 15` and then proceed with host class downgrade.

#### Why does a data transfer through creating and restoring a logical dump fail with an error? {#backup-error}

[Restoring a logical dump](../../managed-postgresql/tutorials/data-migration.md#backup) may fail with one of the following errors:

* `ERROR:  role "<source_username>" does not exist`
* `ERROR:  must be member of role "<source_username>"`

The errors occur because the target cluster does not have the user (or the privileges of the user) who created the logical dump in the source cluster.

To resolve the errors:

1. In the target cluster, [add a user](../../managed-postgresql/operations/cluster-users.md#adduser) with access to the migrated database and the same name as the user who created the logical dump in the source cluster.
1. Use this user to [restore the logical dump](../../managed-postgresql/tutorials/data-migration.md#restore) or [grant their privileges](../../managed-postgresql/operations/grant.md#grant-privilege) to the user who is restoring the logical dump.

#### What should I do if I get the `replication slot already exists` error when performing logical replication? {#repl-slot-exists}

By default, when you [create a subscription](../../tutorials/dataplatform/postgresql-data-migration.md#create-publication-subscription), a replication slot is also created. The `replication slot already exists` error means that a replication slot already exists.

You can fix this error by doing one of the following:

1. Link your subscription to an existing replication slot. To do this, add the `create_slot = false` parameter to the request to create a subscription.
1. [Delete the existing replication slot](../../managed-postgresql/operations/replication-slots.md#delete) and try creating the subscription again.

#### Why do I get an `extension... is not available` error when migrating my DB to {{ mpg-short-name }}? {#extension-is-not-available}

Error message:

```text
extension "<extension_name>" is not available
```

You may get this error when migrating a DB to {{ mpg-short-name }} with a script attempting to install and use the [{{ PG }} extension](../../managed-postgresql/operations/extensions/cluster-extensions.md). The reason for the error is that in {{ mpg-short-name }} clusters, you cannot use SQL commands to manage {{ PG }} extensions.

To avoid this error:

1. If the script or logical dump is in text format, remove the operators for creating {{ PG }} extensions from them.
1. [Install](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) all required extensions in the target database using the {{ yandex-cloud }} interfaces.

#### Why do I get the `must be owner of extension` error when deploying a logical dump? {#owner-of-extension}

[Restoring a logical dump](../../managed-postgresql/tutorials/data-migration.md#backup) may fail with this error: `ERROR: must be owner of extension`.

The error is there because the logical dump contains installation or update operations of [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md). In {{ mpg-short-name }} clusters, you cannot manage extensions using SQL commands.

To fix this error:

1. Before restoring the dump, [enable](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) all required extensions in the target database.
1. Exclude any operations with extensions from the dump. For example, you can comment out lines related to installation of extensions.
1. Perform logical dump recovery again.

#### Why do I get an error when setting up cascading replication? {#cascade-errors}

Error message:

```text
cluster should have at least 2 HA hosts to use cascade host
```

The error occurs if you specify a replication source for a single non-cascading replication.

To ensure [high availability](../../architecture/fault-tolerance.md#mdb-ha), your cluster must have at least one replica without a replication source. During maintenance or if the master host fails, this replica will take over as the master.

To learn more about replication, see [this guide](../../managed-postgresql/concepts/replication.md).

#### Why do I get the `cannot execute <SQL_command> in a read-only transaction` error? {#read-only-error}

Error options:

```text
ERROR: cannot execute ALTER EXTENSION in a read-only transaction
```

```text
ERROR: cannot execute CREATE TABLE in a read-only transaction
```

```text
ERROR: cannot execute UPDATE in a read-only transaction
```

```text
ERROR: cannot execute INSERT in a read-only transaction
```

Such errors can occur after master [failover](../../architecture/fault-tolerance.md#mdb-ha) if you connected to a read-only replica.

To prevent such errors, use any of the following ways:

* Connect to the cluster using a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns) that always points to the current master.

  {% include [special-fqdns-warning](../../_includes/mdb/special-fqdns-warning.md) %}

* When connecting, specify the `target_session_attrs=read-write` parameter and list all cluster hosts. This way, you will connect to the master host with read and write access.

For more information on how to connect to the master host, see [Connecting to a database](../../managed-postgresql/operations/connect.md#automatic-master-host-selection).
