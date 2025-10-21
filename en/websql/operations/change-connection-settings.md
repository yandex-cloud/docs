---
title: Changing connection settings in {{ websql-full-name }}
description: Follow this guide to change connection settings.
---

# Changing connection settings

Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), you can change the settings of your [connection](../concepts/index.md#connection):

   * [To a database in a managed database cluster](#change-cluster-connection-settings).
   * [To a public database](#change-public-db-connection-settings).

## Changing connection settings for a managed database cluster {#change-cluster-connection-settings}

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the connection name and select **Update connection**.
1. Enter a new name for the connection.
1. In the **Cluster** field, select the managed database cluster you want to connect to.
1. Specify the **Username** you will use to connect to cluster databases.
1. To change the password, select the **Change password** option and enter a new user password.
1. List the **Databases** you want to connect to. You can only connect to the databases that exist in this cluster. The user you specified must have access to them.
1. Click **Apply**.

## Changing connection settings for a public database {#change-public-db-connection-settings}

1. Under ![image](../../_assets/console-icons/folder-tree.svg) [**Connections**]({{ websql-link }}), select the connection.
1. Click ![image](../../_assets/console-icons/ellipsis.svg) to the right of the connection name and select **Update connection**.
1. Enter a new name for the connection.
1. Under **Hosts**, configure the hosts:
    * Specify the database host FQDN and port number for connection to the database.

        If connecting to a database in a cluster created in {{ yandex-cloud }}, use the following ports:

        * 6432 for {{ PG }}
        * 8443 for {{ CH }}
        * 3306 for {{ MY }}

    * For {{ CH }}, also specify the Native Protocol port and [shard](../../managed-clickhouse/operations/shards.md#list-shards) name.
    * Optionally, enable TLS.

        If your company has a certification authority (CA), the certificate issued by the CA will be used by default. If the company has no CA, upload the server's TLS certificate.

1. Specify the **Username** you will use to connect to cluster databases.
1. To change the password, select the **Change password** option and enter a new user password.
1. List the **Databases** you want to connect to. You can only connect to existing databases. The user you specified must have access to them.
1. Click **Apply**.

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
