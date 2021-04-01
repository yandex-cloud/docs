# Viewing {{ MS }} cluster logs

{{ mms-name }} lets you get cluster logs for viewing and analysis.

{% list tabs %}

- Management console
  1. Go to the folder page and select **{{ mms-name }}**.
  1. Click on the name of the cluster and select the **Logs** tab.
  1. Specify the time period for which you want to display logs: enter it manually or select it in the calendar by clicking on the date field.
  1. Select the `SQLSERVER` component from the drop-down list next to the date field.

  A list of log entries for the selected time period will be displayed. To view detailed information about the event associated with a record, click on the record in the log.

  If there are too many records and only some of them are displayed, click the **Load more** link at the end of the list.

- API

  Use the [listLogs](../api-ref/Cluster/listLogs.md) API method: pass the ID of the required cluster in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

