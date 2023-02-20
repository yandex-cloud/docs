# Creating a {{ monitoring-name }} connection

{% note info %}

To create a connection, you need a [service account](../../../iam/concepts/users/service-accounts.md) with the `{{ roles-monitoring-viewer }}` (or `{{ roles-viewer }}`) [role](../../../iam/operations/sa/assign-role-for-sa.md).
Use the [Yandex Monitoring query language](../../../monitoring/concepts/querying.md) to write queries in QL charts.

{% endnote %}

## Connecting to {{ monitoring-name }} {#monitoring-connection}

To create a {{ monitoring-name }} connection:

1. Go to the [connections page]({{ link-datalens-main }}/connections).
1. Click **Create connection**.
1. Select **Monitoring** as the connection type.
1. Specify the connection parameters:

   * **Cloud and folder**. Select the folder where your service account is located.
   * **Service account**. Select an existing service account or create a new one.

1. Click **Create connection**.
1. Enter the connection name and click **Create**. The connection appears in the list.
