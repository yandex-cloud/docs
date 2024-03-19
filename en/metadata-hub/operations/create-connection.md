---
title: "How to manage connections. Step-by-step instructions"
description: "Step-by-step instructions for working with {{ connection-manager-name }} in {{ yandex-cloud }}. In this article you will learn how to create connections."
---

# Creating a connection

{% include notitle [preview](../../_includes/note-preview.md) %}

Create connection to on-premise database installations:

* [{#T}](#postgresql)
* [{#T}](#mysql)
* [{#T}](#clickhouse)

## {{ PG }} {#postgresql}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}) select [the folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a connection.
  1. Select the **{{ metadata-hub-name }}** service.
  1. On the left panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}**/ **Connections**.
  1. Click **Create connection**.
  1. Specify the connection name and database type.
  1. Optionally, add the connection description and [label](../../resource-manager/concepts/labels.md).
  1. Specify the address of the database server host, port number for connection, and, if the connection must be established via TLS, then if you do not have your own authorization authority, download the certificate of the CA that issued the server's TLS certificate.
  1. Provide **Username** for authentication and choose how to set a password: 
      * **Enter manually** — specify the password;
      * **Generate** — specify options for creating an automatically generated password [{{ lockbox-short-name }}](../../lockbox/quickstart.md);
  1. List the databases you want to manage connections to. You must have [access to them configured](../../managed-postgresql/security).
  1. Click **Create**.

{% endlist %}

## {{ MY }} {#mysql}

{% list tabs group=instructions %}

- Management console {#console}
  
   1. In the [management console]({{ link-console-main }}) select [the folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a connection.
   1. Select the **{{ metadata-hub-name }}** service.
   1. On the left panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}**/ **Connections**.
   1. Click **Create connection**.
   1. Specify the connection name and database type.
   1. Optionally, add the connection description and [label](../../resource-manager/concepts/labels.md).
   1. Specify the address of the database server host, port number for connection, and, if the connection must be established via TLS, then if you do not have your own authorization authority, download the certificate of the CA that issued the server's TLS certificate.
   1. Provide **Username** for authentication and choose how to set a password:
       * **Enter manually** — specify the password;
       * **Generate** — specify options for creating an automatically generated password [{{ lockbox-short-name }}](../../lockbox/quickstart.md);
   1. List the databases you want to manage connections to. You must have [access to them configured](../../managed-mysql/security).
   1. Click **Create**.

{% endlist %}

## {{ CH }} {#clickhouse}

{% list tabs group=instructions %}

- Management console {#console}
    
    1. In the [management console]({{ link-console-main }}) select [the folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create a connection.
    1. Select the **{{ metadata-hub-name }}** service.
    1. On the left panel, select ![image](../../_assets/console-icons/plug-connection.svg) **{{ connection-manager-name }}**/ **Connections**.
    1. Click **Create connection**.
    1. Specify the connection name and database type.
    1. Optionally, add the connection description and [label](../../resource-manager/concepts/labels.md). 
    1. Specify the name of the [shard](../../managed-clickhouse/operations/shards.md#list-shards), FQDN, or IP addresses of the hosts included in the shard, the HTTP or TCP port number to connect and, if the connection must be made through TLS certificate, then if you do not have your own authorization authority, download the certificate of the CA that issued the server’s TLS certificate.
    1. Provide **Username** for authentication and choose how to set a password:
        * **Enter manually** — specify the password;
        * **Generate** — specify options for creating an automatically generated password [{{ lockbox-short-name }}](../../lockbox/quickstart.md);
    1. List the databases you want to manage connections to. You must have [access to them configured](../../managed-clickhouse/security).
    1. Click **Create**.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}