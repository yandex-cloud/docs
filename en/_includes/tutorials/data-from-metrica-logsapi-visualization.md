# Visualizing data from Yandex.Metrica Logs API

**Logs API** technology lets you get non-aggregated Yandex.Metrica data, process it, and use it in analytical tasks.

{% note warning %}

To perform this scenario, you need have access to a Yandex.Metrica tag and a Clickhouse database in Yandex.Cloud.

{% endnote %}

See the list of available tags at [metrika.yandex.com/list](https://metrika.yandex.com/list).
![image](../../_assets/datalens/solution-04/01-metrica-list.png)

You can find instructions for creating a ClickHouse cluster in the [Managed Service for ClickHouse documentation](../../managed-clickhouse/operations/cluster-create.md).

To visualize the data, follow these steps:

1. [Before you start](#before-you-begin).
1. [Create a connection and a standard dashboard](#step1).
1. [Edit the standard dashboard](#step2).
1. [Edit the chart](#step3).

## Before you start {#before-you-begin}

{% include [before-you-begin](includes/before-you-begin-datalens.md) %}

## Step 1. Create a connection and a standard dashboard {#step1}

1. Go to the [interface{{ datalens-short-name }}](https://datalens.yandex.com).

1. Click **Create connection**.

    ![image](../../_assets/datalens/solution-04/02-create-connection.png)

1. Select **Metriсa**.

    ![image](../../_assets/datalens/solution-04/03-choose-metrica.png)

1. Enter a name for the connection: **My Metrica Logs API**.

1. Click **Get token**.

    ![image](../../_assets/datalens/solution-04/04-metrica-creation1.png)

1. In the window that opens, grant the necessary permissions to the service.

1. From the drop-down list under the word **Tag**, select the desired tag.

    ![image](../../_assets/datalens/solution-04/05-metrica-creation2.png)

1. Select the **Via Logs API** connection type.

    ![image](../../_assets/datalens/solution-04/06-use-logsapi.png)

1. Fill in the upload parameters and access credentials for the target database.

    1. In the **Tag source** field, choose **Sessions**.

    1. In the **Upload from** field, select from which date you wish to upload data. For example, **01.07.2019**.

    1. Select the **Regular** option. The data will be updated automatically every day.

    1. In the **Hostname** field, specify the ClickHouse database host. You can get your database access credentials on the ClickHouse cluster connection page in the console.

        {% note warning %}

        The Metrica Logs API connection can only access ClickHouse databases deployed in Yandex.Cloud.

        {% endnote %}

    1. In the **Port** field, specify the default database port **8443**.

    1. Specify the **database name**, **username**, and **password**.

    1. Click **Check connection** to verify that your database access credentials are correct. A green check mark next to the button indicates that the connection was established successfully.

    1. Enable **Automatically create a dashboard on this connection**.

    ![image](../../_assets/datalens/solution-04/07-metrica-creation3.png)

1. Click **Create connection**.

    ![image](../../_assets/datalens/solution-04/08-save-connection.png)

     {% note warning %}

     It can take from several minutes to dozens of hours to upload tag data from Yandex.Metrica to the ClickHouse database depending on the amount of data and the upload start date.

     {% endnote %}

1. When the connection is created, a folder containing the datasets, charts, and dashboard opens. Go to **Dashboard with Yandex.Metrica data**.

    ![image](../../_assets/datalens/solution-04/09-open-dashboard.png)

  If you see errors on the charts when opening the dashboard, it means that the data isn't finish loading yet. Resume the scenario in half an hour.

## Step 2. Edit the standard dashboard {#step2}

You can edit the standard [dashboard](../../datalens/concepts/dashboard.md) however you want. For example, you can delete a chart you no longer need.

1. Open the dashboard above your tag data. Try different ways of filtering your charts.

    ![image](../../_assets/datalens/solution-04/10-dashboard.png)

1. Click **Edit** in the upper-right corner.

    ![image](../../_assets/datalens/solution-04/11-edit-dashboard.png)

1. Delete the **Page depth** chart. To do this, click ![image](../../_assets/datalens/horizontal-ellipsis-black.svg) in the upper-right corner of the chart, then click **Delete**.

    ![image](../../_assets/datalens/solution-04/12-delete-chart.png)

1. Position the **Bounce rate** and **Time on site** charts so that they fill in the empty space left after deleting the chart in the previous step. You can drag the charts by clicking on them. You can resize charts (expand or shrink) using the triangle in the lower-right corner.

    ![image](../../_assets/datalens/solution-04/13-replace-charts.png)

1. Click **Save** in the upper-right corner to save the dashboard.

     ![image](../../_assets/datalens/solution-04/14-save-dashboard.png)

## Step 3. Edit the chart {step3}

You can edit any chart on the dashboard. For example, change the visualization type for the **Sessions by device type and OS** chart from the **Technologies** section.

1. Click ![image](../../_assets/datalens/horizontal-ellipsis-black.svg) in the upper-right corner of the **Sessions by device type and OS** chart.

1. Select **Edit**.

    ![image](../../_assets/datalens/solution-04/15-edit-chart.png)

1. In the second column of the window that opens, click **Tree chart** and choose a different chart type: **Pie chart**.

    ![image](../../_assets/datalens/solution-04/16-choose-pie.png)

1. Click **Save** in the upper-right corner to save the chart.

    ![image](../../_assets/datalens/solution-04/17-save-chart.png)

1. Close the chart editing tab and go back to the dashboard window.

1. Update the dashboard and make sure that the chart changed in the **Technologies** section.

    ![image](../../_assets/datalens/solution-04/18-refresh-dashboard.png)

