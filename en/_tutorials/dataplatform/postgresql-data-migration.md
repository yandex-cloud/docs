# Migrating a database from a third-party {{ PG }} cluster to {{ mpg-name }}

You can migrate data from a third-party _source cluster_ to a {{ mpg-name }} _target cluster_ using the following three methods:

* [Migrating data via {{ data-transfer-full-name }}](#data-transfer).

    This method enables you to:

    * Eliminate the need for an intermediate VM or public internet access to your {{ mpg-name }} target cluster.
    * Migrate the entire database with zero downtime.
    * Migrate from older {{ PG }} versions to newer ones, e.g., upgrading the cluster’s {{ PG }} version from 15 to 16.

    To use this method, enable public access to the source cluster.

    For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

* [Migrating data via logical replication](#logical-replication).

    [_Logical replication_](https://www.postgresql.org/docs/current/logical-replication.html) uses the [subscription](https://www.postgresql.org/docs/current/sql-createsubscription.html) mechanism, allowing you to migrate data to the target cluster with minimal downtime.

    Use this method only if data migration via {{ data-transfer-full-name }} is impossible.

* [Migrating data using a logical dump (backup and restore)](#backup).

    A _logical dump_ is a file containing a sequence of commands allowing you to restore a database to its saved state. You can create a logical dump using `pg_dump`. To ensure the logical dump is complete, switch the source cluster to <q>read-only</q> mode before creating the dump.

    Use this method only if data migration using other methods is impossible.

{% note warning %}

Users are not transferred automatically to a {{ mpg-name }} cluster. You need to [create](../../managed-postgresql/operations/cluster-users.md#adduser) them in the new cluster from scratch.

{% endnote %}

## Migrating data via {{ data-transfer-full-name }} {#data-transfer}

{% include notitle [PostgreSQL migration with Data Transfer](../../_tutorials/dataplatform/datatransfer/managed-postgresql.md) %}

## Migrating data via logical replication {#logical-replication}

Logical replication is supported in {{ PG }} starting from version 10. Logical replication supports both migrations within the same {{ PG }} version and upgrades to higher ones.

In {{ mpg-name }} clusters, subscriptions can be used by the database owner (a user created alongside the cluster) and users with the `mdb_admin` role for that cluster.

Migration stages:

1. [Configure the source cluster](#source-setup).
1. [Export the database schema in the source cluster](#source-schema-export).
1. [Restore the database schema in the target cluster](#restore-schema).
1. [Create a {{ PG }} publication and subscription](#create-publication-subscription).
1. [Migrate the {{ PG }} sequence once the replication is complete](#transfer-sequences).
1. [Disable replication and transfer the workload](#transfer-load).

If you no longer need the resources you created, [delete them](#clear-out-logical).


### Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mpg-name }} cluster fee: Covers the use of computing resources allocated to hosts and disk storage (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


### Getting started {#before-you-begin-logical}

Create the required resources:

{% list tabs group=instructions %}

- Manually {#manual}

    Create a [target {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md) with your preferred configuration. For this operation, the following requirements apply:

    * The {{ PG }} version must be the same or higher than the version in the source cluster. Migration to an earlier {{ PG }} version is not supported.
    * When creating a cluster, specify the same database name as in the source cluster.
    * Enable the same [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) as in the source cluster.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-migration-pgsql-mpg.tf](https://github.com/yandex-cloud-examples/yc-postgresql-data-migration-from-on-premise/blob/main/data-migration-pgsql-mpg.tf) configuration file to your current working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and the rule allowing inbound cluster connections.
        * {{ mpg-name }} cluster with public internet access.

    1. In the `data-migration-pgsql-mpg.tf` file, specify the following:

        * `target_db_name`: Database name.
        * `pg-extensions`: List of [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) in the source cluster.
        * Target cluster settings:

            * `target_pgsql_version`: {{ PG }} version. This version must be the same or higher than the version in the source cluster.
            * `target_user` and `target_password`: Database owner username and password.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Configure the source cluster {#source-setup}

1. Make changes to the source cluster’s configuration and authentication settings. To do this, edit the `postgresql.conf` and `pg_hba.conf` files. On Debian and Ubuntu distributions, these files reside in the `/etc/postgresql/<{{ PG }}_version>/main/` directory by default:

    1. Set the maximum number of user connections. To do this, update the `max_connections` setting in `postgresql.conf`:

        ```ini
        max_connections = <number_of_connections>
        ```
        
        Where `<number_of_connections>` is the maximum number of connections. This value must be equal or higher than `N + 1`, where `N` is the number of all possible connections to your {{ PG }} server. 

        In the `N + 1` formula, the `1` represents an additional connection reserved for the logical replication subscription. If you plan to use multiple subscriptions, change this value accordingly.

        You can check the current number of connections using the `pg_stat_activity` system table:

        ```sql
        SELECT count(*) FROM pg_stat_activity;
        ```

    1. Configure the [Write Ahead Log (WAL)](https://www.postgresql.org/docs/current/static/wal-intro.html) log level by setting [wal_level](https://www.postgresql.org/docs/current/runtime-config-wal.html#RUNTIME-CONFIG-WAL-SETTINGS) to `logical` in `postgresql.conf`:

        ```ini
        wal_level = logical
        ```

    1. Optionally, configure SSL to enable data encryption and compression. To turn SSL on, specify the following in `postgresql.conf`:

        ```ini
        ssl = on
        ```
    
    1. Enable cluster access by updating the `listen_addresses` [setting](https://www.postgresql.org/docs/current/runtime-config-connection.html#GUC-LISTEN-ADDRESSES) in `postgresql.conf`. For example, to make the source cluster accept connection requests from all IP addresses, specify the following:

        ```ini
        listen_addresses = '*'
        ```

    1. Configure authentication in the `pg_hba.conf` file:

        {% list tabs %}

        - SSL

            ```txt
            hostssl         all            all             <connection_IP_address>      md5
            hostssl         replication    all             <connection_IP_address>      md5
            ```

        - Without SSL

            ```txt
            host         all            all             <connection_IP_address>      md5
            host         replication    all             <connection_IP_address>      md5
            ```

        {% endlist %}

        Where `<connection_IP_address>` can be either a specific IP address or an IP address range. For example, to allow access from the {{ yandex-cloud }} network, you can specify [all public IP addresses](../../overview/concepts/public-ips.md) in {{ yandex-cloud }}.

1. If the source cluster uses a firewall, configure it to allow inbound connections from the required IP addresses.

1. Restart {{ PG }} for the settings to apply:

   ```bash
   sudo systemctl restart postgresql
   ```

1. Check the {{ PG }} status after restart:

   ```bash
   sudo systemctl status postgresql
   ```

### Export the database schema in the source cluster {#source-schema-export}

Using `pg_dump`, create a file containing the database schema that you will deploy in the target cluster.

```bash
pg_dump -h <IP_address_or_FQDN_for_master_host_of_source_cluster> \
        -U <username> \
        -p <port> \
        --schema-only \
        --no-privileges \
        --no-subscriptions \
        -d <DB_name> \
        -Fd -f /tmp/db_dump
```

This export command excludes all privilege and role data to prevent conflicts with the target {{ yandex-cloud }} database configuration. If you need additional database users, [create them](../../managed-postgresql/operations/cluster-users.md#adduser).

### Restore the database schema in the target cluster {#restore-schema}

Use `pg_restore` to restore the database schema in the target cluster:

```bash
pg_restore -h <IP_address_or_FQDN_for_master_host_of_target_cluster> \
           -U <username> \
           -p {{ port-mpg }} \
           -Fd -v \
           --single-transaction \
           -s --no-privileges \
           -d <DB_name> /tmp/db_dump
```

### Create a publication and a subscription {#create-publication-subscription}

For logical replication to work, create a publication (a group of logically replicated tables) on the source cluster and a subscription (a description of the connection to another database) on the target cluster.

1. On the source cluster, create a publication for all tables in the database. When migrating multiple databases, you need to create a separate publication for each one.

   {% note info %}

   Creating a publication for all tables requires superuser privileges, while creating one for specific tables does not. To learn more about creating publications, see [this {{ PG }} article](https://www.postgresql.org/docs/current/sql-createpublication.html).

   {% endnote %}

   Query:

   ```sql
   CREATE PUBLICATION p_data_migration FOR ALL TABLES;
   ```

1. On the target {{ mpg-name }} cluster host, create a subscription with the connection string pointing to the source publication. To learn more about creating subscriptions, see [this {{ PG }} article](https://www.postgresql.org/docs/current/sql-createsubscription.html).

   Query with SSL:

   ```sql
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<source_cluster_address> port=<port> user=<username> sslmode=verify-full dbname=<DB_name>' PUBLICATION p_data_migration;
   ```

   Query without SSL:

   ```sql
   CREATE SUBSCRIPTION s_data_migration CONNECTION 'host=<source_cluster_address> port=<port> user=<username> sslmode=disable dbname=<DB_name>' PUBLICATION p_data_migration;
   ```
   {% note tip %}

   By default, the `CREATE SUBSCRIPTION` statement also creates a replication slot. To attach a subscription to an existing replication slot and avoid creating a new one, add `create_slot = false` to the statement.

   {% endnote %}

1. To get the replication status, check the `pg_subscription_rel` folders. To review general replication status, check `pg_stat_subscription` for the target cluster, and `pg_stat_replication` for the source cluster.

   ```sql
   SELECT * FROM pg_subscription_rel;
   ```

   First, inspect the `srsubstate` field. A value of `r` in this field indicates that the initial synchronization is complete and the databases are ready for replication.

### Migrate {{ PG }} sequences once the replication is complete {#transfer-sequences}

To complete synchronization between the source cluster and the target cluster:

1. Set the source cluster to <q>read-only</q> mode.
1. In the source cluster, create a {{ PG }}-database dump that includes sequences:

   ```bash
   pg_dump -h <IP_address_or_FQDN_for_master_host_of_source_cluster> \
           -U <username> \
           -p <port> \
           -d <DB_name> \
           --data-only -t '*.*_seq' > /tmp/seq-data.sql
   ```

   Note the `*.*_seq` pattern we use. If your source database has sequences that do not match this pattern, use a different pattern to export them.

   To learn more about patterns, see [this {{ PG }} article](https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-PATTERNS).

1. Restore the dump containing sequences into your target cluster:

   ```bash
   psql -h <IP_address_or_FQDN_for_master_host_of_target_cluster> \
        -U <username> \
        -p {{ port-mpg }} \
        -d <DB_name> \
        < /tmp/seq-data.sql
   ```

### Delete the subscription and transfer the workload {#transfer-load}

1. Delete the subscription in the target cluster:

    ```sql
    DROP SUBSCRIPTION s_data_migration;
   ```

1. Switch the workload to the target cluster.

### Delete the resources you created {#clear-out-logical}

To avoid paying for the resources you no longer need, delete them:

{% list tabs group=instructions %}

- Manually {#manual}

    [Delete the {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}

## Migrating data using a logical dump (backup and restore) {#backup}

In the source cluster, use `pg_dump` to create a dump of the database you want to migrate. Use `pg_restore` to restore the dump in the target cluster.

{% note info %}

To use `pg_restore`, you may need to install the `pg_repack` database extension.

{% endnote %}

Migration stages:

1. [Create a dump of the database you want to migrate](#dump).
1. [Optionally, create a {{ yandex-cloud }} VM and upload your database dump to it](#create-vm).
1. [Restore the data from the dump into the target cluster](#restore).

If you no longer need the resources you created, [delete them](#clear-out-backup).


### Required paid resources {#paid-resources}

The support cost for this solution includes:

* {{ mpg-name }} cluster fee: Covers the use of computing resources allocated to hosts and disk storage (see [{{ mpg-name }} pricing](../../managed-postgresql/pricing.md)).
* Fee for using public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* VM fee: Covers the use of computing resources, the OS, and the storage (see [{{ compute-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address assigned to your VM (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).


### Getting started {#before-you-begin-backup}

Create the required resources:

{% list tabs group=instructions %}

- Manually {#manual}

    1. Create a [target {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md) with your preferred configuration. The following target cluster settings must match the corresponding settings in the source cluster:

        * {{ PG }} version.
        * Username.

            {% include [user-name-restore](../../_includes/mdb/mpg/note-user-name-restore.md) %}

        * [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md).

    1. Optionally, [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) running [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) with the following settings:

        * **{{ ui-key.yacloud.compute.instances.create.section_storages }}** → **{{ ui-key.yacloud.compute.disk-form.field_size }}**: Sufficient to store both archived and unarchived dumps.

            The recommended size is at least twice the combined size of the dump and its archive.

        * **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

            * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: Choose a subnet within the target cluster’s cloud network.
            * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: Select either `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` or a reserverd IP address from the list.

    
    1. If you use security groups for the staging VM and the {{ mpg-name }} cluster, [configure them](../../managed-postgresql/operations/connect.md#configure-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-restore-pgsql-mpg.tf](https://github.com/yandex-cloud-examples/yc-postgresql-data-migration-from-on-premise/blob/main/data-restore-pgsql-mpg.tf) configuration file to your current working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and the rule allowing inbound cluster connections.
        * {{ mpg-name }} cluster with public internet access.
        * Virtual machine with public internet access. This is an optional setting.

    1. In the `data-restore-pgsql-mpg.tf` file, specify the following:

        * `pg-extensions`: List of [{{ PG }} extensions](../../managed-postgresql/operations/extensions/cluster-extensions.md) in the source cluster.
        * Target cluster settings:

            * `target_pgsql_version`: {{ PG }} version. This version must be the same or higher than the version in the source cluster.
            * `target_db_name`: Database name.
            * `target_user`: Database owner username. This username must match the username in the source cluster.

                {% include [user-name-restore](../../_includes/mdb/mpg/note-user-name-restore.md) %}

            * `target_password`: Database owner password.
        * Virtual machine settings (optional):

            * `vm_image_id`: Public Ubuntu [image](../../compute/operations/images-with-pre-installed-software/get-list) ID (non-GPU), e.g., for [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
            * `vm_username` and `vm_public_key`: Username and absolute path to the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to use for access to the virtual machine. By default, the [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) image ignores the specified username, instead creating a user named `ubuntu`. Use it to connect to the VM.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Create a database dump {#dump}

1. Switch the database to <q>read-only</q> mode.
1. Create a dump using [pg_dump](https://www.postgresql.org/docs/current/app-pgdump.html). To speed up the process, run `pg_dump` in multithreaded mode using the `--jobs` argument to provide the number of available CPU cores:

    ```bash
    pg_dump --host=<IP_address_or_FQDN_for_master_host_of_source_cluster> \
            --port=<port> \
            --username=<username> \
            --jobs=<number_of_CPU_cores> \
            --format=d \
            --dbname=<DB_name> \
            --file=db_dump
    ```

### Optionally, upload the dump to a {{ yandex-cloud }} VM {#create-vm}

You need to transfer your data to the staging {{ compute-name }} VM in one of the following situations:

* Your {{ mpg-name }} cluster is not accessible from the internet.
* Your hardware or connection to the cluster in {{ yandex-cloud }} are not very reliable.

The required amount of RAM and the number of CPU cores depend on the volume of data transferred and the required transfer speed.

To prepare your virtual machine for dump recovery:

1. In the management console, [create a new VM](../../compute/operations/vm-create/create-linux-vm.md) using an [Ubuntu 20.04](/marketplace/products/yc/ubuntu-20-04-lts) image from **{{ ui-key.yacloud.compute.instances.create.image_value_marketplace }}**. The VM configuration will depend on the size of the database you want to migrate. The minimum configuration (1 CPU core, 2 GB RAM, 10 GB disk space) should be sufficient to migrate a database of up to 1 GB. Larger databases require more RAM and disk space. The disk space should be at least twice the database size.


    The VM must be in the same network and availability zone as the {{ PG }} cluster. The VM must have a public IP address to enable uploading the dump from outside {{ yandex-cloud }}.

1. Set up the [{{ PG }} apt repository](https://www.postgresql.org/download/linux/ubuntu/).

1. Install the {{ PG }} client and database management tools:

    ```bash
    sudo apt install postgresql-client-common && \
    sudo apt install postgresql-client-<{{ PG }}_version>
    ```

1. Archive the dump:

    ```bash
    tar -cvzf db_dump.tar.gz db_dump
    ```

1. Transfer the dump archive to the VM using `scp` or another tool of your choice:

    ```bash
    scp db_dump.tar.gz <VM_user_name>@<VM_public_address>:/db_dump.tar.gz
    ```

1. [Connect to the VM](../../compute/operations/vm-connect/ssh.md).

1. Unpack the dump archive:

    ```bash
    tar -xzf db_dump.tar.gz
    ```

### Restore data from the dump into the target cluster {#restore}

Restore the database dump with [pg_restore](https://www.postgresql.org/docs/current/app-pgrestore.html).

The `pg_restore` version must match the `pg_dump` version. Furthermore, its major version must be at least as high as the major version of the target database.

That is, to restore a dump from {{ PG }} 14, {{ PG }} 15, and {{ PG }} 16, use `pg_restore 15`, `pg_restore 16`, and `pg_restore 14`, respectively.

```bash
pg_restore --host=<IP_address_or_FQDN_for_master_host_of_target_cluster> \
           --username=<username> \
           --dbname=<DB_name> \
           --port={{ port-mpg }} \
           --format=d \
           --verbose \
           db_dump \
           --single-transaction \
           --no-privileges
```

If you only need to restore a single schema, add `--schema=<schema_name>` to the command. Without this argument, the command will only succeed when run by the database owner.

If the recovery process fails due to insufficient permissions for creating or updating extensions, remove the `--single-transaction` flag from the command. In this case, the system will ignore such errors:

```text
pg_restore: warning: errors ignored on restore: 3
```

Verify that the errors only affect extensions and check the integrity of the restored data.

### Delete the resources you created {#clear-out-backup}

To avoid paying for the resources you no longer need, delete them:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Delete the {{ mpg-full-name }} cluster](../../managed-postgresql/operations/cluster-delete.md).
    * If you created a staging virtual machine, [delete it](../../compute/operations/vm-control/vm-delete.md).
    * If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
