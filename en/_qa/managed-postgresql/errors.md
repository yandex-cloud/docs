#### Why do I get an error when using the TimescaleDB extension? {#timescale}

Error message:

```text
SQL Error [0A000]: ERROR: functionality not supported under the current "apache" license
Hint: Upgrade your license to 'timescale' to use this free community feature.
```

This error occurs when you attempt to use a function available only in TimescaleDB Community Edition.

The community edition is distributed under the [Timescale license (TSL)](https://www.timescale.com/legal/licenses). Due to clause 2.2 of this license, which prohibits using TimescaleDB Community Edition for DbaaS (Database as a Service) offerings, this version is not available in {{ yandex-cloud }}.

The version installed in a {{ mpg-name }} cluster is TimescaleDB Apache 2 Edition, which has reduced functionality compared to the Community Edition.

#### What should I do if I get a revocation check error when using PowerShell to obtain an SSL certificate? {#get-ssl-error}

Here is the full text of the error:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```

This indicates that the service was unable to verify the site’s certificate against the revocation list during the connection attempt.

To fix this error:

* Make sure your corporate network policies are not blocking the verification.
* Run the following command with the `--ssl-no-revoke` flag.

    ```powershell
    mkdir $HOME\.postgresql; curl.exe --ssl-no-revoke -o $HOME\.postgresql\root.crt {{ crt-web-path }}
    ```

#### What should I do if I get an `SSL is required` error when connecting? {#ssl-req}

This error occurs because you are trying to connect to a cluster with a [publicly accessible host](../../managed-postgresql/concepts/network.md#public-access-to-a-host). Such hosts require an SSL certificate to connect. You have the following options:

* [Obtain an SSL certificate](../../managed-postgresql/operations/connect.md#get-ssl-cert) and add it to the application you use to connect.
* [Disable public access to hosts](../../managed-postgresql/operations/hosts.md#update) and connect to the cluster from a VM located in the same cloud network.

#### What should I do if I get a `too many active clients for user` error when connecting? {#connection-limit-error}

An attempt to connect to a cluster host may fail with the following error:

```text
too many active clients for user (pool_size for user <username> reached <limit_value>)
```

By default, a cluster reserves 50 connections per host for each user. If the user’s connection limit is reached, new connection attempts will fail.

Solution: Increase the connection limit in the [**Conn limit** setting](../../managed-postgresql/concepts/settings-list.md#setting-conn-limit).

For instructions on updating {{ PG }} settings at the user level, see [this guide](../../managed-postgresql/operations/cluster-users.md#update-settings).

#### Why do I get an error when connecting to a custom database? {#database-error}

An attempt to connect to a custom database may fail with the following error:

```text
ERROR: odyssey: ce3ea075f4ffa: route for '<DB_name>.<username>' is not found
```

This error indicates that your connection settings contain an incorrect database name.

#### Why do I get an error when creating a dump with pg_dumpall? {#dump-error}

You can get this error when creating a dump with `pg_dumpall`:

```text
ERROR: odyssey: c16b9035a1f78: route for 'template1.<username>' is not found
```

This error occurs because `pg_dumpall` tries to export all databases, including both custom and system ones.

You cannot create a dump of all {{ mpg-name }} databases at once. Instead, use `pg_dump` to dump each custom database individually, skipping the system ones.

#### Why do I get an error when connecting to the postgres database? {#database-postgres-error}

An attempt to connect to the `postgres` database may fail with the following error:

```text
ERROR: odyssey: c76e2c1283a7a: route for 'postgres.<username>' is not found
```

This error occurs because `postgres` is a system database and connecting to it is prohibited by {{ mpg-name }}. Specify a different database in your connection settings.

#### Why does my connection terminate with a `terminating connection due to administrator command` message? {#connection-error}

A {{ mpg-name }} cluster connection may be terminated with the following message:

```text
FATAL: terminating connection due to administrator command
```

This message is not an error; it indicates that the session/transaction duration has exceeded the [Session duration timeout](../../managed-postgresql/concepts/settings-list.md#setting-session-duration-timeout) setting (12 hours by default).

#### Why cannot I connect to cluster hosts? {#host-error}

An attempt to connect to a cluster’s host may fail with the following error:

```text
could not translate host name "<regular or special FQDN>" to address: Name or service not known
```

This error occurs if public access to the host is restricted or if you are using a custom DNS server that cannot resolve domain names in the `mdb.yandexcloud.net` zone.

Solution:

* Enable public access to your target host. When using a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns), enable public access for the host associated with that FQDN.

  {% include [special-fqdns-warning](../../_includes/mdb/special-fqdns-warning.md) %}

* We recommend that you enable public access for all cluster hosts. This will prevent connection errors during automatic master failover.
* For custom DNS servers, configure DNS forwarding for the `mdb.yandexcloud.net` zone.

#### Why cannot I stop a cluster? {#stop-cluster}

Error message:

```text
ERROR: rpc error: code = FailedPrecondition desc = Cluster has no backups
```

You cannot [stop](../../managed-postgresql/operations/cluster-stop.md#stop-cluster) a cluster if it does not have any backups. To stop such a cluster, first [create a backup](../../managed-postgresql/operations/cluster-backups.md#create-backup) for it.

#### Why do I get a max_connections is less than sum of users connection limit error when modifying a cluster? {#max-connections-error}

This error may occur when downgrading a host class in a cluster if the sum of all user connection limits becomes less than the total cluster connection limit specified in [Max connections](../../managed-postgresql/concepts/settings-list.md#setting-max-connections).

Solution: First, reduce the per-user connection limits until their combined total is less than `<Max_connections_value> — 15`, and then lower the host class.

#### Why do I get an error when transferring data by creating and restoring a logical dump? {#backup-error}

[Restoring a logical dump](../../managed-postgresql/tutorials/data-migration.md#backup) may fail with one of the following errors:

* `ERROR: role "<source_username>" does not exist`
* `ERROR: must be member of role "<source_username>"`

These errors occur because the target cluster lacks the user account or the user privileges that were used to create the logical dump in the source cluster.

To resolve these errors:

1. In the target cluster, [add a user](../../managed-postgresql/operations/cluster-users.md#adduser) with access to the migrated database and the same name as the user who created the logical dump in the source cluster.
1. [Restore the logical dump](../../managed-postgresql/tutorials/data-migration.md#restore) on behalf of this user or [grant their privileges](../../managed-postgresql/operations/grant.md#grant-privilege) to another account you want to use to restore the logical dump.

#### What should I do if I get a replication slot already exists error during logical replication? {#repl-slot-exists}

By default, the system creates a replication slot when you [create a subscription](../../tutorials/dataplatform/postgresql-data-migration.md#create-publication-subscription). The `replication slot already exists` error means that the replication slot already exists.

You can resolve this error in one of the following ways:

1. Link your subscription to an existing replication slot. To do this, add `create_slot = false` to your command for creating a subscription.
1. [Delete the existing replication slot](../../managed-postgresql/operations/replication-slots.md#delete) and try creating the subscription again.

#### Why do I get an extension... is not available error when migrating my database to {{ mpg-short-name }}? {#extension-is-not-available}

Error message:

```text
extension "<extension_name>" is not available
```

This error may occur during a database migration to {{ mpg-short-name }} using a script that attempts to install and use the [{{ PG }} extension](../../managed-postgresql/operations/extensions/cluster-extensions.md). The error occurs because {{ PG }} extensions cannot be managed via SQL in {{ mpg-short-name }} clusters.

To avoid this error:

1. For scripts and dumps in text format, remove any {{ PG }} extension creation commands from them.
1. [Install](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) all required extensions in the target database using the {{ yandex-cloud }} interfaces.

#### Why do I get a must be owner of extension error when restoring a logical dump? {#owner-of-extension}

[Restoring a logical dump](../../managed-postgresql/tutorials/data-migration.md#backup) may fail with the following error: `ERROR: must be owner of extension`.

The error is caused by the presence of [{{ PG }} extension](../../managed-postgresql/operations/extensions/cluster-extensions.md) installation or update operations in the logical dump. In {{ mpg-short-name }} clusters, you cannot manage extensions using SQL commands.

To resolve this error, do the following:

1. Before restoring the dump, [enable](../../managed-postgresql/operations/extensions/cluster-extensions.md#update-extensions) all required extensions in the target database.
1. Remove any operations with extensions from the dump. For example, comment out the lines related to installing extensions.
1. Repeat the logical dump recovery attempt.

#### Why do I get an error when setting up cascading replication? {#cascade-errors}

Error message:

```text
cluster should have at least 2 HA hosts to use cascade host
```

This error occurs if you specify a replication source for the only non-cascading replica.

To ensure [high availability](../../architecture/fault-tolerance.md#mdb-ha), your cluster must contain at least one replica without a defined replication source. This replica will be promoted to master if the master host fails during maintenance.

To learn more about replication, see [this section](../../managed-postgresql/concepts/replication.md).

#### Why do I get a cannot execute <SQL_command> in a read-only transaction error? {#read-only-error}

Error variations:

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

Such errors may occur after master [failover](../../architecture/fault-tolerance.md#mdb-ha) when you are connected to a read-only replica.

You can prevent these errors in one of the following ways:

* Connect to the cluster using a [special FQDN](../../managed-postgresql/operations/connect.md#special-fqdns) that always points to the current master.

  {% include [special-fqdns-warning](../../_includes/mdb/special-fqdns-warning.md) %}

* When connecting, specify `target_session_attrs=read-write` and list all cluster hosts. This way, you will connect to the master host with read and write access.

For more details on connecting to the master host, see [Connecting to a database](../../managed-postgresql/operations/connect.md#automatic-master-host-selection).

#### What should I do if I see a too many connections for role "monitor" error in the logs? {#monitor-role-error}

The `monitor` user is reserved for monitoring purposes in the {{ mpg-name }} cluster. You can ignore `too many connections` warnings for this user.

#### Why do I get an error when trying to install multiple extensions in the CLI? {#cli-extensions-errors}

Installing multiple extensions in the CLI may fail with one of these errors:

* `ERROR: accepts 1 arg(s), received 2`

   This error may occur due to an incorrect command format.

   Solution: Make sure to list the extensions with no spaces in between. Here is an example:

   ```bash
   {{ yc-mdb-pg }} database update db1 --cluster-id {{ cluster-id }} --extensions cube,pg_logic,timescaledb
   ```

* `ERROR: rpc error: code = InvalidArgument desc = Invalid extensions '<extension_name>', allowed extension: <extension_list>`

  You may get this error if an extension in the list is incompatible with the {{ PG }} version in the cluster.

  Solution: Check the compatibility of the extensions specified in the command in the [list of supported extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md#postgresql).

* `ERROR: rpc error: code = InvalidArgument desc = The specified extension '<extension_name>' is not present in shared_preload_libraries`

  This error may occur if the cluster does not contain the required shared library.

  Solution: Check the shared library requirements in the [list of supported extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md#postgresql). To add the required library, when [updating the {{ PG }} cluster settings](../../managed-postgresql/operations/update.md#change-postgresql-config), specify its name in the [Shared preload libraries parameter](../../managed-postgresql/concepts/settings-list.md#setting-shared-libraries).
