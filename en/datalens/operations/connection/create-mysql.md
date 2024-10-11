---
title: How to create a {{ MY }} connection in {{ datalens-full-name }}
description: In this tutorial, you will learn how to connect to {{ MY }} in {{ datalens-full-name }}.
---

# Creating a {{ MY }} connection



{% note warning %}

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

{% endnote %}


To create a {{ MY }} connection:

1. Open the page for [creating a new connection]({{ link-datalens-main }}/connections/new).
1. Under **Databases**, select the **MySQL** connection.


1. Select the connection type:

   {% list tabs group=connection %}

   - Select in organization {#organization}

     {% include [datalens-db-select](../../../_includes/datalens/datalens-db-select.md) %}

     * **Cloud and folder**: Select the folder the cluster is located in.
     * **Cluster**: Specify a cluster from the list of available {{ MY }} clusters. Cluster settings must have the **{{ datalens-short-name }}** access option enabled. If you do not have an available cluster, click **Create new**.

       {% include [datalens-cluster-list](../../../_includes/datalens/datalens-cluster-list.md) %}

     * **Host type**. Select a host type:
       
       * **Regular** (default): Allows you to select regular hosts to connect to.
       * **Special FQDNs**: Allows you to select [special FQDNs](../../../managed-mysql/operations/connect.md#special-fqdns) for connection, which always point to the current master host or to the replica in the {{ MY }} cluster that is most up-to-date with the master.

     * **Hostname**: Select the host name from the list of hosts available in the {{ MY }} cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
     * **Port**: Specify the {{ MY }} connection port. The default port is 3306.
     * **Path to database**: Specify the name of the database to connect to.
     * **Username**: Specify the username for the {{ MY }} connection.
     * **Password**: Enter the password for the user.
     * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
     * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../dataset/settings.md#sql-request-in-datatset).

   - Specify manually {#manual}

     {% include [datalens-db-specify-mannualy](../../../_includes/datalens/datalens-db-specify-mannualy.md) %}

     {% include [datalens-db-connection-parameters-mysql](../../../_includes/datalens/datalens-db-connection-parameters-mysql.md) %}

   {% endlist %}


1. (Optional) Make sure the connection works properly. To do this, click **Check connection**.
1. Click **Create connection**.


1. Select a [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.


1. Enter a name for the connection and click **Create**.



## Additional settings {#additional-settings}

{% include [datalens-db-connection-export-settings](../../../_includes/datalens/operations/datalens-db-connection-export-settings.md) %}
