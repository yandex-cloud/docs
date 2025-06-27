---
title: Getting started with {{ mtr-full-name }}
description: Follow this guide to create a {{ TR }} cluster and connect to it.
---

# Getting started with {{ mtr-full-name }}

{% include [preview](../_includes/managed-trino/note-preview.md) %}

To get started:
1. [Create a {{ mtr-name }} cluster](#cluster-create).
1. [Connect to the {{ mtr-name }} cluster](#connect).
1. [Send queries to the {{ mpg-full-name }} cluster through {{ TR }}](#query-mpg-via-trino).
1. [Check the queries in the {{ mpg-name }} cluster](#check-queries-in-psql).


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

    1. In the [management console]({{ link-console-main }}), select the folder where you want to create a {{ mtr-name }} cluster.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-trino }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Give the cluster a name.
    1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select the previously created service account.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select a [network](../vpc/operations/network-create.md), [subnet](../vpc/operations/subnet-create.md), and [security group](../vpc/concepts/security-groups.md) for the cluster.
    1. Configure the [coordinator](concepts/index.md#coordinator) and [workers](concepts/index.md#workers).
    1. Under **{{ ui-key.yacloud.trino.title_catalogs }}**, add one [{{ TR }} catalog](operations/catalog-create.md) for each of the following:

        1. For the [previously created](#before-you-begin) {{ mpg-name }} cluster:

           * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}**: `test`.
           * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}**: `PostgreSQL`.
           * **Connection type**: `On-premise`.
           * **URL**: `jdbc:postgresql://<host_address>:<port>/<database_name>`.
           * **Username**: Username in the {{ mpg-name }} cluster.
           * **Password**: User password.

        1. For test data generation:

            * **{{ ui-key.yacloud.trino.catalogs.field_catalog-name }}**: `data`.
            * **{{ ui-key.yacloud.trino.catalogs.field_catalog-type }}**: `TPC-H`.
   
        You can add folders both when you are creating a cluster and after you have done so.

    1. Optionally, under **{{ ui-key.yacloud.mdb.forms.section_additional }}**, configure logging:

        1. Enable the **{{ ui-key.yacloud.logging.field_logging }}** setting.
        1. Select the log destination:
            * **{{ ui-key.yacloud.common.folder }}**: Select a folder from the list.
            * **{{ ui-key.yacloud.logging.label_group }}**: Select a [log group](../logging/concepts/log-group.md) from the list or create a new one.
        1. Select **{{ ui-key.yacloud.logging.label_minlevel }}** from the list.

    1. Click **{{ ui-key.yacloud.common.create }}**.
    1. Wait until the cluster is ready: its status on the {{ mtr-name }} dashboard will change to **Running** and its state, to **Alive**. This may take some time.

{% endlist %}

## Connect to the {{ mtr-name }} cluster through the {{ TR }} CLI {#connect-to-trino}

{% include [trino-cli-connect](../_includes/managed-trino/trino-cli-connect.md) %}

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


# What's next {#whats-next}

* Learn about [service resource relationships](concepts/index.md).
* Explore other [methods of connecting to a {{ mtr-name }} cluster](operations/connect.md).
