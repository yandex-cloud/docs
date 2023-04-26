# Creating a {{ ydb-name }} connection

## Connecting to {{ ydb-name }} {#ydb-connection}

{% note info %}


To create a connection, you will need a [service account](../../../iam/concepts/users/service-accounts.md) with the **ydb.viewer** or **viewer** [role](../../../iam/operations/sa/assign-role-for-sa.md).


To write subqueries in datasets and queries in QL charts, use [YQL syntax](https://ydb.tech/en/docs/yql/reference/syntax/).

{% endnote %}

To create a {{ ydb-name }} connection:


1. Go to the [connections page]({{ link-datalens-main }}/connections).


1. Click **Create connection**.

1. Select a **{{ ydb-short-name }}** connection.

1. Specify the connection parameters:

   * **Connection name**. Name the connection. You can set any name.

   
   * **Cloud and folder**. Select the folder where your service account will be located.
   * **Service account**. Select an existing service account or create a new one.
   * **Database**. Specify the name of the database to connect to.


   {% note warning %}

   Capital letters are not allowed in {{ ydb-short-name }} database column names.

   {% endnote %}

   * **Cache TTL in seconds**: Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
   * **Raw SQL level**: Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

1. Click **Create** in the top right corner. The connection will appear in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}