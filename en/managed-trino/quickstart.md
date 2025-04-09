---
title: Getting started with {{ mtr-full-name }}
description: Follow this guide to create a {{ TR }} cluster and connect to it.
noIndex: true
---

# Getting started with {{ mtr-full-name }}

{% include [preview](../_includes/managed-trino/note-preview.md) %}

To get started:
* [Create a {{ mtr-name }}](#cluster-create) cluster.
* [Install the {{ TR }} CLI](#install-trino-cli).
* [Connect to {{ TR }}](#connect).
* [Send queries to the {{ mpg-full-name }} cluster through {{ TR }}](#query-mpg-via-trino).
* [Check the queries in the {{ mpg-name }} cluster](#check-queries-in-psql).

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../_includes/create-folder.md) %}

1. [Assign](../iam/operations/roles/grant.md) the following roles to your {{ yandex-cloud }} account:

    * [managed-trino.admin](security.md#managed-trino-admin): To create a cluster.
    * [{{ roles-vpc-user }}](../vpc/security/index.md#vpc-user): To use the cluster [network](../vpc/concepts/network.md#network).
    * [iam.serviceAccounts.user](../iam/security/index.md#iam-serviceAccounts-user): To link a service account to the cluster.

    {% include [note-managing-roles](../_includes/mdb/note-managing-roles.md) %}

1. [Create a service account](../iam/operations/sa/create.md#create-sa) with the `managed-trino.integrationProvider` and `storage.editor` roles.    

1. [Create](../managed-postgresql/operations/cluster-create.md#create-cluster) a {{ mpg-full-name }} cluster {{ TR }} will work with.

## Create a {{ mtr-name }} cluster {#cluster-create}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the management console, select the folder where you want to create a {{ mtr-name }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Specify a name for the cluster.
    1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select the previously created service account.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [network](../vpc/operations/network-create.md), [subnet](../vpc/operations/subnet-create.md), and [security group](../vpc/concepts/security-groups.md) for the cluster.
    1. Configure the coordinator and workers.
    1. Under **{{ ui-key.yacloud.trino.title_catalogs }}**, add folders:

        1. For the {{ mpg-name }} cluster, with the following properties:

           * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}**: `test`
           * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}**: `PostgreSQL`
           * **{{ ui-key.yacloud.trino.catalogs.label_url }}**: `jdbc:postgresql://<FQDN_of_host_of_Managed_Service_for_Postgresql>:6432/<DB_name>?ssl=true&sslmode=verify-full`

               To learn how to get the FQDN of a host in a {{ mpg-name }} cluster, see [this guide](../managed-postgresql/operations/connect.md#fqdn).

           * **{{ ui-key.yacloud.trino.catalogs.label_userName }}**: Username in the {{ mpg-name }} cluster.
           * **{{ ui-key.yacloud.trino.catalogs.label_password }}**: User password.

        1. For test data, with the following properties:

            * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}**: `data`.
            * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}**: `TPC-H`.
   
        You can add folders both when you are creating a cluster and after you have done so.

    1. Optionally, under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, configure logging:

        1. Enable the **{{ ui-key.yacloud.logging.field_logging }}** setting.
        1. Select where the logs will be stored:
            * **{{ ui-key.yacloud.common.folder }}**: Select a folder from the list.
            * **{{ ui-key.yacloud.logging.label_group }}**: Select a [log group](../logging/concepts/log-group.md) from the list or create a new one.
        1. Select **{{ ui-key.yacloud.logging.label_minlevel }}** from the list.

    1. Click **{{ ui-key.yacloud.common.create }}**.
    1. Wait until the cluster is ready: its status on the {{ mtr-name }} dashboard will change to **Running** and its state, to **Alive**. This may take some time.

{% endlist %}

## Install the {{ TR }} CLI {#install-trino-cli}

1. Download the {{ TR }} CLI from the Apache Maven central repository to the `trino` file:

   ```bash
   wget -O trino \
   https://repo.maven.apache.org/maven2/io/trino/trino-cli/<version_number>/trino-cli-<version_number>-executable.jar
   ```

   The available versions are listed [here](https://repo.maven.apache.org/maven2/io/trino/trino-cli/).

1. Convert the file you downloaded to an executable:

   ```bash
   sudo chmod +x trino
   ```

1. Make sure {{ TR }} is installed successfully. Do it by requesting {{ TR }} version:

   ```bash
   ./trino --version
   ```

   The response will look as follows:

   ```bash
   Trino CLI <version_number>
   ```

## Connect to the {{ mtr-name }} cluster {#connect-to-trino}

1. Create an [IAM token](../iam/concepts/authorization/iam-token.md) and put it to the `TRINO_PASSWORD` environment variable:

   ```bash
   export TRINO_PASSWORD=$(yc iam create-token)
   ```

   This IAM token in `TRINO_PASSWORD` will be your password to the {{ mtr-name }} cluster. To enable it, specify the `--password` flag upon connection.

1. Connect to the {{ mtr-name }} cluster:

   ```bash
   ./trino <coordinator_URL> --user iam --password
   ```

   You can copy the coordinator URL and paste it to the **{{ ui-key.yacloud.trino.overview.title_resource-coordinator }}** field on the {{ TR }} overview page in the [management console]({{ link-console-main }}).

## Send queries to the {{ mpg-name }} cluster through {{ TR }} {#query-mpg-via-trino}

1. [Connect to the {{ TR }} cluster through the {{ TR }} CLI](#connect-to-trino).

   To follow the steps below, use the {{ TR }} CLI.

1. Create a new schema in the {{ mpg-name }} cluster:

   ```sql
   CREATE SCHEMA IF NOT EXISTS test.tpch_postgresql;
   ```

1. Create a table:

   ```sql
   CREATE TABLE IF NOT EXISTS test.tpch_postgresql.customers (
      name VARCHAR,
      phone VARCHAR,
      acctbal DOUBLE
   );
   ```

1. Populate the table with data from the test data folder:

   ```sql
   INSERT INTO test.tpch_postgresql.customers
   SELECT
     name,
     phone,
     acctbal
   FROM data.sf100000.customer
   LIMIT 1000000;
   ```

1. Get the number of rows in the table:

   ```sql
   SELECT COUNT(*) as count FROM test.tpch_postgresql.customers;
   ```

   Expected response:

   ```sql
     count  
   ---------
    1000000 
   (1 row)
   ```

## Check the queries in the {{ mpg-name }} cluster {#check-queries-in-psql}

To check whether the queries to the {{ mpg-name }} cluster are running correctly, [connect to the cluster database](../managed-postgresql/operations/connect.md) and get the number of rows in the `customers` table:

```sql
SELECT COUNT(*) FROM tpch_postgresql.customers;
```

Expected response:

```sql
  count  
---------
 1000000
(1 row)

```

