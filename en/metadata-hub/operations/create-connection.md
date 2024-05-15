---
title: "How to manage connections. Step-by-step guides"
description: "Step-by-step guide on using {{ connection-manager-name }} in {{ yandex-cloud }}. In this tutorial, you will learn how to create connections."
---

# Create a connection

{% include notitle [preview](../../_includes/note-preview.md) %}

Create connections to user database installations:

* [{#T}](#postgresql)
* [{#T}](#mysql)
* [{#T}](#clickhouse)

## {{ PG }} {#postgresql}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
  1. Select **{{ metadata-hub-name }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}** / **Connections**.
  1. Click **Create connection**.
  1. Specify connection name and database type.
  1. Optionally add a connection description and [label](../../resource-manager/concepts/labels.md).
  1. Specify the connection parameters:
     * Database server host address.
     * Port number for connection.
     * For a TLS connection, if your organization has no certificate authority (CA) of its own, download a certificate from the CA that issued the server's TLS certificate. If your organization has an internal CA of its own, use certificates issued by this CA for TSL.
  1. Specify a **Username** for authentication and the method for setting the password:
      * **Enter manually**: Enter the password value manually.
      * **Generate**: Specify the options for automatic generation of the [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password.
  1. List the databases whose connections you want to manage. You must have [access to them configured](../../managed-postgresql/security).
  1. Click **Create**.

{% endlist %}

## {{ MY }} {#mysql}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
   1. Select **{{ metadata-hub-name }}**.
   1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}** / **Connections**.
   1. Click **Create connection**.
   1. Specify connection name and database type.
   1. Optionally add a connection description and [label](../../resource-manager/concepts/labels.md).
   1. Specify the connection parameters:
      * Database server host address.
      * Port number for connection.
      * For a TLS connection, if your organization has no certificate authority (CA) of its own, download a certificate from the CA that issued the server's TLS certificate. If your organization has an internal CA of its own, use certificates issued by this CA for TSL.
   1. Specify a **Username** for authentication and the method for setting the password:
      * **Enter manually**: Enter the password value manually.
      * **Generate**: Specify the options for automatic generation of the [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password.
   1. List the databases whose connections you want to manage. You must have [access to them configured](../../managed-mysql/security).
   1. Click **Create**.

{% endlist %}

## {{ CH }} {#clickhouse}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a connection.
    1. Select **{{ metadata-hub-name }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}** / **Connections**.
    1. Click **Create connection**.
    1. Specify connection name and database type.
    1. Optionally add a connection description and [label](../../resource-manager/concepts/labels.md).
    1. Specify the connection parameters:
        * [Shard](../../managed-clickhouse/operations/shards.md#list-shards) name.
        * FQDNs or IP addresses of the hosts in the shard.
        * HTTP or TCP port number for the connection.
        * For a TLS connection, if your organization has no certificate authority (CA) of its own, download a certificate from the CA that issued the server's TLS certificate. If your organization has an internal CA of its own, use certificates issued by this CA for TSL.
    1. Specify a **Username** for authentication and the method for setting the password:
        * **Enter manually**: Enter the password value manually.
        * **Generate**: Specify the options for automatic generation of the [{{ lockbox-short-name }}](../../lockbox/quickstart.md) password.
    1. List the databases whose connections you want to manage. You must have [access to them configured](../../managed-clickhouse/security).
    1. Click **Create**.

{% endlist %}


{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
