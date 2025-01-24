---
title: Getting started with {{ mgp-full-name }}
description: Follow this guide to create and start working with a {{ GP }} cluster.
---

# Getting started with {{ mgp-short-name }}

To get started with the service:

1. [Create a cluster](#create-cluster).
1. [Get its ID](#get-cluster-id).
1. [Connect to the cluster](#connect).
1. [Create a database](#create-db).
1. [Run a few queries](#query-db).

To connect to the cluster and work with databases, you will need the following tools:

* [DBeaver](https://dbeaver.io/) graphical IDE.
* `psql` console client.

For more tools you can use to work with {{ GP }}, see [{#T}](./operations/connect.md).


## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.
1. If you do not have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user) role and the [{{ roles.mgp.editor }} role or higher](security/index.md#roles-list) to your {{ yandex-cloud }} account. These roles allow you to create a cluster.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}


## Create a cluster {#create-cluster}

Create a {{ GP }} cluster with public access. You can [connect](./operations/connect.md) to such a cluster with a {{ compute-full-name }} VM or over the internet.

To create a cluster:

1. In the management console, select the folder where you want to create a DB cluster.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.


1. Specify the following cluster parameters:

    * **{{ ui-key.yacloud.mdb.forms.section_base }}** → **{{ ui-key.yacloud.mdb.forms.base_field_name }}**: Cluster name. It must be unique within the folder.

    * **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**:

        * **Network**: Specify the [network](../vpc/concepts/network.md) you want the [cluster hosts](./concepts/index.md) to reside in.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: Specify [security groups](../vpc/concepts/security-groups.md) for the cluster network traffic.

            [Set up the security groups](./operations/connect.md#configuring-security-groups) to be able to connect to the cluster over the internet.

        * **{{ ui-key.yacloud.mdb.forms.network_field_zone }}**: Specify an availability zone for the cluster hosts.

        * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}**: Specify a subnet for the cluster hosts.

        * Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.

    * **{{ ui-key.yacloud.mdb.forms.section_user }}**:

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: Admin user name. It may contain Latin letters, numbers, hyphens, and underscores, but cannot start with a hyphen. It must be from 1 to 32 characters long.

            {% include [reserved-usernames-note](../_includes/mdb/mgp/reserved-usernames-note.md) %}

        * **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**: Admin user password. It must be from 8 to 128 characters long.

        Admin user is a special user required for managing the cluster. This user cannot be deleted. For more information, see [{#T}](./concepts/cluster-users.md).

    * **{{ ui-key.yacloud.greenplum.section_resource-master }}** and **{{ ui-key.yacloud.greenplum.section_resource-segment }}**: [Master and segment host](./concepts/index.md) configuration in the {{ GP }} cluster.

        You can edit the settings on these tabs if the default configuration does not suit your needs. For more information, see [{#T}](./operations/calculate-specs.md).

1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.


1. Wait until the cluster is ready: its status on the {{ mgp-short-name }} dashboard will change to **Running** and its state, to **Alive**. This may take some time.

For more information about creating a cluster, see [{#T}](./operations/cluster-create.md).

## Get the cluster ID {#get-cluster-id}

Get the cluster ID to use to [connect](#connect) to the cluster:

1. In the management console, go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
1. Click the name of the cluster you need and select the ![image](../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.mdb.cluster.switch_overview }}** tab.
1. Copy the cluster ID specified under **{{ ui-key.yacloud.common.section-base }}**.

## Connect to the cluster {#connect}

Connect to the cluster you [created](#create-cluster):

{% list tabs group=mgp-quickstart %}

- DBeaver {#gui}

    1. [Install DBeaver](https://dbeaver.com/docs/dbeaver/Installation/) to the host to use for the connection.

        {% note info %}

        Access to the cluster was tested in DBeaver Community 24.2.3

        {% endnote %}

    1. Launch DBeaver.
    1. In the **Database** menu, select **New connection**.
    1. Select **{{ GP }}** from the DB list.
    1. Click **Next**.
    1. Specify the main connection parameters on the **Main** tab:

        * Under **Server**:
            * **Connect by**: `Host`.
            * **Host**: [Special FQDN of the primary master](./operations/connect.md#fqdn-master), `c-<cluster_ID>.rw.{{ dns-zone }}`.

                Cluster ID [you got earlier](#get-cluster-id).

            * **Database**: `postgres`.
            * **Port**: `{{ port-mgp }}`.
            * **Show all databases**: Enabled.

        * Under **Authentication**:
            * **Authentication**: `Database Native`.
            * **User**: Admin user name specified when [creating the cluster](#create-cluster).
            * **Password**: Admin user password.

                You can disable the **Save password** option, which is enabled by default.

    1. Click **Test connection**.

        Click **Download** if DBeaver prompts you to download the driver files. You may not have these files if this is your first time using DBeaver to connect to the {{ GP }}.

        {% include [dbeaver-connect](../_includes/mdb/mgp/quickstart/dbeaver-connect.md) %}

        If the connection is successful, you will get general information about the {{ GP }} server and the driver used for the connection. Click **OK**.

        {% note warning %}

        {% include [ssl-default-mode](../_includes/mdb/mgp/quickstart/ssl-default-mode.md) %}

        In the production environment, we recommend [connecting to the cluster via SSL with host authentication](./operations/connect.md#connection-ide).

        {% endnote %}

    1. (Optional) On the **Main** tab, click **Connection description (name, type, ...)** and add a name and description for the connection.

        By default, the connection name matches the specified database name, i.e., `postgres`. You may want to select a different name to avoid confusion: you can use this connection to work with any databases, not just `postgres`.

    1. Click **Finish**.

        You will see the new connection in the left-hand panel on the **Databases** tab.

    1. Expand the created connection in the left-hand panel on the **Databases** tab.

        {% include [dbeaver-connect](../_includes/mdb/mgp/quickstart/dbeaver-connect.md) %}

    1. Run a test query:

        1. Open the **Databases** folder, expand the `postgres` database context menu, and select **SQL editor** → **Open SQL console**.

            This will open a console you can use to run SQL queries to the `postgres` database.

        1. Enter your query in the console:

            ```sql
            SELECT version();
            ```

        1. {% include [dbeaver-how-to-exec-query](../_includes/mdb/mgp/quickstart/dbeaver-how-to-exec-query.md) %}

- psql {#cli}

    1. [Install](https://www.postgresql.org/download/) the `psql` client to the host you will use to connect to the cluster.

        For example, to install `psql` on a [Linux VM](../compute/operations/vm-create/create-linux-vm.md) in {{ yandex-cloud }} with Ubuntu 24.04:

        
        1. Connect to the VM via [{{ oslogin }}](../compute/operations/vm-connect/os-login.md) or over [SSH](../compute/operations/vm-connect/ssh.md).


        1. Install the required dependencies and the {{ PG }} client:

            ```bash
            sudo apt update && sudo apt install postgresql-client --yes
            ```

    1. Connect to the `postgres` database in the {{ GP }} cluster. Use the [special primary master FQDN](operations/connect.md#fqdn-master):

        ```bash
        psql "host=c-<cluster_ID>.rw.{{ dns-zone }} \
          port={{ port-mgp }} \
          dbname=postgres \
          user=<username>"
        ```

        Cluster ID [you got earlier](#get-cluster-id).

        After running the command, enter the user password to complete the connection process.

        {% note warning %}

        {% include [ssl-default-mode](../_includes/mdb/mgp/quickstart/ssl-default-mode.md) %}

        In the production environment, we recommend [connecting to the cluster via SSL with host authentication](./operations/connect.md#bash).

        {% endnote %}

    1. Run a test query:

        ```sql
        SELECT version();
        ```

{% endlist %}

If the connection to the cluster and the test query are successful, the {{ GP }} version will be shown.

## Create a database {#create-db}

The [previously created](#create-cluster) {{ GP }} cluster has only one database, a service database named `postgres`. This database is not meant to store user data. For example, you cannot create data schemas in it.

After you [connect to the {{ GP }} cluster](#connect), create a database named `sample_db` for storing user data:

{% list tabs group=mgp-quickstart %}

- DBeaver {#gui}

    1. Expand the [previously created connection](#connect) in the left-hand panel on the **Databases** tab.

        {% include [dbeaver-connect](../_includes/mdb/mgp/quickstart/dbeaver-connect.md) %}

    1. Create a database:

        1. Open the **Databases** folder, expand the `postgres` database context menu, and select **SQL editor** → **Open SQL console**.

            This will open a console you can use to run SQL queries to the `postgres` database.

        1. Enter your query in the console:

            ```sql
            CREATE DATABASE sample_db;
            ```

        1. {% include [dbeaver-how-to-exec-query](../_includes/mdb/mgp/quickstart/dbeaver-how-to-exec-query.md) %}

    1. Update the list of databases for it to display the new database.

        To do this, open the context menu of the **Databases** folder and select **Refresh**.

        {% note tip %}

        If you do not see the `sample_db` database in the list, make sure you [enabled](#connect) the **Show all databases** option for the connection.

        {% endnote %}

- psql {#cli}

    1. Run this request:

        ```sql
        CREATE DATABASE sample_db;
        ```

    1. Output a list of {{ GP }} cluster databases and make sure it includes `sample_db`:

        ```sql
        \list
        ```

{% endlist %}

## Run a few queries to the database {#query-db}

To make sure the database [was created](#create-db) correctly, run a few queries to it:

{% list tabs group=mgp-quickstart %}

- DBeaver {#gui}

    1. Expand the [previously created connection](#connect) in the left-hand panel on the **Databases** tab.

        {% include [dbeaver-connect](../_includes/mdb/mgp/quickstart/dbeaver-connect.md) %}

    1. Open the **Databases** folder, expand the `sample_db` database context menu, and select **SQL editor** → **Open SQL console**.

        This will open a console you can use to run SQL queries to the `sample_db` database.

    1. Create a table and populate it with data:

        1. Enter your queries in the console:

            {% include [table-query](../_includes/mdb/mgp/quickstart/table-query.md) %}

        1. {% include [dbeaver-how-to-exec-query](../_includes/mdb/mgp/quickstart/dbeaver-how-to-exec-query.md) %}

        The table will be created and populated with numbers from 1 to 10,000.

        The `CREATE TABLE` and `INSERT INTO` queries do not return any results. DBeaver will display statistics for the completed queries as follows:

        ```sql
        Queries         2
        Updated Rows    10000
        Execute time    ...
        Fetch time      ...
        Total time      ...
        Start time      ...
        Finish time     ...
        ```

    1. Get the sum of all numbers in the table. To do this, clear the console, then enter and run the following query:

        {% include [sum-query](../_includes/mdb/mgp/quickstart/sum-query.md) %}

    1. Get information on how the 10,000 table rows are distributed across {{ GP }} segments. To do this, clear the console, then enter and run the following query:

        {% include [segment-query](../_includes/mdb/mgp/quickstart/segment-query.md) %}

    1. End the connection session. To do this, open the connection context menu and select **Disconnect**.

- psql {#cli}

    1. Make sure you are connected to the `sample_db` database:

        ```sql
        SELECT current_database();
        ```

        If the query returns a different database name, e.g., `postgres`, connect to the database you need:

        ```sql
        \connect sample_db;
        ```

    1. Create a table and populate it with data:

        {% include [table-query](../_includes/mdb/mgp/quickstart/table-query.md) %}

        The table will be created and populated with numbers from 1 to 10,000.

        The `CREATE TABLE` and `INSERT INTO` queries do not return any results.

    1. Get the sum of all numbers in the table:

        {% include [sum-query](../_includes/mdb/mgp/quickstart/sum-query.md) %}

    1. Get information on how the 10,000 table rows are distributed across {{ GP }} segments:

        {% include [segment-query](../_includes/mdb/mgp/quickstart/segment-query.md) %}

    1. End the `psql` session:

        ```sql
        \quit
        ```

{% endlist %}

## What's next {#whats-next}

* Read about [service concepts](./concepts/index.md).
* Learn more about [creating a cluster](./operations/cluster-create.md) and [connecting to a cluster](./operations/connect.md).

{% include [greenplum-trademark](../_includes/mdb/mgp/trademark.md) %}
