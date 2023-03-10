# Migrating databases from a third-party {{ PG }} cluster to {{ mpg-name }}

There are three ways to migrate data from a third-party _source cluster_ to a {{ mpg-name }} _target cluster_:

* [Transferring data using {{ data-transfer-full-name }}](#data-transfer).

   This method allows you to:

   * Go without creating an intermediate VM or granting online access to your {{ mpg-name }} target cluster.
   * Migrate the database completely without stopping serving users.
   * Migrate from older {{ PG }} versions to newer versions.

   To use this method, allow connecting to the source cluster from the internet.

   For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

* [Migrating data using logical replication](#logical-replication).

   [_Logical replication_](https://www.postgresql.org/docs/current/logical-replication.html) uses the [subscriptions](https://www.postgresql.org/docs/current/sql-createsubscription.html) mechanism. This lets you migrate data to the target cluster with minimal downtime.

   Use this method only if, for some reason, it's not possible to migrate data using {{ data-transfer-full-name }}.

* [Transferring data by creating and restoring a logical dump](#backup).

   A _logical dump_ is a file with a set of commands running which one by one you can restore the state of a database. It is created using the `pg_dump` utility. To ensure that a logical dump is complete, before creating it, switch the source cluster to <q>read-only</q> mode.

   Use this method only if, for some reason, it's not possible to transfer data using any of the above methods.

## Transferring data using {{ data-transfer-full-name }} {#data-transfer}

{% include notitle [PostgreSQL migration with Data Transfer](../../_tutorials/datatransfer/managed-postgresql.md) %}

## Migrating data using logical replication {#logical-replication}

Logical replication is supported as of {{ PG }} version 10. Besides migrating data between the same {{ PG }} versions, logical replication lets you migrate to newer {{ PG }} versions.

In {{ mpg-name }} clusters, subscriptions can be used by the database owner (a user created together with the cluster) and users with the `mdb_admin` role for the cluster.

Migration stages:

1. [Set up the source cluster](#source-setup).
1. [Export the database schema in the source cluster](#source-schema-export).
1. [Restore the database schema in the target cluster](#restore-schema).
1. [Create a {{ PG }} publication and subscription](#create-publication-subscription).
1. [Migrate the {{ PG }} sequence after replication](#transfer-sequences).
1. [Disable replication and transfer the load](#transfer-load).

If you no longer need these resources, [delete them](#clear-out-logical).

### Before you begin {#before-you-begin-logical}

Create the necessary resources:

{% list tabs %}

* Manually

   Create a [{{ mpg-name }} target cluster](../../managed-postgresql/operations/cluster-create.md) with any suitable configuration. In this case:

   * The {{ PG }} version must be the same or higher than the version in the source cluster. Migration with a {{ PG }} version downgrade is impossible.
   * When creating a cluster, specify the same database name as in the source cluster.
   * Enable the same [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) as in the source cluster.

* Using Terraform

   1. If you don't have {{ TF }}, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the configuration file [data-migration-pgsql-mpg.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-pgsql-mpg/data-migration-pgsql-mpg.tf) to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a cluster.
      * {{ mpg-name }} cluster with public internet access.

   1. Specify the following in `data-migration-pgsql-mpg.tf`:

      * `source_db_name`: Database name.
      * `pg-extensions`: List of [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) in the source cluster.
      * Target cluster parameters:

         * `target_mysql_version`: {{ PG }} version, must be the same as or higher than the version in the source cluster.
         * `target_user` and `target_password`: Username and password of the database owner.
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

### Set up the source cluster {#source-setup}

1. Specify the necessary SSL and WAL settings in the `postgresql.conf` file. On Debian and Ubuntu Linux distributions, the default path to this file is `/etc/postgresql/<{{ PG }} version>/main/postgresql.conf`.
   1. We recommend using SSL for migrating data: this will not only help encrypt data, but also compress it. For more information, see [SSL Support](https://www.postgresql.org/docs/current/libpq-ssl.html) and [Database Connection Control Functions](https://www.postgresql.org/docs/current/libpq-connect.html) in the {{ PG }} documentation.

      To enable SSL, set the desired value in the configuration:

      ```ini
      ssl = on                   # on, off
      ```

   1. Change the logging level for [Write Ahead Log (WAL)](https://www.postgresql.org/docs/current/static/wal-intro.html) to add the information needed for logical replication. To do this, set the value of the [wal_level](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS) as `logical`.

      The setting can be changed in `postgresql.conf`. Find the line with the `wal_level` setting, comment it out if necessary, and set the value as `logical`:

      ```ini
      wal_level = logical                    # minimal, replica, or logical
      ```

1. Configure authentication of hosts in the source cluster. To do this, add the cluster hosts to the `pg_hba.conf` file on {{ yandex-cloud }} (on Debian and Ubuntu distributions, it is located at the path `/etc/postgresql/<{{ PG }} version>/main/pg_hba.conf by default`).

   Add lines to allow connecting to the database from the specified hosts:

   * If you use SSL:

      ```txt
      hostssl         all            all             <host address>      md5
      hostssl         replication    all             <host address>      md5
      ```

   * If you don't use SSL:

      ```txt
      host         all            all             <host address>      md5
      host         replication    all             <host address>      md5
      ```

1. If a firewall is enabled in the source cluster, allow incoming connections from the {{ mpg-name }} cluster hosts. For example, for Ubuntu 18:

   ```bash
   sudo ufw allow from <target cluster host address> to any port <port>
   ```

1. Restart the {{ PG }} service to apply all your settings:

   ```bash
   sudo systemctl restart postgresql
   ```

1. Check the {{ PG }} status after restarting:

   ```bash
   sudo systemctl status postgresql
   ```

### Export the database schema in the source cluster {#source-schema-export}

Use the `pg_dump` utility to create a file with the database schema to be applied in the target cluster.

```bash
pg_dump -h <IP address or FQDN of source cluster's master host> \
        -U <username> \
        -p <port> \
        --schema-only \
        --no-privileges \
        --no-subscriptions \
        -d <DB name> \
        -Fd -f /tmp/db_dump
```

This export command skips all data associated with privileges and roles to avoid conflicts with the database settings in {{ yandex-cloud }}. If your database requires additional users, [create them](../../managed-postgresql/operations/cluster-users.md#adduser).

### Restore the database schema in the target cluster {#restore-schema}

Using the `pg_restore` utility, restore the database schema in the target cluster:

```bash
pg_restore -h <IP address or FQDN of target cluster's master host> \
           -U <username> \
           -p {{ port-mpg }} \
           -Fd -v \
           --single-transaction \
           -s --no-privileges \
           -d <DB name> /tmp/db_dump
```

### Create a publication and subscription {#create-publication-subscription}

For logical replication to work, create a publication (a group of logically replicated tables) in the source cluster and a subscription (a description of connection to another database) on the target cluster.

1. On the source cluster, create a publication for all the database tables. When migrating multiple databases, you need to create a separate publication for each of them.

   {% note info %}

   You need superuser rights to create publications to all tables, but not to transfer the selected tables. For more information about creating publications, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-createpublication.html).

   {% endnote %}

   Query:

   ```sql
   CREATE PUBLICATION p_data_migration FOR ALL TABLES;
   ```

1. On the {{ mpg-name }} cluster host, create a subscription with a connection string to the publication. For more information about creating subscriptions, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/sql-createsubscription.html).

   Request with SSL enabled:

   ```sql
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<source cluster address> port=<port> user=<username> sslmode=verify-full dbname=<database name>' PUBLICATION p_data_migration;
   ```

   Without SSL:

   ```sql
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<source cluster address> port=<port> user=<username> sslmode=disable dbname=<database name>' PUBLICATION p_data_migration;
   ```

1. To get the replication status, check the `pg_subscription_rel` directories. You can get the general replication status in the target cluster using `pg_stat_subscription` and in the source cluster using `pg_stat_replication`.

   ```sql
   SELECT * FROM pg_subscription_rel;
   ```

   First of all, check the `srsubstate` field. `R` in this field means that synchronization has ended and the databases are ready to be replicated.

### Migrate {{ PG }} sequences after replication {#transfer-sequences}

To complete synchronization of the source cluster and the target cluster:

1. Switch the source cluster to <q>read-only</q> mode.
1. Create a dump with {{ PG }}-sequences in the source cluster:

   ```bash
   pg_dump -h <IP address or FQDN of source cluster's master host> \
           -U <username> \
           -p <port> \
           -d <DB name> \
           --data-only -t '*.*_seq' > /tmp/seq-data.sql
   ```

   Take note of the `*.*_seq` pattern used. If the database you're migrating has sequences that don't match this pattern, enter a different pattern to export them.

   For more information about patterns, see the [{{ PG }} documentation](https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-PATTERNS).

1. Restore the dump with sequences in the target cluster:

   ```bash
   psql -h <IP address or FQDN of target cluster's master host> \
        -U <username> \
        -p {{ port-mpg }} \
        -d <DB name> \
        < /tmp/seq-data.sql
   ```

### Delete the subscription and switch over the load {#transfer-load}

1. Delete the subscription in the target cluster:

   ```sql
   DROP SUBSCRIPTION s_data_migration;
   ```

1. Switch over the load to the target cluster.

### Delete the resources you created {#clear-out-logical}

{% list tabs %}

* Manually created resources

   [Delete a {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).

* Resources created using {{ TF }}

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the configuration file `data-migration-pgsql-mpg.tf`.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the configuration file `data-migration-pgsql-mpg.tf` will be deleted.

{% endlist %}

## Transferring data by creating and restoring a logical dump {#backup}

Create a dump of the necessary database in the source cluster using the `pg_dump` utility. To restore the dump in the target cluster, use the `pg_restore` utility.

{% note info %}

To use `pg_restore`, you might need the `pg_repack` database extension.

{% endnote %}

Migration stages:

1. [Create a dump of the database you want to migrate](#dump).
1. [(optional) Create a virtual machine in {{ yandex-cloud }} and upload the dump to it](#create-vm).
1. [Restore data from the dump to the target cluster](#restore).

If you no longer need these resources, [delete them](#clear-out-backup).

### Before you begin {#before-you-begin-backup}

Create the necessary resources:

{% list tabs %}

* Manually

   1. Create a [{{ mpg-name }} target cluster](../../managed-postgresql/operations/cluster-create.md) with any suitable configuration. In this case:

      * The {{ PG }} version must be the same as the version in the source cluster.
      * When creating a cluster, specify the same database name as in the source cluster.
      * Enable the same [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) as in the source cluster.
   1. (Optional) [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) on [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) with the following parameters:

      * **Disks and file storage** → **Size**: Sufficient to store both archived and unarchived dumps.

         The recommended size is two or more times the total dump and dump archive size.

      * **Network settings**:

         * **Subnet**: Select a subnet on the cloud network hosting the target cluster.
         * **Public address**: Select `Auto` or one address from a list of reserved IPs.

   1. [Set up security groups](../../managed-postgresql/operations/connect.md#configure-security-groups) for the intermediate VM and the {{ mpg-name }} cluster.

* Using {{ TF }}

   1. If you don't have {{ TF }}, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the configuration file [data-restore-pgsql-mpg.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-pgsql-mpg/data-restore-pgsql-mpg.tf) to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a cluster.
      * {{ mpg-name }} cluster with public internet access.
      * (Optional) Virtual machine with public internet access.

   1. Specify the following in `data-restore-pgsql-mpg.tf`:

      * `source_db_name`: Database name.
      * `pg-extensions`: List of [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) in the source cluster.
      * Target cluster parameters:

         * `target_pgsql_version`: {{ PG }} version, must be the same as or higher than the version in the source cluster.
         * `target_user` and `target_password`: Username and password of the database owner.
      * (Optional) Virtual machine parameters:

         * `vm_image_id`: ID of the public [image](../../compute/operations/images-with-pre-installed-software/get-list) with Ubuntu and no GPU. For example, for [Ubuntu 20.04 LTS](https://cloud.yandex.com/en/marketplace/products/yc/ubuntu-20-04-lts).
         * `vm_username` and `vm_public_key`: Username and absolute path to a [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) that will be used to access the virtual machine. By default, the specified username is ignored in the [Ubuntu 20.04 LTS](https://cloud.yandex.com/en/marketplace/products/yc/ubuntu-20-04-lts) image: a user with the `ubuntu` username is created instead. Use it to connect to the instance.

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

### Create a database dump {#dump}

1. Switch the database to the <q>read-only</q> mode.
1. Create a dump using the [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html) utility. To speed up the process, run it in multithreaded mode by passing the number of available CPU cores in the `-j` argument:

   ```bash
   pg_dump -h <IP address or FQDN of source cluster's master host> \
           -U <username> \
           -j <number of processor cores> \
           -Fd -d <DB name> \
           -f ~/db_dump
   ```

1. Archive the dump:

   ```bash
   tar -cvzf db_dump.tar.gz ~/db_dump
   ```

### (Optional) Upload the dump to a virtual machine in {{ yandex-cloud }} {#create-vm}

Transfer your data to an intermediate VM in {{ compute-name }} if:

* Your {{ mpg-name }} cluster is not accessible from the internet.
* Your hardware or connection to the cluster in {{ yandex-cloud }} is not very reliable.

The required amount of RAM and processor cores depends on the amount of data to migrate and the required migration speed.

To prepare the virtual machine to restore the dump:

1. In the management console, [create a new VM](../../compute/operations/vm-create/create-linux-vm.md) from an [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) image on **{{ marketplace-name }}**. The VM parameters depend on the size of the database you want to migrate. The minimum configuration (1 core, 2 GB RAM, 10 GB disk space) should be sufficient to migrate a database that's up to 1 GB in size. The bigger the database being migrated, the more RAM and storage space you need (at least twice as large as the size of the database).


    The virtual machine must be in the same network and availability zone as the {{ PG }} cluster. Additionally, the VM must be assigned a public IP address so that you can load the dump from outside {{ yandex-cloud }}.

1. Set up the [{{ PG }} apt repository](https://www.postgresql.org/download/linux/ubuntu/).

1. Install the {{ PG }} client and additional utilities for working with the DBMS:

   ```bash
   sudo apt install postgresql-client-common

   # For PostgreSQL 10
   sudo apt install postgresql-client-10

   # For PostgreSQL 11
   sudo apt install postgresql-client-11

   # For PostgreSQL 12
   sudo apt install postgresql-client-12

   # For PostgreSQL 13
   sudo apt install postgresql-client-13

   # For PostgreSQL 14
   sudo apt install postgresql-client-14
   ```

1. Move the DB dump to the VM. For example, you can use `scp`:

   ```bash
   scp ~/db_dump.tar.gz <VM username>@<VM public address>:/tmp/db_dump.tar.gz
   ```

1. Unpack the dump:

   ```bash
   tar -xzf /tmp/db_dump.tar.gz
   ```

### Restore data from the dump to the target cluster {#restore}

Restore the database dump using the [pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html) utility.

The version of `pg_restore` must match the `pg_dump` version, and the major version must be at least as high as on the DB where the dump is deployed.

That is, to restore a dump of {{ PG }} 10, {{ PG }} 11, {{ PG }} 12, {{ PG }} 13, and {{ PG }} 14 use `pg_restore 10`, `pg_restore 11`, `pg_restore 12`, `pg_restore 13`, and `pg_restore 14`, respectively.

If you only need to restore a single schema, add the `-n <schema name>` flag (without it, the command only runs on behalf of the database owner). Best practice is to restore data with the `--single-transaction` flag to avoid an inconsistent state of the database if an error occurs:

```bash
pg_restore -h <IP address or FQDN of target cluster's master host> \
           -U <username>
           -d <DB name> \
           -p {{ port-mpg }} \
           -Fd -v \
           /tmp/db_dump \
           --single-transaction \
           --no-privileges
```

### Delete the resources you created {#clear-out-backup}

{% list tabs %}

* Manually created resources

   If you no longer need these resources, delete them:

   1. [Delete the {{ mpg-full-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).
   1. If you created an intermediate virtual machine, [delete it](../../compute/operations/vm-control/vm-delete.md).
   1. If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

* Resources created using {{ TF }}

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the configuration file `data-restore-pgsql-mpg.tf`.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the configuration file `data-restore-pgsql-mpg.tf` will be deleted.

{% endlist %}
