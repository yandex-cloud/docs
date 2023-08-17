# Migrating databases from a third-party {{ MY }} cluster to a {{ mmy-full-name }} cluster

There are two ways to migrate data from a third-party _source cluster_ to a {{ mmy-name }} _target cluster_:

* [Transferring data using {{ data-transfer-full-name }}](#data-transfer).

   This method is easy to configure, does not require the creation of an intermediate VM, and lets you transfer the entire database without interrupting user service. To use it, allow connections to the source cluster from the internet.

   For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

* [Transferring data by creating and restoring a logical dump](#logical-dump).

   A _logical dump_ is a file with a set of commands running which one by one you can restore the state of a database. To ensure that a logical dump is complete, before creating it, switch the source cluster to <q>read-only</q> mode.

   Use this method only if, for some reason, it's not possible to migrate data using {{ data-transfer-name }}.

## Transferring data using {{ data-transfer-name }} {#data-transfer}

{% include notitle [Migration with Data Transfer](../../_tutorials/datatransfer/managed-mysql.md) %}

## Transferring data by creating and restoring a logical dump {#logical-dump}

To move data to a {{ mmy-name }} cluster, create a logical dump of the desired database and restore it to the target cluster. You can do this using two methods:

* Using the `mydumper` and the `myloader` [utilities](https://github.com/mydumper/mydumper). A database dump is created as a collection of files in a separate folder.
* Using the `mysqldump` and the `mysql` utilities. A database dump is created as a single file.

Migration stages:

1. [Create a dump](#dump) of the database you want to migrate.
1. (Optional) [Upload a dump to an intermediate virtual machine](#vm-load) in {{ yandex-cloud }}.

   Transfer your data to an intermediate VM in {{ compute-full-name }} if:

   * Your {{ mmy-name }} cluster is not accessible from the internet.
   * Your hardware or connection to the cluster in {{ yandex-cloud }} is not very reliable.

   The larger the amount of data to be migrated and the required migration speed, the higher the virtual machine requirements: number of processor cores, RAM, and disk space.

1. [Restore data from the dump](#restore).

If you no longer need the resources you created, [delete them](#clear-out).

### Getting started {#before-you-begin}

Create the required resources:

{% list tabs %}

* Manually

   1. Create a [{{ mmy-name }} target cluster](../../managed-mysql/operations/cluster-create.md) with any suitable configuration. In this case:

      * The {{ MY }} version must be the same or higher than the version in the source cluster.

         Transferring data with an increase in the {{ MY }} major version is possible, but not guaranteed. For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

         Migration with a {{ MY }} version downgrade is [impossible](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

      * [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

   1. (Optional step) [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) based on [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) with the following parameters:

      * **Disks and file storage** → **Size**: Sufficient to store both archived and unarchived dumps.

         The recommended size is two or three times the total dump and dump archive size.

      * **Network settings**:

         * **Subnet**: Select a subnet on the cloud network hosting the target cluster.
         * **Public address**: Select `Auto` or one address from a list of reserved IPs.

   
   1. If you use security groups for the intermediate VM and the {{ mmy-name }} cluster, [configure them](../../managed-mysql/operations/connect.md#configure-security-groups).

      {% include [preview-pp.md](../../_includes/preview-pp.md) %}


* Using Terraform

   1. If you do not have {{ TF }} yet, [install and configure it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
   1. Download the configuration file [data-migration-mysql-mmy.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/data-migration-mysql-mmy/data-migration-mysql-mmy.tf) to the same working directory.

      This file describes:

      * [Network](../../vpc/concepts/network.md#network).
      * [Subnet](../../vpc/concepts/network.md#subnet).
      * [Security groups](../../vpc/concepts/security-groups.md) and the rule required to connect to a cluster.
      * {{ mmy-name }} cluster with public internet access.
      * (Optional) Virtual machine with public internet access.

   1. Specify in the file `data-migration-mysql-mmy.tf`:

      * Target cluster parameters:

         * `target_mysql_version`: {{ MY }} version must be the same or higher than the version in the source cluster.
         * `target_sql_mode`: [SQL mode](../../managed-mysql/concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.
         * `target_db_name`: Database name.
         * `target_user` and `target_password`: Database owner username and password.

      * (Optional) Virtual machine parameters:

         * `vm_image_id`: ID of the public [image](../../compute/operations/images-with-pre-installed-software/get-list) with Ubuntu and no GPU, e.g., [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
         * `vm_username` and `vm_public_key`: Username and absolute path to a [public key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) that will be used to access the virtual machine. By default, the specified username is ignored in the [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) image. Instead, a user with the `ubuntu` username is created. Use it to connect to the instance.

   1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Create the required infrastructure:

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

### Creating a dump {#dump}

{% list tabs %}

* Using the mysqldump utility

   1. Switch the database to <q>read-only</q> mode to avoid losing data that can appear while creating the dump.

   1. Install the `mysqldump` utility in the source cluster as follows (Ubuntu):

      ```bash
      sudo apt update && sudo apt install mysql-client --yes
      ```

   1. Create a database dump:

      ```bash
      mysqldump \
          --host=<source cluster master host FQDN or IP> \
          --user=<username> \
          --password \
          --port=<port> \
          --set-gtid-purged=OFF \
          --quick \
          --single-transaction \
          <database name> > ~/db_dump.sql
      ```

      If necessary, pass additional parameters in the create dump command:

      * `--events`: If there are recurring events in your database.
      * `--routines`: If your database has stored procedures and functions.

      For InnoDB tables, use the `--single-transaction` option to guarantee data integrity.

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

   1. Install the `mydumper` utility in the source cluster as follows (Ubuntu):

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
          --database=<database name> \
          --user=<username> \
          --ask-password \
          --host=<source cluster master host FDQN or IP>
      ```

      Where:

      * `--triggers`: Trigger dump.
      * `--events`: Event dump.
      * `--routines`: Stored procedure and function dump.
      * `--outputdir`: Dump file directory.
      * `--rows`: Number of rows in table fragments. The smaller the value, the more files in a dump.
      * `--threads`: Number of threads used. The recommended value is equal to half the server's free cores.
      * `--compress`: Output file compression.

   1. In the dump file, change the table engine names to `InnoDB`:

      ```bash
      sed -i -e 's/MyISAM/InnoDB/g' -e 's/MEMORY/InnoDB/g' `find /db_dump -name '*-schema.sql'`
      ```

   1. Archive the dump:

      ```bash
      tar -cvzf db_dump.tar.gz ~/db_dump
      ```

{% endlist %}

### (Optional) Uploading a dump to a virtual machine in {{ yandex-cloud }} {#vm-load}

1. [Connect](../../compute/operations/vm-connect/ssh.md) to an intermediate virtual machine over SSH.

1. Copy the archive containing the database dump to the intermediate virtual machine using the `scp` utility, for instance:

   ```bash
   scp ~/db_dump.tar.gz <VM username>@<VM public IP>:~/db_dump.tar.gz
   ```

1. Extract the dump from the archive:

   ```bash
   tar -xzf ~/db_dump.tar.gz
   ```

### Restoring data {#restore}

{% note alert %}

For {{ mmy-name }} clusters, [AUTOCOMMIT](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit) is enabled by default. **Do not disable** AUTOCOMMIT during the client session when restoring the database from the dump, otherwise the host storage may overflow and the cluster may not function properly.

{% endnote %}

{% list tabs %}

* Using the mysql utility

   This method is suitable if you created your dump with the `mysqldump` utility.

   1. Install the `mysql` utility on the host the dump is being restored from as follows (Ubuntu):

      ```bash
      sudo apt update && sudo apt install mysql-client --yes
      ```

   1. Start the database restore from the dump:

      * If you restore a dump from the VM in {{ yandex-cloud }}:

         ```bash
         mysql \
             --host=c-<target cluster ID>.rw.{{ dns-zone }} \
             --user=<username> \
             --port={{ port-mmy }} \
             <database name> < ~/db_dump.sql
         ```

      * If you are restoring your dump from a host connecting to {{ yandex-cloud }} from the internet, [obtain an SSL certificate](../../managed-mysql/operations/connect.md#get-ssl-cert) and transmit the `--ssl-ca` and the `--ssl-mode` parameters in the restore command:

         ```bash
         mysql \
             --host=c-<target cluster ID>.rw.{{ dns-zone }} \
             --user=<username> \
             --port={{ port-mmy }} \
             --ssl-ca=~/.mysql/root.crt \
             --ssl-mode=VERIFY_IDENTITY \
             <database name> < ~/db_dump.sql
         ```

* Using the myloader utility

   This method is suitable if you created your dump using the `mydumper` utility and are using an intermediate virtual machine for the restore.

   1. Install the `myloader` utility to the host that you are using to restore the dump as follows (Ubuntu):

      ```bash
      sudo apt update && sudo apt install mydumper --yes
      ```

   1. Start the database restore from the dump:

      ```bash
      myloader \
          --host=c-<target cluster ID>.rw.{{ dns-zone }} \
          --directory=db_dump/ \
          --overwrite-tables \
          --threads=8 \
          --compress-protocol \
          --user=<username> \
          --ask-password
      ```

{% endlist %}

You can get the cluster ID with a [list of clusters in the folder](../../managed-mysql/operations/cluster-list.md#list-clusters).

### Deletе created resources {#clear-out}

Delete the resources you no longer need to avoid paying for them:

{% list tabs %}

* Manually

   * [Delete the {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-delete.md).
   * If you created an intermediate virtual machine, [delete it](../../compute/operations/vm-control/vm-delete.md).
   * If you reserved public static IP addresses, release and [delete them](../../vpc/operations/address-delete.md).

* Using Terraform

   To delete the infrastructure created with {{ TF }}:

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the configuration file `data-migration-mysql-mmy.tf`.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      All the resources described in the configuration file `data-migration-mysql-mmy.tf` will be deleted.

{% endlist %}
