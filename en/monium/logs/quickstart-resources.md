# Getting started with {{ yandex-cloud }} resource logs

{{ monium-name }} allows you to work with the logs of {{ yandex-cloud }} services as well as any other logs uploaded to {{ monium-name }}, e.g., from your applications, infrastructure, or other clouds.

Follow this guide to view logs provided by {{ yandex-cloud }} resources.

{% note info %}

To learn how to configure transfer of {{ yandex-cloud }} resource logs, see the guides for the respective resource. For example, you can set up {{ AF }} cluster logging when [creating](../../managed-airflow/operations/cluster-create.md) or [updating](../../managed-airflow/operations/cluster-update.md) the cluster.

{% endnote %}

To view the logs:

1. Create a {{ yandex-cloud }} resource and configure logging for it.
   
   For the list of services that support log transfer to {{ monium-name }}, see [{#T}](../../overview/concepts/monitoring-logging-tools.md).

1. On the [{{ monium-name }}]({{ link-monium }}) home page, select **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.logs.title }}** on the left.
1. At the top, set the data search period on the timeline.
1. In the search bar, select query labels:

   {% include [yc-resource-labels](../../_includes/monium/yc-resource-labels.md) %}

1. To filter logs by other properties, select labels from the list. For example, the label `level = WARN` will display all WARNING level logs.

   For more on how to make queries, see [{#T}](../concepts/data-model.md) and [{#T}](../concepts/querying.md).

1. To view the logs of another resource immediately, click **{{ ui-key.yacloud_monitoring.querystring.action.add-query }}** and specify the properties of the {{ yandex-cloud }} resource at hand.
1. Click **{{ ui-key.yacloud_monitoring.querystring.action.execute-query }}**.

For more on logs, see [{#T}](logs-explorer.md).

## Service dashboard for logs {#logs-service-dashboard}

{% include [service-logs](../../_includes/monium/service-logs.md) %}