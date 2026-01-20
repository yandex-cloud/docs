---
title: Getting started with {{ mspqr-full-name }}
description: Follow this guide to create a {{ SPQR }} cluster and connect to it.
---

# Getting started with {{ mspqr-name }}

{% include [preview](../_includes/note-service-preview.md) %}

With {{ mspqr-name }}, you can create and maintain sharded {{ PG }} ([SPQR](https://pg-sharding.tech/welcome)) clusters in the {{ yandex-cloud }} infrastructure. {{ SPQR }} uses a {{ PG }} protocol, enabling you to configure sharding rules and run database queries using the `psql` client. Sharding rules are configured through the admin console (SPQR router admin console). When connecting to the administrator console, put `spqr-console` for user name and `spqr-console` for database name.

To get started:

1. [Create a {{ SPQR }} cluster](#cluster-create).
1. [Create shards in the {{ SPQR }} cluster](#shard-create).
1. [Set up your environment](#setup_environment).
1. [Set up sharding rules](#setting-up-sharding).
1. [Send your requests to the database](#query-db).

## Getting started {#before-you-begin}

1. Navigate to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}


1. [Assign](../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) and `managed-spqr.editor` roles for the folder to your {{ yandex-cloud }} account. These roles allow you to create a cluster.


   {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. You can connect to DB clusters from both inside and outside {{ yandex-cloud }}:

   * To connect from inside {{ yandex-cloud }}, create a [Linux](../compute/quickstart/quick-create-linux.md) VM in the same network as the DB cluster.

   * To connect to the cluster from the internet, enable public access to hosts when [creating the cluster](#cluster-create).

   {% note info %}

    The next step implies connecting to the cluster from a VM. If your plan is to connect to the cluster from the internet, proceed to [creating a cluster](#cluster-create).

   {% endnote %}

1. [Connect](../compute/operations/vm-connect/ssh.md) to the VM over [SSH](https://en.wikipedia.org/wiki/Secure_Shell).

## Create a cluster {#cluster-create}

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ SPQR }} cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-spqr }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter a name for the cluster.
1. Select the `PRODUCTION` environment.
1. Select the sharding type:

    * **{{ ui-key.yacloud.spqr.section_sharding-type-standard }}**: Cluster will consist only of infrastructure hosts.
    * **{{ ui-key.yacloud.spqr.section_sharding-type-advanced }}**: Cluster will consist only of router hosts and, optionally, coordinator hosts.

1. Under **{{ ui-key.yacloud.mdb.forms.section_network }}**:

    * Select the cloud network you [created before you started out](#before-you-begin).
    * Select the default security group or create a new one.

1. Specify the computing resource configuration:

    * For standard sharding, specify the infrastructure host configuration under **{{ ui-key.yacloud.spqr.section_infra }}**.
    * For advanced sharding, specify the router host configuration under **{{ ui-key.yacloud.spqr.section_router }}**.

    To specify your computing resource configuration:

      1. Select the [host class](concepts/instance-types.md). Host class determines the technical specifications of the [VMs](../compute/concepts/vm.md) the cluster [hosts](concepts/index.md) will be deployed on.
      1. Under **{{ ui-key.yacloud.mdb.forms.section_storage }}**:

          1. Select the [disk type](concepts/storage.md#storage-type-selection).
          1. Set the [storage](concepts/storage.md) size.

      1. Under **{{ ui-key.yacloud.spqr.section_hosts }}**, specify the availability zones and subnets for the hosts that will be created together with the cluster.

         If you plan to connect to the cluster from the internet, enable **{{ ui-key.yacloud.mdb.forms.host_column_assign_public_ip }}** for the hosts.

1. Optionally, under **{{ ui-key.yacloud.spqr.section_coordinator }}**, enable **{{ ui-key.yacloud.spqr.field_coordinator }}** and specify the coordinator host configuration.
1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**, specify:

    * Database name. It must be unique within the folder.
    * Database owner username.
    * Password.

1. Under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, specify the password for the {{ SPQR }} console.
1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.
1. Wait until the cluster is ready to work: its status will change to **Running**, and its state to **Alive**. To check its state, hover over the cluster status in the **{{ ui-key.yacloud.common.availability }}** column.

## Create shards in the cluster {#shard-create}

Create two shards in the {{ mspqr-name }} cluster. To create a shard:

1. In the [management console]({{ link-console-main }}), select the folder where you [created](#cluster-create) the {{ SPQR }} cluster.
1. [Create](../managed-postgresql/operations/cluster-create.md#create-cluster) a {{ mpg-name }} cluster in the same cloud network as the {{ SPQR }} cluster.
1. Open your {{ SPQR }} cluster and go to the ![image](../_assets/console-icons/copy-transparent.svg) **{{ ui-key.yacloud.mdb.cluster.shards.label_title }}** tab.
1. Click **{{ ui-key.yacloud.mdb.cluster.shards.action_add-shard }}** in the top-right corner of the page.
1. In the window that opens:

   1. Specify the shard **{{ ui-key.yacloud.common.name }}**.
   1. In the **Managed Service for PostgreSQL cluster** field, select the {{ PG }} cluster you previously created.

      The {{ mpg-name }} cluster must be in the same folder and cloud network as the {{ mspqr-name }} cluster.


{% note warning %}

Make sure the router can connect to shard hosts. For this to work, the shards and the {{ mspqr-name }} cluster must be in the same [security group](../vpc/concepts/security-groups.md) that allows incoming and outgoing TCP connections to port `6432`.

{% endnote %}


## Set up your environment {#setup_environment}

{% list tabs group=operating_system %}

- Linux (Bash)/macOS (Zsh) {#linux-macos}

    1. Get an SSL certificate:

        ```bash
        mkdir -p ~/.postgresql && \
        wget "{{ crt-web-path }}" \
                --output-document ~/.postgresql/root.crt && \
        chmod 0655 ~/.postgresql/root.crt
        ```

        The certificate will be saved to the `~/.postgresql/root.crt` file.

    1. Install the required dependencies and the {{ PG }} client:

        ```bash
        sudo apt update && sudo apt install -y postgresql-client
        ```

- Windows (PowerShell) {#windows}

    1. Install the latest version of [{{ PG }} for Windows](https://www.postgresql.org/download/windows/). Install only the _Command Line Tools_.

    1. Get an SSL certificate:

        ```powershell
        mkdir $HOME\.postgresql; curl.exe -o $HOME\.postgresql\root.crt {{ crt-web-path }}
        ```

        The certificate will be saved to the `$HOME\.postgresql\root.crt` file.

{% endlist %}

## Set up sharding rules {#setting-up-sharding}


{% note warning %}

If you are using security groups for your cloud network, [configure them](operations/connect.md#configuring-security-groups) to allow all relevant traffic between the cluster and the connecting host.

{% endnote %}


1. Connect to the administrator console:

    {% list tabs group=operating_system %}

    - Linux (Bash)/macOS (Zsh) {#linux-macos}

      ```bash
      psql "host=<host_FQDN> \
           port={{ port-mpg }} \
           sslmode=verify-full \
           sslrootcert=~/.postgresql/root.crt \
           dbname=spqr-console \
           user=spqr-console"
      ```

      [Learn more about connecting to a {{ mspqr-name }} cluster](operations/connect.md).

    - Windows (PowerShell) {#windows}

      ```powershell
      & "C:\Program Files\PostgreSQL\<{{ PG }}_major_version>\bin\psql.exe" `
          --host=<host_FQDN> `
          --port={{ port-mpg }} `
          --username=spqr-console `
          --dbname=spqr-console `
          --set=sslmode=verify-full `
          --set=sslrootcert=$HOME\.postgresql\root.crt
      ```

      [Learn more about connecting to a {{ mspqr-name }} cluster](operations/connect.md).

    {% endlist %}

1. Create a sharding rule:

    ```sql
    CREATE DISTRIBUTION ds1 COLUMN TYPES int;
    ```

    A sharding rule named `ds1` will be created for `int` type columns.

1. Link the table to the rule and specify the [sharding key](concepts/sharding-keys.md):

    ```sql
    ALTER DISTRIBUTION ds1 ATTACH RELATION customers DISTRIBUTION KEY id;
    ```

    The `customers` table will be linked to the `ds1` rule. The `id` column is the sharding key for the `customers` table.

1. Create key value ranges to distribute data across shards:

    ```sql
    CREATE KEY RANGE krid2 FROM 1000 ROUTE TO <shard_2_name> FOR DISTRIBUTION ds1;
    CREATE KEY RANGE krid1 FROM 1 ROUTE TO <shard_1_name> FOR DISTRIBUTION ds1;
    ```

    {% note warning %}

    Create key value ranges ​starting with the largest value. Breaking this order will result in the `key range krid2 intersects with key range krid1 in QDB` error. For the range with the largest key value, the right boundary will equal infinity.

    {% endnote %}

1. To exit the administrator console, run the `\q` command.

## Send your requests to the database {#query-db}

1. Connect to the database:

    {% list tabs group=operating_system %}

    - Linux (Bash)/macOS (Zsh) {#linux-macos}

      ```bash
      psql "host=<host_FQDN> \
           port={{ port-mpg }} \
           sslmode=verify-full \
           sslrootcert=~/.postgresql/root.crt \
           dbname=<DB_name> \
           user=<username> \
           target_session_attrs=read-write"
      ```

      [Learn more about connecting to a {{ mspqr-name }} cluster](operations/connect.md).

    - Windows (PowerShell) {#windows}

      ```powershell
      & "C:\Program Files\PostgreSQL\<{{ PG }}_major_version>\bin\psql.exe" `
          --host=<host_FQDN> `
          --port={{ port-mpg }} `
          --username=<username> `
          --dbname=<DB_name> `
          --set=target_session_attrs=read-write `
          --set=sslmode=verify-full `
          --set=sslrootcert=$HOME\.postgresql\root.crt
      ```

      [Learn more about connecting to a {{ mspqr-name }} cluster](operations/connect.md).

    {% endlist %}

1. Create a table named `customers`:

    ```sql
    CREATE TABLE customers (
        id INT,
        name VARCHAR,
        phone VARCHAR,
        acctbal NUMERIC
    );
    ```

1. Start the transaction:

    ```sql
    BEGIN;
    ```

1. Add rows:

    1. Add a row to the shard with a value range `krid1`:

        ```sql
        INSERT INTO customers (id, name, phone, acctbal) VALUES (28, 'John Doe', '123-45-67', 1500.50)
        ```

    1. Add a row to the shard with a value range `krid2`:

        ```sql
        INSERT INTO customers (id, name, phone, acctbal) VALUES (3200, 'David Smith', '555-66-77', -50.75)
        ```

1. Complete the transaction:

    ```sql
    COMMIT;
    ```

1. View rows by specifying the key value in the query, e.g.:

    ```sql
    SELECT * FROM customers WHERE id = 28;
    ```

    The `SELECT * FROM customers;` query will result in an error because the rows are distributed across different shards. You can only get rows from one shard at a time. To check the distribution of rows across shards, [connect to each shard](../managed-postgresql/operations/connect.md) and view the added entries.

1. To exit the database, run the `\q` command.

## What's next {#whats-next}

* Read about the [service concepts](concepts/index.md).
* Learn more about [creating a cluster](operations/cluster-create.md) and [connecting to a database](operations/connect.md).
