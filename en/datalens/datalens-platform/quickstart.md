---
title: Getting started with {{ datalens-platform-full-name }}
description: Follow this guide to set up a {{ datalens-platform-short-name }} environment, ingest data from a source, explore it using SQL, and create a dashboard.
alternate:
  - href: en/datalens/datalens-platform/quickstart.md
    type: text/markdown
    title: Markdown version
---

# Getting started with {{ datalens-platform-full-name }}

This section describes how to set up a {{ datalens-platform-short-name }} environment, connect to a data source, ingest data into the REST catalog, explore it using the SQL editor, and create a dashboard.

* [{#T}](#before-you-begin)
* [{#T}](#activate-service)
* [{#T}](#configure-airflow)
* [{#T}](#load-data)
* [{#T}](#prepare-data)
* [{#T}](#create-dashboard)

## Getting started {#before-you-begin}

To get started with {{ datalens-platform-short-name }}:

{% list tabs %}

- New user {#new}

  1. [Log in]({{ link-passport-login }}) to your Yandex account. If you do not have an account, [create](https://yandex.ru/support/passport/authorization/registration.html) one.
  1. Open the {{ datalens-platform-short-name }} [home page]({{ link-datalens-platform-main }}).
  1. Click **Start in cloud**.
  1. Confirm that you have read the [Terms of use](https://yandex.com/legal/cloud_termsofuse/?lang=en). Click **Log in**.

- I am already using {{ yandex-cloud }} {#already}

  1. [Log in]({{ link-passport-login }}) to your Yandex account.
  1. Open the {{ datalens-platform-short-name }} [home page]({{ link-datalens-platform-main }}).
  1. Click **Start in cloud**.
  1. Select one of these options:

     * If you already have an organization, select it from the drop-down menu in the **Organizations** tab and click **{{ datalens-platform-short-name }}**.

       {% note info %}

       To activate a {{ datalens-platform-short-name }} instance, the user must have the `admin` or `owner` role. For more information about roles, see [{#T}](../../organization/security/index.md).

       {% endnote %}

     * If you have a cloud but no organization, click **Add new DataLens**. In the window that opens, enter a name and description for your organization and click **Create organization and DataLens**. For more information about working with organizations, see [Getting started with organizations](../../organization/quickstart.md).

{% endlist %}

## Activate the service and set up the environment {#activate-service}

On first {{ datalens-platform-short-name }} launch, follow these steps:

1. Enter the organization name and click **Continue**.
1. Answer the questions about using the service and click **Continue**.
1. Link your [billing account](../settings/service-plan.md#billing-account): select **Add**, specify the billing account, and click **Continue**, or select **Do not add** and use the [trial period](../pricing.md#trial).
1. Set up the environment for working with data: select **Set up now** and click **Continue**.

   The platform automatically creates a {{ yandex-cloud }} cloud, network, and subnet, an [environment](concepts/clusters/index.md#environments), a [REST catalog](concepts/rest-catalog/index.md), and [{{ TR }} and {{ SPRK }}](concepts/clusters/index.md#clusters) clusters. Setup takes a few minutes and continues in the background.

1. Invite users: specify email addresses of those you are going to cowork with, comma-separated, and click **Send invitations**. If you do not want to invite users yet, leave the address field empty and click **Continue**. The {{ datalens-platform-short-name }} home page opens.

   On the home page, under **Set up DataLens Platform**, you can see the setup stages: **Set up environment**, **Set up data ingestion**, **Build a dashboard**, and **Invite users**. Select **Set up environment** to check the setup status. When only {{ AF }} remains to be set up, an **Airflow setup remaining** card will appear in the section.

If skipped the environment setup during the first launch, return to it from the home page by selecting **Set up environment** under **Set up DataLens Platform**.

To view the created environment, open the ![image](../../_assets/datalens/compute.svg) **Clusters** section, go to the **Environments** tab, and click the environment name. The environment page displays the cloud, network, and subnet selected during creation.

{% note info %}

To perform the next steps, use the REST catalog and the {{ TR }}, {{ SPRK }}, and {{ AF }} clusters in the same {{ yandex-cloud }} cloud and environment. This is required so the objects can interact with each other.

{% endnote %}

If [creating the environment manually](operations/clusters/manage-environment.md#create-environment), prepare the cloud, network, and subnet in advance according to the [requirements](operations/clusters/manage-environment.md#before-you-begin). A route table with a `0.0.0.0/0` route via a NAT gateway that provides internet access must be attached to the subnet.

## Configure {{ AF }} {#configure-airflow}

To run [data processing pipelines](concepts/airflow/index.md), you need to create an {{ AF }} cluster. Follow these steps:

1. On the home page, under **Set up your DataLens Platform**, select **Set up environment**.
1. In the **Airflow setup remaining** card, click **Proceed to setup**.
1. Under **Basic settings**, specify the Git repository parameters:

   * **Repository address**: Address for SSH connection.
   * **Path to the folder with files**: Path to the folder housing DAG files in the Git repository.
   * **Branch**: Branch to pull the DAG files from.
   * **SSH key**: Contents of the private key. The corresponding public key must provide read access to the Git repository.


1. In the **Environment** field, select the same environment where the REST catalog and the {{ TR }} and {{ SPRK }} clusters are located.
1. If running the DAGs requires additional Python dependencies, fill in the **Pip packages** field under **Other settings** accordingly. Specify each dependency on a separate line: the package name or the name with an exact version via `==`. You can specify additional package components, for example:

   ```text
   numpy
   requests[security,socks]
   ```

1. Click **Create cluster**.
1. Wait for the operation to complete. After the cluster is created, you will see a list of pipelines.

If you do not plan to use pipelines yet, click **Skip** in the **Airflow setup remaining** card.

## Ingest data from a source {#load-data}

In this example, the data source is a relational {{ PG }} database, with its tables regularly ingested into the REST catalog. To ingest the data, first create a connection to the database, and then a data delivery. Currently, connections to {{ CH }}, {{ PG }}, and {{ MY }} are available for data deliveries. Moving forward, we will keep expanding the list of supported sources.

If data deliveries do not support your required source yet, you can set up ingestion using code in {{ SPRK }} or by connecting to the source in {{ TR }}. Whether a connection is possible depends on the available libraries and connectors.

### Create a connection to the source {#create-connection}

A [connection](../concepts/connection/index.md) stores the access parameters for the data source. A single connection can be used for ingesting data, collecting metadata, executing SQL queries, and creating datasets.

To create a {{ PG }} connection:

1. In the left-hand panel, select ![image](../../_assets/console-icons/database-arrow-right.svg) **Data deliveries** and click ![image](../../_assets/console-icons/plus.svg) **Create data delivery**.
1. In the **Select connection** step, click **Create connection**.
1. Under **Databases**, select **PostgreSQL**.
1. In the **Connection** step, select **Select in organization** and specify the parameters:

   * **Cloud and folder**: {{ yandex-cloud }} cloud and folder where the {{ PG }} cluster is located.
   * **Cluster**: Cluster housing the source data.
   * **Connection ID**: Connection to the selected cluster.
   * **Host**: Cluster host.
   * **Database**: Database to ingest tables from.

   To connect to an external database, select **Specify manually** and fill in the [access parameters](../operations/connection/create-postgresql.md).

1. Leave the other settings unchanged.
1. Click **Check connection**.
1. Once the check is successful, click **Create connection**.
1. In the window that opens, select a [collection](../workbooks-collections/index.md), enter the connection name, and click **Create**.
1. Wait for the connection to be created and the **Metadata** step to complete.
1. Make sure **Get metadata** is on. In the **Schedule** field, select **Every day**; in the **Time intervals** field, select the metadata update time, e.g., `00:00`. Leave the other settings unchanged.
1. Click **Continue**.

The schedule at the **Metadata** step determines how often to update the source metadata. Set the frequency of copying the data itself separately when configuring the delivery.

### Configure data delivery {#configure-transfer}

As the source, select the connection to {{ PG }} you created in the previous step. For ingestion, use the REST catalog created during the environment setup.

To [regularly copy data](concepts/data-transfer/index.md#regular-copy) from {{ PG }} to the REST catalog:

{% include [regular-copy](../../_includes/dlp/transfer/regular-copy-instruction.md) %}

{% include [activate](../../_includes/dlp/transfer/activate.md) %}

Wait for the first ingestion to complete. In the REST catalog, open the selected namespace and make sure it now includes the required tables.

## Explore data using the SQL editor {#prepare-data}

To run queries, use the {{ TR }} cluster from the same cloud and environment as the REST catalog with the loaded data.

To explore the ingested data using SQL:

1. In the left-hand panel, select ![image](../../_assets/console-icons/terminal.svg) **SQL Editor**.
1. Select the connection to the {{ TR }} cluster associated with the REST catalog you ingested the data to.
1. Create a SQL query in one of the following ways:

   * Enter the query in the editor.
   * On the **Neuroanalyst** panel, describe the data you need to retrieve, and then click **Insert into editor**.

1. Click **Execute** and check the query output.
1. Click **Save**, enter the script name, and select a collection.

You can also open the editor from the connection page or the REST catalog table page. [Learn more on working in the SQL editor](operations/sql/work-with-sql.md).

You can also build and execute SQL queries via an [external AI agent](concepts/index.md#external-agents) connected to the platform’s API.

<!-- TODO: After implementing the use case with a local agent, describe publishing the saved SQL script as a regular Airflow pipeline. -->

If an {{ AF }} pipeline has already been created for the script:

1. In the left-hand panel, select ![image](../../_assets/router.svg) **Orchestrator**.
1. Make sure the cluster’s service account can access the saved SQL script, the connection, the used data, and the computations in the {{ TR }} cluster. For the account ID, see the **Service account** card. To proceed to the [access request](operations/airflow/manage-airflow.md#service-account-access), select **Request access** in the card menu.
1. [Enable the pipeline](operations/airflow/manage-airflow.md#activate-pipeline).
1. Open the pipeline and [check the launch result](operations/airflow/manage-airflow.md#view-runs).

## Create a dashboard {#create-dashboard}

To create a [dashboard](../concepts/dashboard.md) using the [Neuroanalyst](../concepts/neuroanalyst.md):

1. Return to the {{ datalens-platform-short-name }} home page.
1. Under **Set up your DataLens**, select **Build a dashboard** and click **Show**.
1. Describe the task in the **How can I help you?** field. Specify the connection or table on which to build the dashboard, and the required metrics. Here is an example:

   > Build a dashboard based on data from the `<table_name>` table. Show the development of metrics by month and their distribution by type.

1. Send your request.
1. Wait for the Neuroanalyst to create the [dataset](../dataset/index.md) and the dashboard.
1. Open the created dashboard and check the data in its charts.

This guide walked you through setting up a {{ datalens-platform-short-name }} environment, ingesting data from {{ PG }} into the REST catalog, exploring the data using SQL, and creating a dashboard.
