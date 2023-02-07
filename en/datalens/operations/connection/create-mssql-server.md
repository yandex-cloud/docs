---
title: "Instructions for creating a {{ MS }} connection in {{ datalens-full-name }}"
description: "In this tutorial, you'll learn how to connect to {{ MS }} Server in {{ datalens-full-name }}."
---

# Creating a {{ MS }} connection

{% if product == "yandex-cloud" %}

{% include [connection-note](../../../_includes/datalens/datalens-connection-note.md) %}

{% endif %}

## Connecting to {{ MS }} {#ms-sql-server-connection}

To create a {{ MS }} connection:

{% if product == "yandex-cloud" %}

{% if audience == "internal" %}

1. Go to the [connections page](https://datalens.yandex-team.ru/connections).

{% else %}

1. Go to the [connections page](https://datalens.yandex.com/connections).

{% endif %}

1. Click **Create connection**.

{% endif %}

{% if product == "cloud-il" %}

1. Go to the workbook page.
1. In the upper-right corner, click **Create**→ **Connection**.

{% endif %}

1. Select **MS SQL Server** as the connection type.
1. Specify the connection parameters:
   - **Connection name**. Specify a name for the connection. You can set any name.
   - **Hostname or IP**. Specify the path to a master host or a {{ MS }} master host IP address. You can specify multiple hosts in a comma-separated list. If you are unable to connect to the first host, {{ datalens-short-name }} will select the next one from the list.
   - **Port**. Specify the {{ MS }} connection port.
   - **Database name**. Specify the name of the database to connect to.
   - **Username**. Specify the username for the {{ MS }} connection.
   - **Password**. Enter the password for the specified user.
   - **Cache TTL in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
   - **Raw SQL level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).
1. Click **Connect**. The connection appears in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}
