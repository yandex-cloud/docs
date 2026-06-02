---
title: How to create a {{ GP }} connection in {{ datalens-full-name }}
description: In this tutorial, you will learn how to connect to {{ GP }} in {{ datalens-full-name }}.
---

# Creating a connection to {{ GP }} in {{ datalens-full-name }}



{% note warning %}

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

{% endnote %}


To create a {{ GP }} connection:

1. Open the [new connection creation page]({{ link-datalens-main }}/connections/new).
1. Under **Databases**, select the **Greenplum** connection.


1. Select the connection type:

   {% list tabs group=connection %}

   - Select in organization {#organization}

     {% include [datalens-db-select](../../../_includes/datalens/datalens-db-select.md) %}

     * **Cloud and folder**: Select the folder the cluster is located in.
     * **Cluster**: Specify the cluster from the list of available {{ GP }} clusters. Cluster settings must have the **{{ datalens-short-name }} access** option enabled. If you do not have an available cluster, click **Create new**.

       {% include [datalens-cluster-list](../../../_includes/datalens/datalens-cluster-list.md) %}

     * **Host type**: Select the host type:
       
       * **Regular** (default): Allows you to select regular hosts to connect to.
       * **Special FQDNs**: Enables you to select a [special FQDN](../../../managed-greenplum/operations/connect/fqdn.md#fqdn-master), which always points to the {{ GP }} primary master host.

     * **Host name**: Select the host name from the list of hosts available in the {{ GP }} cluster. You can select multiple hosts. If you fail to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
     * **Port**: Specify the {{ GP }} connection port. The default port is {{ port-mgp }}.
     * **Path to database**: Specify the name of the database to connect to.
     * **Username**: Specify the username for the {{ GP }} connection.
     * **Password**: Enter the password for the user.
     * **Cache TTL in seconds**: Specify the cache TTL or leave the default value. The recommended value is 300 seconds (5 minutes).
     
     {% include [datalens-db-sql-level](../../../_includes/datalens/datalens-db-connection-sql-level.md) %}

   - Specify manually {#manual}

     {% include [datalens-db-specify-mannualy](../../../_includes/datalens/datalens-db-specify-mannualy.md) %}

      * **Host name**: Specify the path to a master host or a {{ GP }} master host IP address. You can specify multiple hosts in a comma-separated list. If you fail to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      * **Port**: Specify the {{ GP }} connection port. The default port is 5432.
      * **Path to database**: Specify the name of the database to connect to.
      * **Username**: Specify the username for the {{ GP }} connection.
      * **Password**: Enter the password for the user.
      * **Cache TTL in seconds**: Specify the cache TTL or leave the default value. The recommended value is 300 seconds (5 minutes).
      
      {% include [datalens-db-sql-level](../../../_includes/datalens/datalens-db-connection-sql-level.md) %}

      ![image](../../../_assets/datalens/operations/connection/connection-greenplum.png)

   {% endlist %}


1. Optionally, test the connection by clicking **Check connection**.
1. Click **Create connection**.


1. Select the [workbook](../../workbooks-collections/index.md) to save your connection to or create a new one. If using legacy folder navigation, select a folder to save the connection to. Click **Create**.


1. Enter a name for the connection and click **Create**.



## Additional settings {#additional-settings}

You can specify additional connection settings under **Advanced connection settings**:

* **Setting collate in a query**: To explicitly define a collation for database queries, select a mode:

  * **Auto**: Applies the default setting. {{ datalens-short-name }} decides whether to enable the `en_US` locale.
  * **On**: Applies the {{ datalens-short-name }} setting. The `en_US` locale is specified for individual expressions within a query. Thus the server uses the appropriate sorting logic, regardless of the server settings and specific tables. Use the {{ datalens-short-name }} setting if your database locale is incompatible with {{ datalens-short-name }}. For more information on the locale and `LC_COLLATE`, see [{#T}](../../../managed-postgresql/operations/cluster-create.md#create-cluster).
  * **Off**: Applies the default setting. {{ datalens-short-name }} only uses database-level locale settings.

* {% include [datalens-db-connection-export-settings-item](../../../_includes/datalens/operations/datalens-db-connection-export-settings-item.md) %}

