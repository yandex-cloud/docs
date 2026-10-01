---
title: How to create a {{ TR }} connection in {{ datalens-full-name }}
description: In this tutorial, you will learn how to connect to {{ TR }} in {{ datalens-full-name }}.
---

# Creating a connection to {{ TR }} in {{ datalens-full-name }}

To create a {{ TR }} connection:


1. Open the [connection creation page]({{ link-datalens-main }}/connections/new).
1. Under **Databases**, select the **{{ TR }}** connection.



1. Select the connection type:

    {% list tabs group=connection %}

    - Select in organization {#organization}

      1. {% include [datalens-db-select](../../../_includes/datalens/datalens-db-select-2.md) %}

          * **Cloud and folder**: Select the folder where your service account will be located.
          * **Service account**: Select an existing service account or [create a new one]({{ link-docs }}/iam/operations/sa/create).
          * **Cluster**. Specify the cluster from the list of available {{ TR }} clusters or [create]({{ link-docs }}/managed-trino/operations/cluster-create) a new one.

          {% include [datalens-db-sql-level-2](../../../_includes/datalens/datalens-db-connection-sql-level-2.md) %}

          ![image](../../../_assets/datalens/operations/connection/connection-trino-yc.png)

      1. {% include [connection-trino-cache](../../../_includes/datalens/connection-trino-cache.md) %}
      1. {% include [connection-trino-advanced](../../../_includes/datalens/connection-trino-advanced.md) %}

    - Specify manually {#manual}

      1. Select the **Authentication type**:
          * `Without authentication`
          * `Password`
          * `JWT`

      1. {% include [connection-trino-manual](../../../_includes/datalens/connection-trino-manual.md) %}

         ![image](../../../_assets/datalens/operations/connection/connection-trino-yc-free.png)

      1. {% include [connection-trino-cache](../../../_includes/datalens/connection-trino-cache.md) %}
      1. {% include [connection-trino-advanced](../../../_includes/datalens/connection-trino-advanced.md) %}
      1. Optionally, test the connection by clicking **Check connection**.

    {% endlist %}

1. Click **Create connection**.
1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to.
1. Enter a name for the connection and click **Create**.



## Additional settings {#additional-settings}

You can specify additional connection settings under **Advanced connection settings**:


{% list tabs group=connection %}

- Select in organization {#organization}

  * {% include [datalens-db-connection-export-settings-item](../../../_includes/datalens/operations/datalens-db-connection-export-settings-item.md) %}
  * {% include [datalens-db-connection-table-list-settings-item.md](../../../_includes/datalens/operations/datalens-db-connection-table-list-settings-item.md) %}

  ![image](../../../_assets/datalens/operations/connection/connection-trino-yc-additional.png)

- Specify manually {#manual}

  {% include [connection-trino-additional-settings](../../../_includes/datalens/connection-trino-additional-settings.md) %}

{% endlist %}




## Connecting an external database {#external-db-connection}

{% include [connection-external](../../../_includes/datalens/datalens-connection-external.md) %}



## Creating a dataset {#create-dataset}

The table search scope when connecting to {{ TR }} is limited to a specific folder.

When [creating a dataset](../../dataset/create-dataset.md) based on the {{ TR }} connection:

1. In the top-right corner of the connection page, click **Create dataset**.
1. Select the folder in the source. The tables it contains will be shown on the panel below.

   {% cut "Selecting a folder in the source" %}

   ![image](../../../_assets/datalens/operations/connection/dataset-trino-catalog.png)

   {% endcut %}

1. Proceed with [this guide](../../dataset/create-dataset.md#add-data) from Step 4.

