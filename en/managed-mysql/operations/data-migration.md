# Migrating databases to {{ mmy-name }}

There are two ways to migrate data from a third-party _source cluster_ to a {{ mmy-name }} _target cluster_:

* [{#T}](#data-transfer).

    This method is easy to configure, does not require the creation of an intermediate VM, and lets you transfer the entire database without interrupting user service. To use it, allow connections to the source cluster from the internet.
    For more information, see [{#T}](../../data-transfer/concepts/solutions.md).

* [{#T}](#logical-dump).

    _A logical dump_ is a file with a set of commands running which one by one you can restore the state of a database. To ensure that a logical dump is complete, before creating it, switch the source cluster to <q>read-only</q> mode.

    Use this method only if, for some reason, it's not possible to transfer data using {{ data-transfer-full-name }}.

## Before you start {#before-you-begin}

[Create a {{ mmy-name }} cluster](./cluster-create.md) with any suitable configuration. In this case:

* The {{ MY }} version must be the same or higher than the version in the source cluster.

    Transferring data with an increase in the {{ MY }} major version is possible, but not guaranteed. For more information, see the [{{ MY }} documentation](https://dev.mysql.com/doc/refman/8.0/en/faqs-migration.html).

    Migration with a downgrade of the {{ MY }} version is [not supported](https://dev.mysql.com/doc/refman/8.0/en/downgrading.html).

* [SQL mode](../concepts/settings-list.md#setting-sql-mode) must be the same as in the source cluster.

## Transferring data using {{ data-transfer-full-name }} {#data-transfer}

1. [Prepare the source cluster](../../data-transfer/operations/prepare.md#prepare-source-my).

1. [Prepare the target cluster](../../data-transfer/operations/prepare.md#prepare-target-my).

1. [Create a source endpoint](../../data-transfer/operations/source-endpoint.md#create-endpoint) with the `{{ MY }}` database type.

1. [Create a target endpoint](../../data-transfer/operations/target-endpoint.md#create-endpoint) with the `{{ mmy-name }}` database type.

1. [Create a transfer](../../data-transfer/operations/transfer.md#create-transfer) of the <q>{{ dt-copy-repl }}</q> type that will use the created endpoints.

1. [Activate](../../data-transfer/operations/transfer.md#activate-transfer) it.

    {% note warning %}

    Avoid any changes to the data schema in the source and target clusters during the transfer operation. For more information, see [{#T}](../../data-transfer/operations/db-actions.md).

    {% endnote %}

1. Wait for the transfer to change to the **Replicated** status.

1. Switch the source cluster to <q>read-only</q> mode and switch the load to the target cluster.

1. On the [transfer monitoring](../../data-transfer/operations/monitoring.md) page, wait for the **Maximum lag on delivery** metric to decrease to zero. This means that all changes that occurred in the source cluster after data copying was completed are transferred to the target cluster.

1. [Deactivate](../../data-transfer/operations/transfer.md#deactivate-transfer) the transfer and wait for its status to change to **Stopped**.

    For more information about the transfer lifecycle, see the appropriate [section](../../data-transfer/concepts/transfer-lifecycle.md).

1. [Delete](../../data-transfer/operations/transfer.md#delete-transfer) the stopped transfer.

1. [Delete the source endpoint](../../data-transfer/operations/source-endpoint.md#delete-endpoint).

1. [Delete the target endpoint](../../data-transfer/operations/target-endpoint.md#delete-endpoint).

For a real example of database migration {{ MY }} using {{ data-transfer-name }}, see [{#T}](../../solutions/dataplatform/sync-mysql.md).

## Transferring data by creating and restoring a logical dump {#logical-dump}

To migrate data to a {{ mmy-name }} cluster, you can use `mysqldump` and `mysql`: create a logical dump of a working database and restore it in the desired cluster.

Migration stages:

1. [Create a dump](#dump) of the database you want to migrate.
1. If necessary, [create an intermediate VM](#create-vm) in {{ yandex-cloud }} and upload the dump to it.
1. [Restore data from the dump](#restore).

### Creating a dump {#dump}

To create a dump, use [mysqldump](https://dev.mysql.com/doc/refman/5.7/en/mysqldump.html).

1. Before creating a dump, switch the database to <q>read-only</q> mode to avoid losing data that might appear while creating the dump. Create the database dump using the following command:

    ```bash
    mysqldump -h <source server address> \
              --user=<username> \
              --password \
              --port=<port> \
              --set-gtid-purged=OFF \
              --quick \
              --single-transaction <database name> \
              > ~/db_dump.sql
    ```

    If necessary, pass additional parameters in the create dump command:
    * `--events` — If there are recurring events in your database.
    * `--routines` — If your database contains functions and stored procedures.

    For InnoDB tables, use the `--single-transaction` option to guarantee data integrity. You can't use this option for MyISAM tables, but you can convert them to InnoDB using the command:

    ```bash
    sed -i 's/ENGINE=MyISAM/ENGINE=InnoDB/' ~/db_dump.sql
    ```

1. Archive the dump:

    ```bash
    tar -cvzf db_dump.tar.gz ~/db_dump.sql
    ```

### (optional) Creating a VM in {{ yandex-cloud }} and uploading a dump {#create-vm}

Transfer your data to an intermediate VM in {{ compute-full-name }} if:

* Your {{ mmy-name }} cluster is not accessible from the internet.
* Your hardware or connection to the cluster in {{ yandex-cloud }} is not very reliable.

The required amount of RAM, processor cores, and disk space depends on the amount of data to migrate and the required migration speed.

To prepare the VM to restore the dump:

1. In the management console, [create a VM](../../compute/operations/vm-create/create-linux-vm.md) with a public IP address based on [Ubuntu Linux 18.04]{% if lang == "ru" %}(https://cloud.yandex.ru/marketplace/products/f2e9qa7i4fmugh14tjnc){% endif %}{% if lang == "en" %}(https://cloud.yandex.com/en-ru/marketplace/products/f2e9qa7i4fmugh14tjnc){% endif %}. The minimum configuration (1 core, 2 GB RAM, 10 GB disk space) is sufficient to migrate a database that's up to 1 GB in size. The bigger the database being migrated, the more RAM and storage space you need (at least twice as large as the size of the database).

    Place the VM in the same network and availability zone as the {{ mmy-name }} cluster master host.

1. [Set up security groups](./connect.md#configure-security-groups) for the intermediate VM and the {{ mmy-name }} cluster.

1. [Connect to the intermediate VM via SSH](../../compute/operations/vm-connect/ssh.md).

1. Install the {{ MY }} client. For example (for Ubuntu):

    ```bash
    sudo apt install mysql-client
    ```

1. Move the DB dump to the intermediate VM. For example, you can use `scp`:

    ```bash
    scp ~/db_dump.tar.gz <VM user's name@VM public IP address:/tmp/db_dump.tar.gz
    ```

1. Unpack the dump:

    ```bash
    tar -xzf /tmp/db_dump.tar.gz
    ```

### Restoring data {#restore}

To restore the database from the dump, use [mysql](https://dev.mysql.com/doc/refman/5.7/en/mysql.html). To get more information in the event of an error, run the recovery command with the `--line-numbers` flag.

{% note alert %}

By default, for a {{ mmy-name }} cluster, [AUTOCOMMIT](https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_autocommit) is enabled. **Do not disable** AUTOCOMMIT during the client session when restoring the database from the dump, otherwise the host storage may overflow and the cluster may not function properly.

{% endnote %}

* If you restore a dump from the VM in {{ yandex-cloud }}:

    ```bash
    mysql --host <FQDN of {{ MY }} host> \
          --user=<username> \
          --password \
          --port=3306 \
          --line-numbers <database name> \
          < /tmp/db_dump.sql
    ```

    {% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

* If you restore a dump from your own server, [get an SSL certificate](connect.md#get-ssl-cert) and pass the `--ssl-ca` and `--ssl-mode` parameters in the recovery command:

   ```bash
   mysql --host=<FQDN of {{ MY }} host> \
         --user=<username> \
         --password \
         --port={{ port-mmy }} \
         --ssl-ca=~/.mysql/root.crt \
         --ssl-mode=VERIFY_IDENTITY \
         --line-numbers <database name> \
         < ~/db_dump.sql
   ```

   {% include [see-fqdn-in-console](../../_includes/mdb/see-fqdn-in-console.md) %}

