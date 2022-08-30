# Creating a logical replica of Amazon RDS for {{ PG }} in {{ mpg-name }}

You can use logical replication to migrate a database from an Amazon RDS for {{ PG }} _source cluster_ to a {{ mpg-name }} _target cluster_.

[Logical replication](https://www.postgresql.org/docs/current/logical-replication.html) uses the [subscription](https://www.postgresql.org/docs/current/sql-createsubscription.html) mechanism. This lets you migrate data to the target cluster with minimal downtime. Logical replication is available in Amazon RDS for {{ PG }} version 10.4 and higher.

Use logical replication if [data migration using {{ data-transfer-full-name }}](../tutorials/data-migration.md#data-transfer) is not possible for any reason.

To migrate a database from an Amazon RDS source cluster for {{ PG }} to a {{ mpg-name }} target cluster:

1. [Configure Amazon RDS](#amazon-set).
1. [Configure the target cluster and create a subscription](#mdb-pg-set).
1. [Migrate sequences](#transfer-sequences).
1. [Delete the subscription and switch over the load to the target cluster](#transfer-load).

## Using logical replication {#logical-replica-specific}

* Changes to the database schema and DDL are not replicated.

   First apply the new schema changes on the [subscription](https://www.postgresql.org/docs/current/logical-replication-subscription.html) side and then on the [publication](https://www.postgresql.org/docs/current/logical-replication-publication.html) side.

* Sequences (`SEQUENCES`) are not replicated.

   When the table is replicated, the data in the `serial` columns or ID columns that is generated using sequences are also replicated. However, the sequence on the subscriber side will preserve its starting value.

   If you switch to the subscriber database, restart the sequence using the latest value:

   ```sql
   ALTER SEQUENCE serial RESTART WITH <new value>;
   ```

* When you create a subscription, data from the source tables is fully copied.

   To accelerate the copy process, only create the primary key (`PRIMARY KEY`). Create all the other indexes after the copying is complete.

* If a table does not have a primary key, errors will occur during replication:

   ```text
   ERROR:  55000: cannot update table "<table name>" because it does not have a replica identity and publishes updates
   HINT:  To enable updating the table, set REPLICA IDENTITY using ALTER TABLE.
   ```

   To run `UPDATE` and `DELETE` replications on tables without the primary key, change the `REPLICA IDENTITY`:

   ```sql
   ALTER TABLE <table name> REPLICA IDENTITY FULL;
   ```

* In {{ PG }} version 10, the `TRUNCATE` command is not replicated.

   You can use `DELETE` instead.

* External tables are not replicated.
* If you need to recreate the subscription, clear the tables in the target cluster to prevent primary key constraint errors.
* To view errors relating to logical replication, see the [{{ mpg-name }} logs](cluster-logs.md).

## Before you begin {#before-you-begin}

Create the necessary resources:

{% list tabs %}

* Manually

   [Create a {{ mpg-name }} cluster](../operations/cluster-create.md) with public host access. In this case:

   * The {{ PG }} version must be the same or higher than the version in the source cluster. Migration with a {{ PG }} version downgrade is impossible.
   * The name of the database must be the same as in the source cluster.
   * Enable the same [{{ PG }} extensions](../operations/extensions/cluster-extensions.md) as in the source database.

* Using {{ TF }}

   1. If you don't have {{ TF }}, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the configuration file [logical-replica-amazon-rds-to-postgresql.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/logical-replica-amazon-rds-to-postgresql.tf) to the same working directory.

      This file describes:

      * [network](../../vpc/concepts/network.md#network).
      * [subnet](../../vpc/concepts/network.md#subnet).
      * [Security group](../../vpc/concepts/security-groups.md) and rule enabling cluster connections.
      * {{ mpg-name }} cluster with public internet access.

   1. Specify the infrastructure parameters in the configuration file `logical-replica-amazon-rds-to-postgresql.tf` under `locals`:

      * `pg_version`: {{ PG }} version. It must be not lower than the Amazon RDS version.
      * `db_name`: Target cluster database name. It must be the same as the source database name.
      * `username` and `password`: Database owner username and password.
      * Names and versions of {{ PG }} extensions used in Amazon RDS. Uncomment and multiply the `extension` section.

   1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Configure Amazon RDS {#amazon-set}

{% note warning %}

The DB instance must have public access: `Public accessibility = yes`.

{% endnote %}

1. Set up logical replication.

   1. Set the parameter to `parameter group` of your DB instance:

      ```text
      rds.logical_replication = 1
      ```

   1. Restart the cluster to apply the changes.

1. Create a separate user with the role `rds_replication`. To do this, execute the following statements on behalf of the user with the `rds_superuser` role:

   ```sql
   CREATE ROLE <username> WITH LOGIN PASSWORD <passport>;
   GRANT rds_replication TO <username>;
   ```

1. Grant the `SELECT` privilege to all the replicated tables:

   ```sql
   GRANT SELECT ON <table_1>, <table_2>, ..., <table_n> TO <username>;
   ```

1. Create a publication:

   ```sql
   CREATE PUBLICATION pub FOR TABLE <table_1>, <table_2>, ..., <table_n>;
   ```

   {% note info %}

   We don't recommend using `FOR ALL TABLES` publications as you won't be able to edit the table list later.

   {% endnote %}

1. Add a rule for incoming traffic in [VPC security groups](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_SecurityGroups.html). For example:

   ```text
   protocol: tcp, port: 5432, source: 84.201.175.90/32
   ```

   Where `84.201.175.90` is a public IP address.

## Configure the target cluster and create a subscription {#mdb-pg-set}

In {{ mpg-name }} clusters, subscriptions can be used by the database owner (a user created together with the cluster) and users with the `mdb_admin` role for the cluster.

1. (Optional) [Assign](../operations/grant.md#grant-role) the {{ mpg-name }} cluster user the `mdb_admin` role.

1. Create a subscription with the source cluster connection string:

   ```sql
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<source cluster address> port=<port> user=<username> sslmode=prefer dbname=<database name>' PUBLICATION pub;
   ```

   To learn more about creating subscriptions, see the [{{ PG }} documentation](https://www.postgresql.org/docs/10/sql-createsubscription.html).

1. To get the replication status, check the `pg_subscription_rel` directories.

   ```sql
   SELECT * FROM pg_subscription_rel;
   ```

   The `r` value in the `srsubstate` field means that replication was completed.

### Migrate sequences {#transfer-sequences}

To complete synchronization of the source cluster and the target cluster:

1. Switch the source cluster to <q>read-only</q> mode.
1. Create a dump with sequences:

   ```bash
   pg_dump --host=<source cluster address> \
           --username=<username> \
           --port=<port> \
           --dbname=<database name> \
           --data-only \
           --table='*.*_seq' > /tmp/seq-data.sql
   ```

   Take note of the `*.*_seq` pattern used. If the database you're migrating has sequences that don't match this pattern, enter a different pattern to export them.

   For more information about patterns, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-PATTERNS).

1. Restore the dump with sequences in the target cluster:

   ```bash
   psql \
       --host=<IP address or FQDN of the target cluster master host> \
       --username=<username> \
       --port={{ port-mpg }} \
       --dbname=<database name> < /tmp/seq-data.sql
   ```

### Delete the subscription and switch over the load to the target cluster {#transfer-load}

1. Delete the subscription in the target cluster:

   ```sql
   DROP SUBSCRIPTION s_data_migration;
   ```

1. Switch over the load to the target cluster.
