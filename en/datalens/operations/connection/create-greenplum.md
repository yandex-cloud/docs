---
title: "Instructions for creating a Greenplum connection in {{ datalens-full-name }}"
description: "In this tutorial, you will learn how to connect to Greenplum in {{ datalens-full-name }}."
---

# Creating a Greenplum connection

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

## Connecting to Greenplum {#greenplum-connection}

To create a Greenplum connection:


1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.
1. Select a **Greenplum** connection.
1. In the field next to the folder name, enter the connection name. You can set any name.


1. Select the connection type:

   {% list tabs %}

   - Select in a folder

      Specify the connection parameters for the Greenplum DB available in {{ yandex-cloud }}:

      * **Cluster**: Specify a cluster from the list of available Greenplum clusters. Cluster settings must have the **DataLens access** flag set. If you do not have an available cluster, click **Create new**.

         {% note info %}

         The Greenplum clusters are shown in the list of clusters:

         * With the permissions for the user that creates the connection.
         * Created in the same folder with the {{ datalens-short-name }} instance.

         {% endnote %}

      * **Hostname**: Select the host name from the list of hosts available in the Greenplum cluster. You can select multiple hosts. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      * **Port**: Specify the Greenplum connection port. The default port is 5432.
      * **Path to database**: Specify the name of the database to connect to.
      * **Username**: Specify the username for the Greenplum connection.
      * **Password**: Enter the password for the user.
      * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
      * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   - Specify manually

      Specify the connection parameters for the external Greenplum database:

      * **Hostname**: Specify the path to the master host or the IP address of the Greenplum master host. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
      * **Port**: Specify the Greenplum connection port. The default port is 5432.
      * **Path to database**: Specify the name of the database to connect to.
      * **Username**: Specify the username for the Greenplum connection.
      * **Password**: Enter the password for the user.
      * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
      * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

   {% endlist %}



1. Click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
