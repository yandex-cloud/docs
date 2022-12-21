# Creating an AppMetrica connection

## Connecting to AppMetrica {#appmetrica-connection}

To create an AppMetrica connection:

{% if audience == "internal" %}

1. Go to the [connections page](https://datalens.yandex-team.ru/connections).

{% else %}

1. Go to the [connections page](https://datalens.yandex.com/connections).

{% endif %}

1. Click **Create** and select **Connection**.
1. Select **AppMetrica** as the connection type.
1. In the field next to the folder name, enter the connection name. You can set any name.
1. Specify the connection parameters:

   * **OAuth token**. Click **Get token** or enter the [OAuth token](#get-oauth-token) manually to access the AppMetrica data.
   * **App**. Specify one or more applications to connect to. You can select them from the list or enter them manually separated by commas.
   * **Accuracy**. Set the data accuracy (sampling rate). You can change accuracy after you create the connection.

      {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}

1. Enable the option **Automatically create a dashboard, charts, and a dataset on the connection** if you need a dashboard with a standard set of charts.
1. Click **Create**.

{% include [datalens-appmetrica-note](../../../_includes/datalens/datalens-appmetrica-note.md) %}

For datasets based on AppMetrica connections, the following groups of metrics are available:

- Installations
- Audience
- Client events
- Push campaigns
- Audience + social demographic

{% if audience != "internal" %}

Connections to AppMetrica do not support [materialization](../../concepts/dataset/settings.md#materialization) and [public access](../../concepts/datalens-public.md) to the objects created based on it. To share a dashboard or chart created based on this connection, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}

{% endif %}

{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}
