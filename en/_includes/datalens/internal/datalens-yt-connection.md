To create a {{ ytsaurus-name }} CHYT connection:


{% include [datalens-workbooks-collections-note](../../../_includes/datalens/operations/datalens-workbooks-collections-note.md) %}


1. Go to the [connections page](https://datalens.yandex.ru/connections).
1. Click **Create connection**.
1. Select **{{ ytsaurus-name }} CHYT** as the connection type.


1. Specify the connection parameters:

   * **{{ ytsaurus-name }} token**: Manually set the OAuth token to use with {{ ytsaurus-name }}. For more information, see the [{{ ytsaurus-name }} documentation](https://ytsaurus.tech/docs/en/user-guide/storage/auth).
   * **Hostname**: Specify the {{ ytsaurus-name }} proxy server address.
   * **Port**: Specify the CHYT connection port.
   * **Clique alias**: Specify the alias of a running clique. By default, the `*ch_public` public clique is used.
   * **Cache TTL in seconds**: Specify the cache time-to-live or leave the default value. The recommended value is 300 seconds (5 minutes).
   * **Raw SQL level**: Select the SQL query access level for the user.
   * **HTTPS**: Enable the secure connection option if your server supports HTTPS.


1. Click **Create connection**.
1. Enter a name for the connection and click **Create**.

{% include [datalens-check-host](../../../_includes/datalens/operations/datalens-check-host.md) %}

## Additional settings {#additional-settings}

{% include [datalens-db-connection-export-settings](../../../_includes/datalens/operations/datalens-db-connection-export-settings.md) %}
