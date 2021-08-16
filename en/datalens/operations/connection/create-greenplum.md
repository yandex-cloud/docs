# Creating a Greenplum connection

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

## Connecting to Greenplum {#greenplum-connection}

To create a Greenplum connection:

1. Go to the [connections page](https://datalens.yandex.com/connections).
1. Click **Create connection**.
1. Select a **Greenplum** connection.
1. In the field next to the folder name, enter the connection name. You can set any name.
1. Select the connection type:

    {% list tabs %}

    - Select in a folder

      Specify the connection parameters for the Greenplum DB available in {{ yandex-cloud }}:

      * **Cluster**. Specify a cluster from the list of available Greenplum clusters. If you don't have an available cluster, click **Create new**.

        {% note info %}

          The Greenplum clusters are shown in the list of clusters:
           * With the permissions for the user that creates the connection.
           * Created in the same folder with the {{ datalens-short-name }} instance.

        {% endnote %}

      * **Hostname**. Select the host name from the list of hosts available in the Greenplum cluster.
      * **Port**. Specify the Greenplum connection port. The default port is 5432.
      * **Database name**. Specify the name of the database to connect to.
      * **Username**. Specify the username for the Greenplum connection.
      * **Password**. Enter the password for the user.
      * **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).

    - Specify manually

      Specify the connection parameters for the external Greenplum database:
      * **Hostname**. Specify the path to the Greenplum host.
      * **Port**. Specify the Greenplum connection port. The default port is 5432.
      * **Database name**. Specify the name of the database to connect to.
      * **Username**. Specify the username for the Greenplum connection.
      * **Password**. Enter the password for the user.
      * **Cache lifetime in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).

    {% endlist %}

1. If necessary, enable the **Allow the use of subqueries as a source** option.
1. Click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}