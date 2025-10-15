---
title: How to update a {{ metadata-hub-name }} connection. Step-by-step guides
description: Step-by-step guides on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to modify connections.
---

# Editing a connection


To change connection settings:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. In the list of connections, click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the connection you want to edit.
  1. Select **{{ ui-key.yacloud.common.edit }}**.
  1. Change the required connection parameters, such as description, labels, database server settings, or user authentication information.
  1. Click **{{ ui-key.yacloud.common.apply }}** to save the changes.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  You can update settings of a connection to a cluster with a managed database or to a custom database installation.

  1. To update settings of a connection to a cluster with a managed database:

      1. View the description of the CLI command for updating a connection:

          ```bash
          yc metadata-hub connection-manager connection update <database_type> --help
          ```

          Possible database types: `postgresql`, `mysql`, `clickhouse`, `mongodb`, `opensearch`, `valkey`, `greenplum`.

      1. Update your connection by running this command:
      
          ```bash
          yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
            --name <connection_name> \
            --user <username> \
            --password <password> \
            --managed-cluster-id <cluster_ID>
          ```

          Where:

          * `--name`: Connection name.

          * `--user`: Username to connect to the cluster.

          * `--password`: User password.
      
          * `--managed-cluster-id`: Cluster ID. You can get the cluster ID with the list of clusters in the folder.

          You can get the connection ID with the [list of connections](view-connection.md#connection-list) in the folder.

      1. You can update the list of databases for all connections except {{ mos-name }} connections by running this comand:

          ```bash
          yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
            --databases <DB_list>
          ```

          Where `--databases` is a comma-separated list of databases.
          
          Make sure the user has the required access permissions.
  
  1. To update settings of a connection to a custom database installation:
      
      1. View the description of the CLI command for updating a connection:

          ```bash
          yc metadata-hub connection-manager connection update <database_type> --help
          ```

          Possible database types: `postgresql`, `mysql`, `clickhouse`, `mongodb`, `redis`, `opensearch`, `trino`, `valkey`, `greenplum`.

      1. Update your connection by running this command:
      
          ```bash
          yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
            --name <connection_name> \
            --user <username> \
            --password <password> \
            --ca-certificate <path_to_certificate>
          ```

          Where:

          * `--name`: Connection name.
          
          * `--description`: Connection description.
          
          * `--labels`: Comma-separated list of labels in `"<key>":"<value>"` format.
          
          * `--user`: Username to connect to the cluster.
          
          * `--password`: User password.
          
          * `--ca-certificate`: Path to your TLS CA certificate file.
          
            TLS is enabled by default; to disable it, use the `--tls-disabled` flag.

      1. You can also update the following:

          * List of hosts for all connections except {{ mos-name }} connections, by running this comand:

            ```bash
            yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
              --hosts <list_of_hosts>
            ```

            Where `--hosts` is a comma-separated list of hosts.

            {% note warning %}

            Host notation format depends on the database type. For more information, see the [CLI reference](../../cli/cli-ref/metadata-hub/cli-ref/connection-manager/connection/update/index.md).

            {% endnote %}

          * Coordinator parameters for connecting to {{ TR }}, by running this command:

            ```bash
            yc metadata-hub connection-manager connection update trino <connection_ID> \
              --coordinator <coordinator_parameters>
            ```

            Where `--coordinator` stands for coordinator parameters in `<host>:<port>` format.

          * List of databases for all connections except {{ TR }} and {{ OS }} connections, by running this comand:

            ```bash
            yc metadata-hub connection-manager connection update <database_type> <connection_ID> \
              --databases <DB_list>
            ```

            Where `--databases` is a comma-separated list of databases.
          
            Make sure the user has the required access permissions.

- API {#api}

  Use the [Connection.Update](../connection-manager/api-ref/Connection/update.md) REST API method or the [ConnectionService.Update](../connection-manager/api-ref/grpc/Connection/update.md) gRPC API call and provide the connection ID in the request.

  You can get the connection ID with the [list of connections](view-connection.md#connection-list) in the folder.

{% endlist %}


