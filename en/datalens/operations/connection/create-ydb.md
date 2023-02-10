# Creating a {{ ydb-name }} connection

## Connecting to {{ ydb-name }} {#ydb-connection}

{% note info %}

{% if audience == "external" %}

To create a connection, you'll need a [service account](../../../iam/concepts/users/service-accounts.md) with the **ydb.viewer** [role](../../../iam/operations/sa/assign-role-for-sa.md) (or **viewer**).

{% endif %}

To write subqueries in datasets and queries in QL charts, use [YQL syntax]{% if lang == "ru" %}(https://ydb.tech/ru/docs/yql/reference/syntax/){% endif %}{% if lang == "en" %}(https://ydb.tech/en/docs/yql/reference/syntax/){% endif %}.

{% endnote %}

To create a {{ ydb-name }} connection:

{% if audience == "internal" %}

1. Go to the [connections page](https://datalens.yandex-team.ru/connections).

{% else %}

1. Go to the [connections page](https://datalens.yandex.com/connections).

{% endif %}

1. Click **Create connection**.

1. Select a **{{ ydb-short-name }}** connection.

1. Specify the connection parameters:

   * **Connection name**. Name the connection. The name can be anything.

   {% if audience == "external" %}

   * **Cloud and folder**. Select the folder where your service account will be located.
   * **Service account **. Select an existing service account or create a new one.
   * **Database**. Specify the name of the database to connect to.

   {% else %}

   * **OAuth token**. Click **Get token** or manually specify an OAuth token to use with {{ ydb-short-name }}.
   * **Hostname**. Specify the path to the {{ ydb-short-name }} host.
   * **Port**. Specify the {{ ydb-short-name }} connection port.
   * **Database name**. Specify the name of the database to connect to.

   {% endif %}

   * **Cache TTL in seconds**. Specify the cache lifetime or leave the default value. The recommended value is 300 seconds (5 minutes).
   * **Raw SQL level**. Enables you to use an ad-hoc SQL query to [generate a dataset](../../concepts/dataset/settings.md#sql-request-in-datatset).

1. Click **Create** in the top right-hand corner. The connection appears in the list.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}