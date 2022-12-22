To create an {{ CH }} over YT connection:

1. Go to the [connections page](https://datalens.yandex-team.ru/connections).
1. Click **Create connection**.
1. Select **CH over YT** as the connection type.
1. Enter a **Connection name**. You can set any name.
1. Select the **Authentication method**:

   {% list tabs %}

   - OAuth token

      If you choose this method, requests in YT will be run under the user whose token is specified in the **YT token** field. You can specify your own token or a robot's token. Other {{ datalens-short-name }} users will be able to work with objects on top of this connection without additional rights in YT.

      1. Click **Get token** or manually specify an OAuth token to use with YT.
      1. **Cluster**. Specify the YT cluster where tables are stored. Hahn, Arnold, and Vanga are available.
      1. **Clique**. Specify the alias of a running clique. If you're using a public clique, see the [restrictions](../../../datalens/tutorials/data-from-ch-over-yt.md#before-you-begin). To work with {{ datalens-short-name }}, we recommend creating a [private clique](https://yt.yandex-team.ru/docs/description/chyt/cliques/start).
      1. **SQL query access level**. Select the SQL query access level for the user.
      1. Click **Create**. The connection appears in the list.

   - As a user

      Cookie-based authentication is done on the YT side under the user who is viewing a dataset, chart, or dashboard. Grant access to the YT table specified in the dataset to other users so that they can view reports.

      1. **Cluster**. Specify the YT cluster where tables are stored. Hahn, Arnold, and Vanga are available.
      1. **Clique**. Specify the alias of a running clique. If you're using a public clique, see the [restrictions](../../../datalens/tutorials/data-from-ch-over-yt.md#before-you-begin). To work with {{ datalens-short-name }}, we recommend creating a [private clique](https://yt.yandex-team.ru/docs/description/chyt/cliques/start).
      1. **SQL query access level**. Select the SQL query access level for the user.
      1. Click **Create**. The connection appears in the list.

   {% endlist %}


{% note info %}

You can check the host connection before creating it. To do this, click **Check connection**.

{% endnote %}