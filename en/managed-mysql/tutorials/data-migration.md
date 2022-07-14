# Migrating databases from a third-party {{ MY }} cluster to {{ mmy-name }}

{% note info %}

Data migration to a third-party {{ MY }} cluster is described in [{#T}](../../managed-mysql/tutorials/mmy-to-mysql-migration.md).

{% endnote %}

There are two ways to migrate data from a third-party _source cluster_ to a {{ mmy-name }} _target cluster_:

* [{#T}](#data-transfer).

   This method is easy to configure, does not require the creation of an intermediate VM, and lets you transfer the entire database without interrupting user service. To use it, allow connections to the source cluster from the internet.
   For more information, see [{#T}](../../data-transfer/concepts/use-cases.md).

* [{#T}](#logical-dump).

   A _logical dump_ is a file with a set of commands running which one by one you can restore the state of a database. To ensure that a logical dump is complete, before creating it, switch the source cluster to <q>read-only</q> mode.

   Use this method only if, for some reason, it's not possible to transfer data using {{ data-transfer-full-name }}.

## Before you begin {#before-you-begin}

[Create a {{ mmy-name }} cluster](../operations/cluster-create.md) with any suitable configuration. In this case:

* The {{ MY }} version must be the same or higher than the version in the source cluster.

   Transferring data with an increase in the {{ MY }} major version is possible, but not guaranteed. For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

   Migration with a {{ MY }} version downgrade is [impossible](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

* [SQL mode](../concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

## Transferring data using {{ data-transfer-full-name }} {#data-transfer}

{% include notitle [Migration with Data Trasnfer](../../_tutorials/datatransfer/managed-mysql.md) %}

## Transferring data by creating and restoring a logical dump {#logical-dump}

To move data to a {{ mmy-name }} cluster, create a logical dump of the desired database and restore it to the target cluster. You can do this using two methods:

* Using the [`mydumper` and the `myloader` utilities](https://github.com/mydumper/mydumper). A database dump is created as a collection of files in a separate folder.
* Using the `mysqldump` and the `mysql` utilities. A database dump is created as a single file.

Migration stages:

1. [Create a dump](#dump) of the database you want to migrate.
1. If necessary, [create an intermediate VM](#create-vm) in {{ yandex-cloud }} and upload the dump to it.
1. [Restore data from the dump](#restore).

{% if audience != "internal" %}

If you no longer need these resources, [delete them](#clear-out).

{% endif %}

### Creating a dump {#dump}

{% list tabs %}

* Using the mysqldump utility

   1. Switch the database to <q>read-only mode</q> to avoid losing the data that might be generated while the dump is being created.

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

      * `--events` — If there are recurring events in your database.
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

   1. Switch the database to <q>read-only mode</q> to avoid losing the data that might be generated while the dump is being created.

   1. Create a directory for the dump files:

      ```bash
      mkdir db_dump
      ```

   1. Install the `mydumper` utility on the source cluster as follows (Ubuntu):

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

### (optional) Creating a VM in {{ yandex-cloud }} and uploading a dump {#create-vm}

Transfer your data to an intermediate VM in {{ compute-full-name }} if:

* Your {{ mmy-name }} cluster is not accessible from the internet.
* Your hardware or connection to the cluster in {{ yandex-cloud }} is not very reliable.

The required amount of RAM, processor cores, and disk space depends on the amount of data to migrate and the required migration speed.

To prepare the virtual machine to restore the dump:
{% if audience != "internal" %}

1. [Create a VM](../../compute/operations/vm-create/create-linux-vm.md) on the [Ubuntu Linux 20.04](/marketplace/products/yc/ubuntu-20-04-lts) image from the {{ marketplace-name }} with the following parameters:

{% else %}

1. Create a virtual machine running [Ubuntu Linux 20.04]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/f2eanb2gaki4us67hn9q){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/marketplace/products/f2eanb2gaki4us67hn9q){% endif %} with the following parameters:

{% endif %}

    * **Disks and file storage** → **Size**: Sufficient to store both archived and unarchived dumps.

        The recommended size is two or three times the total dump and dump archive size.

    * **Network settings**:

        * **Subnet**: Select a subnet on the cloud network hosting the target cluster.
        * **Public address**: `Auto` or select from a list of reserved IPs.

1. [Set up security groups](../operations/connect.md#configure-security-groups) for the intermediate VM and the {{ mmy-name }} cluster.

1. {% if audience != "internal" %}[Connect to an intermediate virtual machine over SSH](../../compute/operations/vm-connect/ssh.md).{% else %}Connect to an intermediate virtual machine over SSH.{% endif %}

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

      * If you are restoring your dump from a host connecting to {{ yandex-cloud }} from the internet, [obtain an SSL certificate](../operations/connect.md#get-ssl-cert) and transmit the `--ssl-ca` and the `--ssl-mode` parameters in the restore command:

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

You can get the cluster ID with a [list of clusters in the folder](../operations/cluster-list.md#list-clusters).

{% if audience != "internal" %}

### Deletе created resources {#clear-out}

If you no longer need these resources, delete them:

1. If you created an intermediate virtual machine, [delete it](../../compute/operations/vm-control/vm-delete.md).
1. If you reserved a public static IP address for your intermediate virtual machine, release and [delete it](../../vpc/operations/address-delete.md).

{% endif %}
