---
title: "Instructions for creating a {{ MS }} connection in {{ datalens-full-name }}"
description: "In this tutorial, you will learn how to connect to {{ MS }} Server in {{ datalens-full-name }}."
---

# Creating a {{ MS }} connection


{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}


To create a {{ MS }} connection:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}




1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.



1. Select **MS SQL Server** as the connection type.
1. Specify the connection parameters:

   * **Hostname**: Specify the path to a master host or a {{ MS }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
   * **Port**: Specify the {{ MS }} connection port. The default port is 1433.
   * **Path to database**: Specify the name of the database to connect to.
   * **Username**: Specify the username for the {{ MS }} connection.
   * **Password**: Enter the password for the specified user.
   * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
   * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

1. Click **Create connection**.
1. Enter a name for the connection and click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
