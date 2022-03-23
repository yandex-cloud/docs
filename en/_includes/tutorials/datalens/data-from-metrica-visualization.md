# Web analytics with a connection to Yandex Metrica

One of the Yandex Metrica tags that you have access to will be used as the data source. You can view a list of tags available to you at [https://metrika.yandex.com/list](https://metrika.yandex.com/list).![image](../../../_assets/datalens/solution-03/01-metrica-list.png)

If no tags are available in your list, gain access to a tag or use the Yandex Metrica demo dashboard. It's automatically created when you create a {{ datalens-short-name }} instance.

To visualize your data, follow these steps:

1. [Before you start](#before-you-begin).
1. [Create a connection and a standard dashboard](#step1).
1. [Edit the standard dashboard](#step2).
1. [Edit the chart](#step3).

## Before you start {#before-you-begin}

{% include [before-you-begin](../includes/before-you-begin-datalens.md) %}

## Step 1. Create a connection and a standard dashboard {#step1}

{% note warning %}

This step is available to users who have permission to a Yandex Metrica tag. If you don't have permissions for the tag, open the ready-to-use [**Metriсa Live Demo Dashboard**](https://datalens.yandex.com/navigation?path=Demo%2FMetrica%20Live%2FMetrica%20Live%20Demo%20Dashboard) and go to step 2.

{% endnote %}

1. Go to [{{ datalens-short-name }}]({{ link-datalens-main }}).

1. Click **Create connection**.

    ![image](../../../_assets/datalens/solution-03/02-create-connection.png)

1. Select **Metriсa**.

    ![image](../../../_assets/datalens/solution-03/03-choose-metrica.png)

1. Enter a name for the connection: **My Metrica**, then click **Get token**.

    ![image](../../../_assets/datalens/solution-03/04-metrica-creation1.png)

    If this is your first connection to a Yandex Metrica tag, grant the necessary permissions to the service.

1. Select the tag from the drop-down list.

    ![image](../../../_assets/datalens/solution-03/05-metrica-creation2.png)

1. Select [accuracy](https://yandex.com/dev/metrika/doc/api2/api_v1/sampling-docpage/) level from the drop-down list.

    ![image](../../../_assets/datalens/solution-03/06-01-metrica-creation-accuracy.png)

1. Select the **Direct access** connection type.

1. Enable **Automatically create a dashboard, charts, and a dataset on the connection**.

1. Click **Create**.

    ![image](../../../_assets/datalens/solution-03/06-metrica-creation3.png)

    When the connection is created, a folder containing the datasets, charts, and dashboard opens.

1. Go to **Dashboard with Yandex Metrica data**.

    ![image](../../../_assets/datalens/solution-03/07-open-dashboard.png)

## Step 2. Edit the standard dashboard {#step2}

{% note warning %}

If you don't have a Yandex Metrica tag and you skipped step 1, use the [**Metriсa Live Demo Dashboard**](https://datalens.yandex.com/navigation?path=Demo/Metrica/Metrica%20Live%20Demo%20Dashboard).

{% endnote %}

You can edit the standard [dashboard](../../../datalens/concepts/dashboard.md) however you want. For example, you can delete a chart you no longer need.

1. In the dashboard, click **Edit** in the upper-right corner.

    ![image](../../../_assets/datalens/solution-03/09-edit-dashboard.png)

1. Delete the **Page depth** chart. To do this, click ![image](../../../_assets/datalens/horizontal-ellipsis-black.svg) in the upper-right corner of the chart and select **Delete**.

    ![image](../../../_assets/datalens/solution-03/10-delete-charts1.png)

1. Position the **Bounce rate** and **Time on site** charts so that they fill in the empty space left after deleting the chart in the previous step. Drag the chart by clicking on the chart itself. Resize the chart using the triangle in the lower-right corner.

    ![image](../../../_assets/datalens/solution-03/11-replace-charts.png)

1. Remove the **Percentage of visits by browser** and **Sessions, views, and users by browser** charts.

    ![image](../../../_assets/datalens/solution-03/12-delete-charts2.png)

1. Click **Save** in the upper-right corner to save the dashboard.

     ![image](../../../_assets/datalens/solution-03/13-save-dashboard.png)

## Step 3. Edit the chart {step3}

You can edit any chart on the dashboard. For example, change the visualization type for the **Sessions by device type and OS** chart from the **Technologies** section.

1. Click ![image](../../../_assets/datalens/horizontal-ellipsis-black.svg) in the upper-right corner of the **Sessions by device type and OS** chart.

1. Select **Edit**.

    ![image](../../../_assets/datalens/solution-03/14-edit-chart.png)

1. In the second column of the window that opens, click **Tree chart** and choose a different chart type: **Pie chart**.

    ![image](../../../_assets/datalens/solution-03/15-choose-pie.png)

1. Click **Save** in the upper-right corner to save the chart.

    ![image](../../../_assets/datalens/solution-03/16-save-chart.png)

1. Close the chart editing tab and go back to the dashboard window.

1. Update the dashboard and make sure that the chart in the **Technologies** section changed.

    ![image](../../../_assets/datalens/solution-03/17-refresh-dashboard.png)

