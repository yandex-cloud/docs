# Visualizing {{ monitoring-full-name }} data


This scenario will be useful if you have already deployed and started one of the {{ yandex-cloud }} services.

You will create a chart using the [{{ monitoring-full-name }} query language](../../monitoring/concepts/querying.md) and add it to the dashboard.


To visualize and explore data, [set up {{ datalens-short-name }}](#before-you-begin) and follow the steps below:


1. [Create a connection](#create-connection).
1. [Create a QL chart](#create-sql-chart).
1. [Create a dashboard](#create-dashboard).
1. [Add the QL chart to the dashboard](#add-sql-chart-to-dashboard).
1. [Add selectors to the dashboard](#add-selectors-to-dashboard).


## Getting started {#before-you-begin}

To get started with {{ datalens-short-name }}:

1. [Log in]({{ link-passport-login }}) to your Yandex account.
1. Open the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
1. Click **Open Datalens**.
1. Select one of these options:

   * If you already have an organization, select it from the drop-down menu in the **Organizations** tab and click **Open DataLens**.
      
      {% note info %}

      To activate a {{ datalens-short-name }} instance, the user must have the `admin` or `owner` role. For more information about roles, see [{#T}](../../organization/security/index.md).

      {% endnote %}

   * If you have a cloud but no organization, click **Add new DataLens**. In the window that opens, enter a name and description for your organization and click **Create organization and DataLens**. For more information about working with organizations, see [Getting started with organizations](../../organization/quickstart.md).

   If you encounter a technical issue with the service, contact {{ yandex-cloud }} [support]({{ link-console-support }}). To ask for advice, discuss a solution to your issue, or explore current best practices, join the [{{ datalens-short-name }}](https://t.me/YandexDataLens) chat in Telegram. 


## Create a connection {#create-connection}

{% note info %}

To create a connection, you need a [service account](../../iam/concepts/users/service-accounts.md) with the `{{ roles-monitoring-viewer }}` or `{{ roles-viewer }}` [role](../../iam/operations/sa/assign-role-for-sa.md).
To write queries in QL charts, use the [{{ monitoring-full-name }} query language](../../monitoring/concepts/querying.md).

{% endnote %}

### Connecting to {{ monitoring-name }} {#monitoring-connection}

To create a {{ monitoring-name }} connection:

1. Go to the [connections page]({{ link-datalens-main }}/connections).
1. Click **Create connection**.
1. Select a **{{ monitoring-name }}** connection.
1. Specify the connection settings:

   * **Cloud and folder**: Select the folder with your service account.
   * **Service account**: Select an existing service account or create a new one.

1. Click **Create connection**.
1. Enter a name for the connection and click **Create**. The connection will appear in the list.

## Create a QL chart {#create-sql-chart}

1. Go to the connection you created.
1. In the top-right corner, click **Create QL chart**.
1. On the **Query** tab, enter the query text. You can either write it yourself or copy it from {{ monitoring-name }}.

   {% cut "How to copy a query from {{ monitoring-name }}" %}
   
   1. Go to the dashboard you need in {{ monitoring-name }}. To make your dashboards accessible, you need to have at least one of the {{ yandex-cloud }} services running.
   1. Open the chart you need in Metric Explorer by clicking ![image](../../_assets/console-icons/compass.svg) in the top-right corner of the chart.
   
      ![metrica-memory-usage](../../_assets/datalens/monitoring-visualization/metrica-memory-usage.png)

   1. At the bottom of the screen, go to the **Queries** tab.
   1. In the row with the query, click ![image](../../_assets/console-icons/ellipsis.svg) and select **Copy as text**. In {{ datalens-short-name }}, enter the query, skipping the `folderId` parameter.
      
      Example of a query in {{ monitoring-name }}:
      
      ```sql
      "cpu_usage"{folderId="b1g9r5h41935********", service="compute", resource_id="charts-prod-vla-1"}
      ```
      In {{ datalens-short-name }}, enter the query, skipping the `folderId` parameter:

      ```sql
      "cpu_usage"{service="compute", resource_id="charts-prod-vla-1"}
      ```

   {% endcut %}

1. On the **Parameters** tab, specify the time interval.

   ![monitoring-datetime-parameters](../../_assets/datalens/monitoring-visualization/monitoring-datetime-parameters.png)

1. Click **Start**. Check that the query runs without errors and the chart displays the data.
1. In the top-right corner, click **Save**.
1. Enter `Monitoring Data Chart` for the chart name and click **Save**.

You can add the chart to the dashboard. You can also add a selector to the dashboard to manage the `interval` parameter in the QL chart.

## Create a dashboard {#create-dashboard}

Create a [dashboard](../../datalens/concepts/dashboard.md) for the charts.

1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).

1. Click **Create dashboard**.

    ![image](../../_assets/datalens/monitoring-visualization/create-dashboard.png)

## Add the QL chart to the dashboard {#add-sql-chart-to-dashboard}

1. At the top of the page, click **Add** and select **Chart**.
   
   ![image](../../_assets/datalens/monitoring-visualization/add-chart.png)

1. In the **Chart** field, click **Select** and select the chart you created in the previous steps, `Monitoring Data Chart`, from the chart list.
   
   ![image](../../_assets/datalens/monitoring-visualization/select-chart.png)

   Click **Add**.

1. The chart is now on the dashboard. Expand it for better visualization.
1. Save the dashboard:

   1. In the top-right corner, click **Save**.
   1. Enter `Monitoring Data` for the dashboard name and click **Create**.

## Add selectors to the dashboard {#add-selectors-to-dashboard}

Add a [selector](../../datalens/dashboard/selector.md) so that you can select the time range for the displayed data.

1. At the top of the page, click **Add**.
1. Choose **Selector**.

   ![image](../../_assets/datalens/monitoring-visualization/add-selector.png)

1. Select **Manual input** as the source type.
1. Under **Field or parameter name**, enter `interval`. This query variable will get the selected values from the selector.
1. Select **Calendar** as the selector type.
1. Enable **Range**.

   ![image](../../_assets/datalens/monitoring-visualization/add-selector-parameters.png)

1. In the **Default value** field, specify an offset from the current date and click **Apply**.

   ![image](../../_assets/datalens/monitoring-visualization/selector-default-values.png)

1. Enable **Name** and enter `Date interval`.
1. Click **Add**.
1. Place the selector on the dashboard above the chart.
1. Save the dashboard.
1. Your dashboard is now ready for use and you can select the time range with the selector.
   
   ![image](../../_assets/datalens/monitoring-visualization/selector-2-values.png)

#### See also {#see-also}

* [{#T}](../../datalens/operations/dashboard/add-chart.md)
* [{#T}](../../datalens/operations/dashboard/add-selector.md)
* [{#T}](../../datalens/operations/chart/create-sql-chart.md)
* [QL charts](../../datalens/concepts/chart/index.md#sql-charts)
