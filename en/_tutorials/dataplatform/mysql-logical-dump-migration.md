# Transferring data by creating and restoring a logical dump

To move data to a {{ mmy-name }} cluster, create a logical dump of the desired database and restore it to the target cluster. There are two ways to do this:

* Use the `mydumper` and `myloader` [utilities](https://github.com/mydumper/mydumper). A database dump is created as a collection of files in a separate folder.
* Use `mysqldump` and `mysql`. A database dump is created as a single file.

Migration stages:

1. [Create a dump](#dump) of the database you want to migrate.
1. Optionally, [upload a dump to an intermediate virtual machine](#vm-load) in {{ yandex-cloud }}.

    You need to transfer your data to the staging {{ compute-full-name }} VM in one of the following situations:

    * Your {{ mmy-name }} cluster is not accessible from the internet.
    * Your hardware or connection to the cluster in {{ yandex-cloud }} are not very reliable.

    The larger the amount of data to be migrated and the required migration speed, the higher the virtual machine requirements: number of processor cores, RAM, and disk space.

1. [Restore data from the dump](#restore).

If you no longer need the resources you created, [delete them](#clear-out).


## Required paid resources {#paid-resources-logical-dump}

* {{ mmy-name }} cluster, which includes computing resources allocated to hosts, storage and backup size (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
* Public IP addresses if public access is enabled for cluster hosts (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).
* Virtual machine if created to download a dump: use of computing resources, storage, public IP address, and OS (see [{{ compute-name }} pricing](../../compute/pricing.md)).


## Getting started {#before-you-begin}

Create the required resources:

{% list tabs group=instructions %}

- Manually {#manual}

    1. Create a [target {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-create.md) with your preferred configuration. For this operation, the following requirements apply:

        * The {{ MY }} version must be the same or higher than the version in the source cluster.

            Data transfer with a major {{ MY }} version upgrade is possible but not guaranteed. For more information, see [this {{ MY }} article](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

            Migration to an earlier {{ MY }} version is [not supported](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

        * [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

    1. Optionally, [create a VM](../../compute/operations/vm-create/create-linux-vm.md) based on [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) with the following parameters:

        * **{{ ui-key.yacloud.compute.instances.create.section_storages }}** → **{{ ui-key.yacloud.compute.disk-form.field_size }}**: Sufficient to store both archived and unarchived dumps.

            The recommended size is two or three times the total dump and dump archive size.

        * **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

            * **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}**: Choose a subnet within the target cluster’s cloud network.
            * **{{ ui-key.yacloud.component.compute.network-select.field_external }}**: Select either `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` or a reserverd IP address from the list.

    
    1. If you use security groups for the staging VM and the {{ mmy-name }} cluster, [configure them](../../managed-mysql/operations/connect/index.md#configure-security-groups).


- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../_includes/mdb/terraform/configure-provider.md) %}

    1. Download the [data-migration-mysql-mmy.tf](https://github.com/yandex-cloud-examples/yc-mysql-data-migration-from-on-premise/blob/main/data-migration-mysql-mmy.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../vpc/concepts/network.md#network).
        * [Subnet](../../vpc/concepts/network.md#subnet).
        * [Security group](../../vpc/concepts/security-groups.md) and the rule allowing inbound cluster connections.
        * {{ mmy-name }} cluster with public internet access.
        * Virtual machine with public internet access (optional).

    1. In `data-migration-mysql-mmy.tf`, specify the following:

        * Target cluster settings:

            * `target_mysql_version`: {{ MY }} version. This version must be the same or higher than the version in the source cluster.
            * `target_sql_mode`: [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode). It must be the same as in the source cluster.
            * `target_db_name`: Database name.
            * `target_user` and `target_password`: Database owner username and password.

        * Virtual machine parameters (optional):

            * `vm_image_id`: Public Ubuntu [image](../../compute/operations/images-with-pre-installed-software/get-list) ID (non-GPU), e.g., [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
            * `vm_username` and `vm_public_key`: Username and absolute path to the [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to use for access to the virtual machine. By default, the [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) image ignores the specified username, instead creating a user named `ubuntu`. Use it to connect to the VM.

    1. Validate your {{ TF }} configuration files using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will display any configuration errors detected in your files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Creating a dump {#dump}

{% list tabs %}

* Using the mysqldump utility

    1. Switch the database to <q>read-only</q> mode to avoid losing data that can appear while creating the dump.

    1. Install `mysqldump` in the source cluster, e.g., for Ubuntu:

        ```bash
        sudo apt update && sudo apt install mysql-client --yes
        ```

    1. Create a database dump:

        ```bash
        mysqldump \
            --host=<FQDN_or_IP_address> \
            --user=<username> \
            --password \
            --port=<port> \
            --set-gtid-purged=OFF \
            --quick \
            --single-transaction \
            <DB_name> > ~/db_dump.sql
        ```

        Where `--host` is the FQDN or IP address of the master host in the source cluster.

        If required, provide additional parameters in the create dump command:

        * `--events`, if there are recurring events in your database.
        * `--routines`, if your database stores procedures and functions.

        For InnoDB tables, use the `--single-transaction` option for data integrity.

    1. In the dump file, change the table engine names to `InnoDB`:

        ```bash
        sed -i -e 's/MyISAM/InnoDB/g' -e 's/MEMORY/InnoDB/g' db_dump.sql
        ```

    1. Archive the dump:

        ```bash
        tar -cvzf db_dump.tar.gz ~/db_dump.sql
        ```

* Using the mydumper utility

    1. Switch the database to <q>read-only</q> mode to avoid losing data that can appear while creating the dump.

    1. Create a directory for the dump files:

        ```bash
        mkdir db_dump
        ```

    1. Install `mydumper` in the source cluster, e.g., for Ubuntu:

        ```bash
        sudo apt update && sudo apt install mydumper --yes
        ```

    1. Create a database dump:

        ```bash
        mydumper \
            --triggers \
            --events \
            --routines \
            --outputdir=db_dump \
            --rows=10000000 \
            --threads=8 \
            --compress \
            --database=<DB_name> \
            --user=<username> \
            --ask-password \
            --host=<FQDN_or_IP_address>
        ```

        Where:

        * `--triggers`: Trigger dump.
        * `--events`: Event dump.
        * `--routines`: Stored procedure and function dump.
        * `--outputdir`: Dump file directory.
        * `--rows`: Number of rows in table fragments. The smaller the value, the more files in a dump.
        * `--threads`: Number of threads in use. The recommended value is equal to half the server's free cores.
        * `--compress`: Output file compression.
        * Where `--host` is the FQDN or IP address of the master host in the source cluster.

    1. In the dump file, change the table engine names to `InnoDB`:

        ```bash
        sed -i -e 's/MyISAM/InnoDB/g' -e 's/MEMORY/InnoDB/g' `find /db_dump -name '*-schema.sql'`
        ```

    1. Archive the dump:

        ```bash
        tar -cvzf db_dump.tar.gz ~/db_dump
        ```

{% endlist %}

## Uploading a dump to a virtual machine in {{ yandex-cloud }} (optional) {#vm-load}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to an intermediate virtual machine over SSH.

1. Copy the archive containing the database dump to the intermediate virtual machine, e.g., using `scp`:

    ```bash
    scp ~/db_dump.tar.gz <VM_user_name>@<VM_public_IP_address>:~/db_dump.tar.gz
    ```

1. Extract the dump from the archive:

    ```bash
    tar -xzf ~/db_dump.tar.gz
    ```

## Restoring data {#restore}

{% note alert %}

For {{ mmy-name }} clusters, [AUTOCOMMIT](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit) is enabled by default. **Do not disable** AUTOCOMMIT during the client session when restoring the database from the dump, otherwise the host storage may overflow and the cluster may not function properly.

{% endnote %}

{% list tabs %}

* Using the mysql utility

    This method is suitable if you used `mysqldump` to create the dump.

    1. Install the `mysql` utility to the host you are using to restore the dump, e.g., for Ubuntu:

        ```bash
        sudo apt update && sudo apt install mysql-client --yes
        ```

    1. Start the database restore from the dump:

        * If you restore a dump from the VM in {{ yandex-cloud }}:

            ```bash
            mysql \
                --host=c-<target_cluster_ID>.rw.{{ dns-zone }} \
                --user=<username> \
                --port={{ port-mmy }} \
                <DB_name> < ~/db_dump.sql
            ```

        * If you are restoring the dump from a host connecting to {{ yandex-cloud }} from the internet, [get an SSL certificate](../../managed-mysql/operations/connect/index.md#get-ssl-cert) and provide the `--ssl-ca` and the `--ssl-mode` parameters in the restore command:

            ```bash
            mysql \
                --host=c-<target_cluster_ID>.rw.{{ dns-zone }} \
                --user=<username> \
                --port={{ port-mmy }} \
                --ssl-ca=~/.mysql/root.crt \
                --ssl-mode=VERIFY_IDENTITY \
                <DB_name> < ~/db_dump.sql
            ```

* Using the myloader utility

    This method is suitable if you created the dump with `mydumper` and are using an intermediate virtual machine to restore it.

    1. Install the `myloader` utility to the host you are using to restore the dump, e.g., for Ubuntu:

        ```bash
        sudo apt update && sudo apt install mydumper --yes
        ```

    1. Start the database restore from the dump:

        ```bash
        myloader \
            --host=c-<target_cluster_ID>.rw.{{ dns-zone }} \
            --directory=db_dump/ \
            --overwrite-tables \
            --threads=8 \
            --compress-protocol \
            --user=<username> \
            --ask-password
        ```

{% endlist %}

You can get the cluster ID from the [list of clusters in your folder](../../managed-mysql/operations/cluster-list.md#list-clusters).

## Deleting the created resources {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs group=instructions %}

- Manually {#manual}

    * [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).
    * If you created a staging virtual machine, [delete it](../../compute/operations/vm-control/vm-delete.md).
    * If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

- {{ TF }} {#tf}

    {% include [terraform-clear-out](../../_includes/mdb/terraform/clear-out.md) %}

{% endlist %}
