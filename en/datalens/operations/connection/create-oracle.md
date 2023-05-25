---
title: "Instructions for creating an Oracle Database connection in {{ datalens-full-name }}"
description: "In this tutorial, you will learn how to connect to Oracle Database in {{ datalens-full-name }}."
---

# Creating an Oracle Database connection

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

To create an Oracle Database connection:


1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.
1. Select **Oracle Database** as the connection type.
1. Specify the connection parameters:

   * **Hostname**. Specify the path to the master host or the IP address of the Oracle Database master host. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
   * **Port**. Specify the Oracle Database connection port. The default port is 1521.
   * **Path to database**. Specify the service name or the system ID of the database to connect and select the **Service name** or **SID** option, respectively.
   * **Username**. Specify the username for the Oracle Database connection.
   * **Password**. Enter the password for the specified user.
   * **Cache TTL in seconds**. Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
   * **Raw SQL level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

1. Click **Create connection**.
1. Enter the name for the connection and click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
