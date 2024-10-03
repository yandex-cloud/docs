---
title: How to create a {{ GP }} connection in {{ datalens-full-name }}
description: In this tutorial, you will learn how to connect to {{ GP }} in {{ datalens-full-name }}.
---

# Creating a {{ GP }} connection



{% note warning %}

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

{% endnote %}


To create a {{ GP }} connection:

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Databases**, select the **Greenplum** connection.


1. Select the connection type:

   {% list tabs group=connection %}

   - Select in organization {#organization}

      {% include [datalens-db-select](../../../_includes/datalens/datalens-db-select.md) %}

      * **Cluster**: Specify a cluster from the list of available {{ GP }} clusters. Cluster settings must have the **{{ datalens-short-name }} access** option enabled. If you do not have an available cluster, click **Create new**.

         {% include [datalens-cluster-list](../../../_includes/datalens/datalens-cluster-list.md) %}

      * **Hostname**: Select the host name from the list of hosts available in the {{ GP }} cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      * **Port**: Specify the {{ GP }} connection port. The default port is {{ port-mgp }}.
      * **Path to database**: Specify the name of the database to connect to.
      * **Username**: Specify the username for the {{ GP }} connection.
      * **Password**: Enter the password for the user.
      * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
      * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   - Specify manually {#manual}

      {% include [datalens-db-specify-mannualy](../../../_includes/datalens/datalens-db-specify-mannualy.md) %}

      * **Hostname**: Specify the path to a master host or a {{ GP }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      * **Port**: Specify the {{ GP }} connection port. The default port is 5432.
      * **Path to database**: Specify the name of the database to connect to.
      * **Username**: Specify the username for the {{ GP }} connection.
      * **Password**: Enter the password for the user.
      * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
      * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   {% endlist %}


1. (Optional) Make sure the connection works properly. To do this, click **Check connection**.
1. Click **Create connection**.


1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.


1. Enter a name for the connection and click **Create**.



## Additional settings {#additional-settings}

{% include [datalens-db-connection-export-settings](../../../_includes/datalens/operations/datalens-db-connection-export-settings.md) %}
