---
title: "How to create a {{ MY }} connection in {{ datalens-full-name }}"
description: "In this tutorial, you will learn how to connect to {{ MY }} in {{ datalens-full-name }}."
---

# Creating a {{ MY }} connection


{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}


To create a {{ MY }} connection:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}




1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.



1. Select **MySQL** as the connection type.



1. Select the connection type:

   {% list tabs %}

   - Select in a folder

      {% note info %}

      Only the current organization's databases are available.
      To connect to a database from a different organization, use the **Specify manually** connection type and make sure the database has [public access](../../../managed-mysql/concepts/network.md#public-access-to-host) enabled.

      {% endnote %}

      Specify the connection parameters for the {{ MY }} DB available in {{ yandex-cloud }}:

      - **Cluster**: Specify a cluster from the list of available {{ MY }} clusters. Cluster settings must have the **{{ datalens-short-name }} access** option enabled. If you do not have an available cluster, click **Create new**.

         {% note info %}

         The {{ MY }} clusters are shown in the list of clusters:

         - With the permissions for the user that creates the connection.
         - Created in the same folder with the {{ datalens-short-name }} instance.

         {% endnote %}

      - **Hostname**: Select the host name from the list of hosts available in the {{ MY }} cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      - **Port**: Specify the {{ MY }} connection port. The default port is 3306.
      - **Path to database**: Specify the name of the database to connect to.
      - **Username**: Specify the username for the {{ MY }} connection.
      - **Password**: Enter the password for the user.
      - **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
      - **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   - Specify manually

      {% note info %}

      You can only use managed databases with [public access](../../../managed-mysql/concepts/network.md#public-access-to-host) enabled.
      To connect to a managed database without public access, use the **Select in folder** connection type.

      {% endnote %}

      Specify the connection parameters for the external {{ MY }} database:

      {% include [datalens-db-connection-parameters-mysql](../../../_includes/datalens/datalens-db-connection-parameters-mysql.md) %}

   {% endlist %}




1. Click **Create connection**.
1. Enter a name for the connection and click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}

## Additional settings {#additional-settings}

{% include [datalens-db-connection-export-settings](../../../_includes/datalens/operations/datalens-db-connection-export-settings.md) %}
