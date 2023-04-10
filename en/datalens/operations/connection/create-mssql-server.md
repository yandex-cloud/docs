---
title: "Instructions for creating a {{ MS }} connection in {{ datalens-full-name }}"
description: "In this tutorial, you'll learn how to connect to {{ MS }} Server in {{ datalens-full-name }}."
---

# Creating a {{ MS }} connection


{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}


## Connecting to {{ MS }} {#ms-sql-server-connection}

To create a {{ MS }} connection:



1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.



1. Select **MS SQL Server** as the connection type.
1. Specify the connection parameters:
   - **Connection name**: Specify a name for the connection. You can set any name.
   - **Hostname or IP**: Specify the path to a master host or a {{ MS }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
   - **Port**: Specify the {{ MS }} connection port.
   - **Path to database**: Specify the name of the database to connect to.
   - **Username**: Specify the username for the {{ MS }} connection.
   - **Password**: Enter the password for the specified user.
   - **Cache lifetime in seconds**: Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
   - **SQL query access level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).
1. Click **Connect**. The connection will appear in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
