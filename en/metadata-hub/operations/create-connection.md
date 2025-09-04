---
title: How to create a {{ metadata-hub-name }} connection. Step-by-step guides
description: Step-by-step guides on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to create connections.
---

# Creating a connection



{% include notitle [preview](../../_includes/note-preview.md) %}



You can create connections of the following types:
* [To a cluster with a managed database](#mdb-connection):
  * [{{ mpg-name }}](#mdb-postgresql)
  * [{{ mch-name }}](#mdb-clickhouse)
  * [{{ mmy-name }}](#mdb-mysql)
  * [{{ mrd-name }}](#mdb-redis)
  * [{{ mos-name }}](#mdb-opensearch)
  * [{{ mmg-name }}](#mdb-mongodb)
* [To a custom database installation](#on-premise-connection):
  * [{{ PG }}](#postgresql-on-premise)
  * [{{ CH }}](#clickhouse-on-premise)
  * [{{ MY }}](#mysql-on-premise)
  * [{{ RD }}](#redis-on-premise)
  * [{{ VLK }}](#valkey-on-premise)
  * [{{ TR }}](#trino-on-premise)
  * [{{ OS }}](#opensearch-on-premise)
  * [{{ MG }}](#mongodb-on-premise)

## Connecting to a cluster with a managed database {#mdb-connection}

### {{ mpg-name }} {#mdb-postgresql}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Specify the connection name.
  1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. Under **Connection to {{ PG }}**, select **{{ mpg-short-name }}** cluster as the connection type and specify the cluster you need.
  1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the cluster.
      1. Select the password setting method:
          * **Enter manually**: You set the password manually.
          * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
  1. (Optional) List the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../managed-postgresql/security/index.md).
  1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ mpg-name }} cluster, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method on the [Connection](../api-ref/grpc/Connection/) resource.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLConnection) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLConnection) reference.

{% endlist %}

### {{ mch-name }} {#mdb-clickhouse}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
    1. Under **Connection to {{ CH }}**, select **{{ mch-short-name }}** cluster as the connection type and specify the cluster you need.
    1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the cluster.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
    1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ mch-name }} cluster, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseConnection) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseConnection) reference.

{% endlist %}

### {{ mmy-name }} {#mdb-mysql}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ MY }}**, select **{{ mmy-short-name }}** cluster as the connection type and specify the cluster you need.
   1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the cluster.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. (Optional) List the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../managed-mysql/security/index.md).
   1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ mmy-name }} cluster, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLConnection) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLConnection) reference.

{% endlist %}

### {{ mrd-name }} {#mdb-redis}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. From the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** list, select **{{ VLK }}**.
    1. Under **Connection to {{ VLK }}**, select **{{ mrd-short-name }}** cluster as the connection type and specify the cluster you need.
    1. Under **Authentication**, select how to set the password:
         * **Enter manually**: Enter the password manually.
         * **Generate**: Specify the options to generate a [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password automatically.
    1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ mrd-name }} cluster, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyConnection) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyConnection) reference.

{% endlist %}

### {{ mos-name }} {#mdb-opensearch}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ OS }}**, select **{{ mos-short-name }}** cluster as the connection type and specify the cluster you need.
   1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the cluster.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. (Optional) List the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../managed-mysql/security/index.md).
   1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ mos-name }} cluster, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchConnection) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchConnection) reference.

{% endlist %}

### {{ mmg-name }} {#mdb-mongodb}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ MG }}**, select **{{ mmg-short-name }}** cluster as the connection type and specify the cluster you need.
   1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the cluster.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. (Optional) List the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../managed-mysql/security/index.md).
   1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ mmg-name }} cluster, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBConnection) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBConnection) reference.

{% endlist %}

## Connecting to a custom database installation {#on-premise-connection}

### {{ PG }} {#postgresql-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Specify the connection name.
  1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. Under **Connection to {{ PG }}**, specify the connection parameters:
      1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
      1. In the **Hosts** field, specify the database host address and port number for the connection.

          When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the host's external address.

      1. Optionally, enable TLS.
          If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
          
  1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the database.
      1. Select the password setting method:
          * **Enter manually**: You set the password manually.
          * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
  1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ PG }} custom installation, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLCluster) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.PostgreSQLCluster) reference.

{% endlist %}

### {{ CH }} {#clickhouse-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
    1. Under **Connection to {{ CH }}**, specify the connection parameters:
        1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
        1. In the **Hosts** field, specify the [FQDNs](../../managed-clickhouse/operations/connect/fqdn.md) or IP addresses of the hosts in the shard, HTTP or TCP port for connection, and the [shard](../../managed-clickhouse/operations/shards.md#list-shards) name.

            When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the the hosts’ external IP addresses.

        1. Optionally, enable TLS.
            If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
    1. Under **Authentication**:
        1. Specify the **Username** you will use to connect to the database.
        1. Select the password setting method:
            * **Enter manually**: You set the password manually.
            * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
    1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ CH }} custom installation, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseCluster) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ClickHouseCluster) reference.

{% endlist %}

### {{ MY }} {#mysql-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ MY }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the database host address and port number for the connection.

           When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the host's external address.

       1. Optionally, enable TLS.
           If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
           
   1. Under **Authentication**:
       1. Specify the **Username** you will use to connect to the database.
       1. Select the password setting method:
           * **Enter manually**: You set the password manually.
           * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ MY }} custom installation, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLCluster) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MySQLCluster) reference.

{% endlist %}

### {{ RD }} {#redis-on-premise}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. From the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** list, select **{{ RD }}**.
    1. Under **Connection to {{ RD }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the [FQDNs](../../managed-redis/operations/connect/index.md#fqdn) or IP addresses of the hosts in the shard, HTTP or TCP port for connection, and the shard name.
       1. Optionally, enable TLS.
    1. Under **Authentication**, specify a username and select how you want to set the password: 
        * **Enter manually**: Enter the password manually.
        * **Generate**: Specify the options to generate a [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password automatically.
    1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ RD }} custom installation, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.RedisCluster) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.RedisCluster) reference.

{% endlist %}

### {{ VLK }} {#valkey-on-premise}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
    1. Select **{{ metadata-hub-full-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
    1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
    1. Specify the connection name.
    1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
    1. From the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** list, select **{{ VLK }}**.
    1. Under **Connection to {{ VLK }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the [FQDNs](../../managed-redis/operations/connect/index#fqdn) or IP addresses of the hosts in the shard, HTTP or TCP port for connection, and the [shard](../../managed-redis/operations/connect/sharded.md) name.

           When creating a connection to a custom database installation intended for [{{ datalens-full-name }}](../../datalens/concepts/index.md), specify the the hosts’ external IP addresses.

       1. Optionally, enable TLS.
    1. Under **Authentication**, specify a username and select how you want to set the password: 
        * **Enter manually**: Enter the password manually.
        * **Generate**: Specify the options to generate a [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password automatically.
    1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
    1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ VLK }} custom installation, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyCluster) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.ValkeyCluster) reference.

{% endlist %}

### {{ TR }} {#trino-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
  1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
  1. Specify the connection name.
  1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
  1. Under **Connection to {{ TR }}**, specify the connection parameters:
      1. In the **Coordinator** field, specify the [coordinator](https://trino.io/docs/current/overview/concepts.html#coordinator) host address and port number for the connection. 
      1. Optionally, enable TLS.
          If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
  1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the database.
      1. Select the password setting method:
          * **Enter manually**: You set the password manually.
          * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ TR }} custom installation, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.TrinoCluster) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.TrinoCluster) reference.

{% endlist %}

### {{ OS }} {#opensearch-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ OS }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the database host address and port number for the connection.
       1. Optionally, enable TLS.
           If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
   1. Under **Authentication**:
       1. Specify the **Username** you will use to connect to the database.
       1. Select the password setting method:
           * **Enter manually**: You set the password manually.
           * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to an {{ OS }} custom installation, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchCluster) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.OpenSearchCluster) reference.

{% endlist %}

### {{ MG }} {#mongodb-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) you want to create a connection in.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_connection-manager }}**.
   1. Click **{{ ui-key.yacloud.connection-manager.label_create-connection-action }}**.
   1. Specify the connection name.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select **{{ ui-key.yacloud.connection-manager.label_connection-type }}**.
   1. Under **Connection to {{ MG }}**, specify the connection parameters:
       1. In the **{{ ui-key.yacloud.connection-manager.label_connection-type }}** field, select **Custom installation**.
       1. In the **Hosts** field, specify the database host address and port number for the connection.
       1. Optionally, enable TLS. 
           If your company has a certification authority (CA), the certificate issued by that CA will be used by default. If the company has no CA, upload the server's TLS certificate.
   1. Under **Authentication**:
       1. Specify the **Username** you will use to connect to the database.
       1. Select the password setting method:
           * **Enter manually**: You set the password manually.
           * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
   1. Click **{{ ui-key.yacloud.common.create }}**.

- API {#api}

  To create a connection to a {{ MG }} custom installation, use the [Connection.Create](../api-ref/Connection/create.md) REST API method or the [ConnectionService.Create](../api-ref/grpc/Connection/create.md) gRPC API method.

  For more information about the available request parameters, see the [REST API](../api-ref/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBCluster) and [gRPC API](../api-ref/grpc/Connection/create.md#yandex.cloud.connectionmanager.v1.MongoDBCluste) reference.

{% endlist %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
