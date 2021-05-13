# Creating an AppMetrica connection

## Connecting to AppMetrica {#appmetrica-connection}

To create an AppMetrica connection:


1. Go to the [connections page](https://datalens.yandex.com/connections).

1. Click **Create** and select **Connection**.

1. Select the **AppMetrica** connection.

1. In the field next to the folder name, enter the connection name. You can set any name.

1. Specify the connection parameters:

    - **OAuth token**. Click **Get token** or enter the [OAuth token](#get-oauth-token) manually to access the AppMetrica data.

    - **App**. Specify the app to connect to.

    - **Accuracy**. Set the data accuracy (sampling rate). You can change accuracy after you create the connection.

    - **Connection**. Select the **Direct access** connection type.

      {% include [datalens-get-token](../../../_includes/datalens/datalens-change-account-note.md) %}

1. Enable the option **Automatically create a dashboard, charts, and a dataset on the connection** if you need a dashboard with a standard set of charts.

1. Click **Create**.

For datasets based on AppMetrica connections, the following groups of metrics are available:

- Installations
- Audience
- Client events
- Push campaigns
- Audience + social demographic

{% include [datalens-get-token](../../../_includes/datalens/operations/datalens-get-token.md) %}

