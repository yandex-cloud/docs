# Creating a Metrica connection

## Connecting to Yandex Metrica {#metrica-connection}

To create a Yandex Metrica connection:

{% if audience == "internal" %}

1. Go to the [connections page](https://datalens.yandex-team.ru/connections).

{% else %}

1. Go to the [connections page](https://datalens.yandex.com/connections).

{% endif %}

1. Click **Create connection**.
1. Select **Metrica** as the connection type.
1. Specify the connection parameters:

   * **Connection name**. Specify a name for the connection. You can set any name.
   * **OAuth token**. Click **Get token** or enter the [OAuth token](#get-oauth-token) manually to access the Yandex Metrica data.
   * **Tag**. Specify one or more tracking tags to connect to. You can select them from the list or enter them manually separated by commas.

      {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}

1. Click **Connect**. The connection appears in the list.

{% include [datalens-metrica-note](../../../_includes/datalens/datalens-metrica-note.md) %}

{% if audience != "internal" %}

Connections to the Yandex Metrica API do not support [materialization](../../concepts/dataset/settings.md#materialization) and [public access](../../concepts/datalens-public.md) to the objects created based on it. To share a dashboard or chart created based on this connection, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

{% endif %}

{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}
