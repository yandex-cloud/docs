# Creating a {{ ydb-name }} connection

## Connecting to {{ ydb-name }} {#ydb-connection}

{% note info %}


To create a connection, you'll need a [service account](../../../iam/concepts/users/service-accounts.md) with the **ydb.viewer** [role](../../../iam/operations/sa/assign-role-for-sa.md) (or **viewer**).


To write subqueries in datasets and queries in SQL charts, use [YQL syntax](https://ydb.tech/en/docs/yql/reference/syntax/).

{% endnote %}

To create a {{ ydb-name }} connection:


1. Go to the [connections page](https://datalens.yandex.com/connections).


1. Click **Create connection**.

1. Select a **{{ ydb-short-name }}** connection.

1. Specify the connection parameters:

   * **Connection name**. Name the connection. The name can be anything.

   
   * **Cloud and folder**. Select the folder where your service account will be located.
   * **Service account **. Select an existing service account or create a new one.
   * **Database**. Specify the name of the database to connect to.


   * **Cache TTL in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
   * **Raw SQL level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

1. Click **Create** in the top right-hand corner. The connection appears in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}