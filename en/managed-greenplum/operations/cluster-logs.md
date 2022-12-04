# Viewing {{ GP }} cluster logs

{{ mgp-name }} lets you get a cluster log snippet for viewing and analysis.

## Getting a cluster log {#get-log}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select the ![image](../../_assets/logs.svg) **Logs** tab.
   1. Specify the time period for which you want to display logs: enter it manually or select it in the calendar by clicking on the date field.
   1. If necessary, request the `GREENPLUM_POOLER` log and select the hosts and logging level in the drop-down lists next to the date input field.

   A list of log entries for the selected time period will be displayed. To view detailed information about an event, click on the respective entry in the list.

   If there are too many records and only some of them are displayed, click the **Load more** link at the end of the list.

- API

   Use the [listLogs](../api-ref/Cluster/listLogs.md) API method and pass the cluster ID in the `clusterId` request parameter.

   To find out the cluster ID, [get a list of clusters in the folder](../api-ref/Cluster/list.md).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
