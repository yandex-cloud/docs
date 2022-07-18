# Migrating databases from {{ mpg-name }}

A {{ mpg-name }} cluster supports [logical replication](https://www.postgresql.org/docs/current/logical-replication.html). This lets you use built-in {{ PG }} tools for migrating databases between different {{ PG }} clusters with version 10 and later. Migration across versions is also supported. For example, you can move databases from {{ PG }} ver. 11 to ver. 13.

{% note info %}

If you use older clusters, you can migrate your database by [making a dump](https://www.postgresql.org/docs/current/app-pgdump.html) and then [restoring](https://www.postgresql.org/docs/current/app-pgrestore.html) from it.

{% endnote %}

This use case describes how to migrate a database from {{ mpg-name }} to a different {{ PG }} cluster using logical replication.

To migrate a database from the {{ mpg-name }} *source cluster* to the {{ PG }} *target cluster*:
1. [Migrate the database schema](#migrate-schema).
1. [Configure the user to manage replication on the source cluster](#configure-user).
1. [Create a publication on the source cluster](#create-publication).
1. [Create a subscription on the target cluster](#create-subscription).
1. [Monitor the migration process](#monitor-migration) until it is complete.
1. [Finish the migration](#finish-migration).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

1. Make sure that all the source cluster's hosts are accessible by a public IP address so that the target cluster can connect to the source. For more information, see [{#T}](../operations/cluster-create.md).
1. [Install the {{ mpg-name }} client SSL certificates on the hosts of the target cluster](../operations/connect.md#get-ssl-cert). They're required to successfully connect to the source cluster that is publicly available.
1. If necessary, set up the firewall and [security groups](../operations/connect.md#configuring-security-groups) so that you can connect to the source cluster from the target cluster, as well as to each cluster separately (for example, using the [psql](https://www.postgresql.org/docs/current/app-psql.html) utility).
1. Make sure that you can connect to the source cluster's hosts from the target cluster's hosts.
1. Make sure you can [connect to the source cluster](../operations/connect.md) and the target cluster via SSL.
1. Check that an empty database is created on the target cluster to migrate your data to.
1. Check if there is a user with full access rights to this database in the target cluster.

## Migrate the database schema {#migrate-schema}

For logical replication to work properly, both the source and the target must have the same database schema. To migrate the database schema:
1. Create a dump of the source cluster's database schema using the [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html) utility:

   ```bash
   pg_dump "host=<source cluster's host FQDN> port=6432 sslmode=verify-full dbname=<DB name> user=<DB owner username>" --schema-only --no-privileges --no-subscriptions --no-publications -Fd -f <dump directory>
   ```

   You can obtain the host FQDN with a [list of hosts in the cluster](../operations/hosts.md#list).

1. If necessary, create users with the appropriate access rights to the target cluster's database objects.

1. Restore the database schema from the dump on the target cluster using the [pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html) utility:

   ```bash
   pg_restore -Fd -v --single-transaction -s --no-privileges -h <target cluster's host FQDN> -U <DB owner username> -p 5432 -d <DB name> <dump directory>
   ```

## Configure the user to manage replication on the source cluster {#configure-user}

{{ PG }} uses the publish-subscribe model for logical replication: the target cluster *subscribes* to the source cluster's *publication* to transfer data. To successfully subscribe to a publication, make sure the {{ mpg-name }} source cluster is accessed on behalf of the user who is assigned the logical replication  management role. To configure this user:
1. [Create a user](../operations/cluster-users.md#adduser).
1. [Assign the role](../operations/grant.md#grant-role) `mdb_replication` to this user.
1. [Connect to the database](../operations/connect.md) that you want to migrate as the **database owner**.
1. [Grant the created user a privilege](../operations/grant.md#grant-privilege) to perform a `SELECT` on all the DB tables.

After [creating a subscription](#create-subscription), a connection to the source cluster on the target side will be made on behalf of this user.

## Create a publication on the source cluster {#create-publication}

1. [Connect](../operations/connect.md) to the **master host** and the database to migrate as the **database owner**.
1. Create a publication that the target cluster will subscribe to:

   ```sql
   CREATE PUBLICATION <publication name>;
   ```

1. Include all database tables in the created publication:

   ```
   ALTER PUBLICATION <publication name> ADD TABLE <table name 1>;
   ...
   ALTER PUBLICATION <publication name> ADD TABLE <table name N>;
   ```

   {% note info %}

   {{ mpg-name }} clusters don't support creating a publication for all tables at once `CREATE PUBLICATION ... FOR ALL TABLES;`, since this requires superuser privileges.

   {% endnote %}

## Create a subscription on the target cluster {#create-subscription}

1. Connect to the **master host** and the target database as a **superuser** (such as `postgres`).
1. Create a subscription to the source cluster's publication:

   ```sql
   CREATE SUBSCRIPTION <subscription name> CONNECTION 'host=<source cluster's host FQDN> port=6432 sslmode=verify-full dbname=<name of the DB to migrate> user=<name of the user to manage replication> password=<user password>' PUBLICATION <publication name>;
   ```

This starts the process of migrating data from the source cluster's database to the target cluster's database.

## Monitoring the migration process {#monitor-migration}

Track the migration process in the [pg_subscription_rel](https://www.postgresql.org/docs/current/catalog-pg-subscription-rel.html) directory that shows the *replication status*:

```sql
SELECT * FROM pg_subscription_rel;

 srsubid | srrelid | srsubstate | srsublsn
---------+---------+------------+----------
...
```

We recommend that you monitor the replication status by the `srsubstate` field in this directory on the target cluster.

You can get the overall replication status using the [pg_stat_subscription](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-SUBSCRIPTION) view on the target cluster and the [pg_stat_replication](https://www.postgresql.org/docs/current/monitoring-stats.html#MONITORING-PG-STAT-REPLICATION-VIEW) view on the source cluster.

## Finish the migration {#finish-migration}

After the replication is complete:
1. Disable writing data to the migrated database on the source cluster.

1. Transfer sequences, if any, from the source cluster to the target cluster using the pg_dump and psql utilities:

   ```bash
   pg_dump "host=<source cluster host FQDN> port=6432 sslmode=verify-full dbname=<DB name> user=<DB owner username>" --data-only -t '*.*_seq' > <name of the file with sequences>
   ```

   ```bash
   psql -h <target cluster host FQDN> -U <DB owner username> -p 5432 -d <DB name> < <name of the file with sequences>
   ```

1. Delete the subscription on the target cluster:

   ```sql
   DROP SUBSCRIPTION <subscription name>;
   ```

1. Delete the publication on the source cluster:

   ```sql
   DROP PUBLICATION <publication name>;
   ```

1. [Remove the user](../operations/cluster-users.md#removeuser) managing replication on the source cluster.

## Delete the resources you created {#clear-out}

If you no longer need these resources, delete them:

1. {% if audience != "internal" %}[Delete the virtual machine](../../compute/operations/vm-control/vm-delete.md){% else %}Delete a virtual machine{% endif %}.
1. If you reserved a public static IP for your virtual machine, {% if audience != "internal" %}[delete it](../../vpc/operations/address-delete.md){% else %}delete it{% endif %}.
1. [Delete a {{ mpg-full-name }} cluster](../operations/cluster-delete.md).
