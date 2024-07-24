---
title: "How to manage connections. Step-by-step guides"
description: "Step-by-step guide on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to create connections."
---

# Creating a connection

{% include notitle [preview](../../_includes/note-preview.md) %}

You can create connections of the following types:
* [To a cluster with a managed database](#mdb-connection):
   * [{#T}](#mdb-postgresql)
   * [{#T}](#mdb-clickhouse)
   * [{#T}](#mdb-mysql)
* [To a user database installation](#on-premise-connection):
   * [{#T}](#postgresql-on-premise)
   * [{#T}](#clickhouse-on-premise)
   * [{#T}](#mysql-on-premise)

## Connecting to a cluster with a managed database {#mdb-connection}

### {{ mpg-name }} {#mdb-postgresql}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
  1. Select **{{ metadata-hub-full-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **Connection manager**.
  1. Click **Create connection**.
  1. Enter a name for the connection.
  1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
  1. Select the **Connection type**.
  1. Under **Connection to {{ PG }}**, select **{{ mpg-short-name }} cluster** as the connection type and specify the cluster you need.
  1. Under **Authentication**:
     1. Specify the **Username** you will use to connect to the cluster.
     1. Select the password setting method:
        * **Enter manually**: You set the password manually.
        * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
  1. (Optional) List the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../managed-postgresql/security/index.md).
  1. Click **Create**.

{% endlist %}

### {{ mch-name }} {#mdb-clickhouse}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **Connection Manager**.
   1. Click **Create connection**.
   1. Enter a name for the connection.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select the **Connection type**.
   1. Under **Connection to {{ CH }}**, select **{{ mch-short-name }} cluster** as the connection type and specify the cluster you need.
   1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the cluster.
      1. Select the password setting method:
         * **Enter manually**: You set the password manually.
         * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. Click **Create**.

{% endlist %}

### {{ mmy-name }} {#mdb-mysql}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **Connection Manager**.
   1. Click **Create connection**.
   1. Enter a name for the connection.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select the **Connection type**.
   1. Under **Connection to {{ MY }}**, select **{{ mmy-short-name }} cluster** as the connection type and specify the cluster you need.
   1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the cluster.
      1. Select the password setting method:
         * **Enter manually**: You set the password manually.
         * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. (Optional) List the databases whose connections you want to manage. You can connect only to the databases that exist in the cluster. You must have [access to them configured](../../managed-mysql/security/index.md).
   1. Click **Create**.

{% endlist %}

## Connecting to a user database installation {#on-premise-connection}

### {{ PG }} {#postgresql-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **Connection Manager**.
   1. Click **Create connection**.
   1. Enter a name for the connection.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select the **Connection type**.
   1. Under **Connection to {{ PG }}**, specify the connection parameters:
      1. In the **Connection type** field, select **User installation**.
      1. In the **Hosts** field, specify the database host address and port number for the connection.
      1. (Optional) Enable TLS.

         If your company has a certification authority (CA), the certificate issued by the CA will be used by default. If the company has no CA, upload the server's TLS certificate.
   1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the database.
      1. Select the password setting method:
         * **Enter manually**: You set the password manually.
         * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
   1. Click **Create**.

{% endlist %}

### {{ CH }} {#clickhouse-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **Connection Manager**.
   1. Click **Create connection**.
   1. Enter a name for the connection.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select the **Connection type**:
   1. Under **Connection to {{ CH }}**, specify the connection parameters:
      1. In the **Connection type** field, select **User installation**.
      1. In the **Hosts** field, specify the [FQDNs](../../managed-clickhouse/operations/connect/fqdn.md) or IP addresses of the hosts in the shard, HTTP or TCP port for connection, and the [shard](../../managed-clickhouse/operations/shards.md#list-shards) name.
      1. (Optional) Enable TLS.

         If your company has a certification authority (CA), the certificate issued by the CA will be used by default. If the company has no CA, upload the server's TLS certificate.
   1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the database.
      1. Select the password setting method:
         * **Enter manually**: You set the password manually.
         * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. Click **Create**.

{% endlist %}

### {{ MY }} {#mysql-on-premise}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
   1. Select **{{ metadata-hub-full-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **Connection Manager**.
   1. Click **Create connection**.
   1. Enter a name for the connection.
   1. (Optional) Add a description and [label](../../resource-manager/concepts/labels.md) for the connection.
   1. Select the **Connection type**:
   1. Under **Connection to {{ MY }}**, specify the connection parameters:
      1. In the **Connection type** field, select **User installation**.
      1. In the **Hosts** field, specify the database host address and port number for the connection.
      1. (Optional) Enable TLS.

         If your company has a certification authority (CA), the certificate issued by the CA will be used by default. If the company has no CA, upload the server's TLS certificate.
   1. Under **Authentication**:
      1. Specify the **Username** you will use to connect to the database.
      1. Select the password setting method:
         * **Enter manually**: You set the password manually.
         * **Generate**: Password will be generated automatically. You can configure [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password generation rules or leave the default ones.
   1. (Optional) List the databases whose connections you want to manage. You must have access to them configured.
   1. Click **Create**.

{% endlist %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
