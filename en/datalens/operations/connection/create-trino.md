---
title: How to create a {{ TR }} connection in {{ datalens-full-name }}
description: In this tutorial, you will learn how to connect to {{ TR }} in {{ datalens-full-name }}.
---

# Creating a connection to {{ TR }} in {{ datalens-full-name }}

To create a {{ TR }} connection:



1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Databases**, select the **{{ TR }}** connection.
1. Select the connection type:

   {% list tabs group=connection %}

   - Select in organization {#organization}

     {% include [datalens-db-select](../../../_includes/datalens/datalens-db-select-2.md) %}

     * **Cloud and folder**. Select the folder where your service account will be located.
     * **Service account**. Select an existing service account or create a new one.
     * **Cluster**. Specify a cluster from the list of available {{ TR }} clusters or create a new one.
     * **Cache TTL in seconds**. Specify the cache TTL or leave the default value. The recommended value is 300 seconds (5 minutes).

     {% include [datalens-db-sql-level-2](../../../_includes/datalens/datalens-db-connection-sql-level-2.md) %}

     ![image](../../../_assets/datalens/operations/connection/connection-trino-yc.png)

   - Specify manually {#manual}

     Select the authentication mode and manually specify the external database credentials to connect via a public network:

     {% list tabs group=authentication %}

     - Without authentication {#noauth}

       * **Hostname**. Specify the {{ TR }} coordinator path or IP address.
       * **Port**. Specify the {{ TR }} connection port. The default port is 8443.
       * **Username**. Specify the username for the {{ TR }} connection. (If authentication is disabled, you can use any username as it will not affect the connection. The field value will be sent together with requests to the source.)
       * **Cache TTL in seconds**. Specify the cache TTL or leave the default value. The recommended value is 300 seconds (5 minutes).

       {% include [datalens-db-sql-level-2](../../../_includes/datalens/datalens-db-connection-sql-level-2.md) %}

       ![image](../../../_assets/datalens/operations/connection/connection-trino-yc-free.png)

     - Password {#password}

       * **Hostname**. Specify the {{ TR }} coordinator path or IP address.
       * **Port**. Specify the {{ TR }} connection port. The default port is 8443.
       * **Username**. Specify the username for the {{ TR }} connection.
       * **Password**. Enter the password for the specified user.
       * **Cache TTL in seconds**. Specify the cache TTL or leave the default value. The recommended value is 300 seconds (5 minutes).

       {% include [datalens-db-sql-level-2](../../../_includes/datalens/datalens-db-connection-sql-level-2.md) %}

       ![image](../../../_assets/datalens/operations/connection/connection-trino-yc-pw.png)

     - JWT {#jwt}

       * **Hostname**. Specify the {{ TR }} coordinator path or IP address.
       * **Port**. Specify the {{ TR }} connection port. The default port is 8443.
       * **Username**. Specify the username for the {{ TR }} connection.
       * **JWT**. Specify a JWT.
       * **Cache TTL in seconds**. Specify the cache TTL or leave the default value. The recommended value is 300 seconds (5 minutes).

       {% include [datalens-db-sql-level-2](../../../_includes/datalens/datalens-db-connection-sql-level-2.md) %}

       ![image](../../../_assets/datalens/operations/connection/connection-trino-yc-jwt.png)

     {% endlist %}

     Optionally, test the connection. To do this, click **Check connection**.
     
   {% endlist %}

1. Click **Create connection**.
1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.
1. Enter a name for the connection and click **Create**.

## Additional settings {#additional-settings}

You can specify additional connection settings in the **Advanced connection settings** section:

{% list tabs group=connection %}

- Select in organization {#organization}

  * {% include [datalens-db-connection-export-settings-item](../../../_includes/datalens/operations/datalens-db-connection-export-settings-item.md) %}
  * {% include [datalens-db-connection-table-list-settings-item.md](../../../_includes/datalens/operations/datalens-db-connection-table-list-settings-item.md) %}

     ![image](../../../_assets/datalens/operations/connection/connection-trino-yc-additional.png)

- Specify manually {#manual}

  * **TLS**: If this option is enabled, {{ TR }} is accessed via `HTTPS`; if not, `HTTP`.
  * **CA Certificate**: To upload a certificate, click **Attach file** and specify the certificate file. When the certificate is uploaded, the field shows the file name.
  * {% include [datalens-db-connection-export-settings-item](../../../_includes/datalens/operations/datalens-db-connection-export-settings-item.md) %}
  * {% include [datalens-db-connection-table-list-settings-item.md](../../../_includes/datalens/operations/datalens-db-connection-table-list-settings-item.md) %}

  ![image](../../../_assets/datalens/operations/connection/connection-trino-yc-manwal-additional.png)

{% endlist %}

## Connecting an external database {#external-db-connection}

{% include [connection-external](../../../_includes/datalens/datalens-connection-external.md) %}



## Creating a dataset {#create-dataset}

The table search scope when connecting to {{ TR }} is limited to a specific folder.

When [creating a dataset](../../dataset/create-dataset.md) based on the {{ TR }} connection:

1. In the top-right corner of the connection page, click **Create dataset**.
1. Select a folder in the source. The tables it contains will be shown on the panel below.

   {% cut "Selecting a folder in the source" %}

   ![image](../../../_assets/datalens/operations/connection/dataset-trino-catalog.png)

   {% endcut %}

1. Proceed with [this guide](../../dataset/create-dataset.md#add-data) from Step 4.
