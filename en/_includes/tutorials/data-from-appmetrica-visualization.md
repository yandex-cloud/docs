# Visualizing data from AppMetrica

The application added to [AppMetrica](https://appmetrica.yandex.com) will be used as the data source. You can view a list of applications available to you under [Applications](https://appmetrica.yandex.com/application/list).

If you don't have any apps available, then before performing this scenario, [add an app](https://appmetrica.yandex.com/docs/quick-start/concepts/quick-start.html) or use the standard **AppMetrica dashboard**.

To visualize data:

1. [Before you start](#before-you-begin).
1. [Create a connection and standard dashboard](#create-dashboard).
1. [Edit the standard dashboard](#edit-dashboard).

## Before you start {#before-you-begin}

{% include [before-you-begin](includes/before-you-begin-datalens.md) %}

## Create a connection and a standard dashboard {#create-dashboard}

{% note warning %}

This step is available to users who have an app in AppMetrica. If you don't have any apps, open the standard **AppMetrica dashboard** and go to the [next step](#edit-dashboard).

{% endnote %}

1. Go to [{{ datalens-short-name }}](https://datalens.yandex.com) and click **Create connection**.

    ![image](../../_assets/datalens/solution-06/02-create-connection.png)

1. Select the **AppMetrica** connection.

    ![image](../../_assets/datalens/solution-06/03-choose-appmetrica.png)

1. Enter a name for the connection: `My AppMetrica`, then click **Get token**.

    ![image](../../_assets/datalens/solution-06/get-token.png)

    If this is your first connection to an AppMetrica app, grant the necessary permissions to the service.

1. Select an app from the drop-down list.

    ![image](../../_assets/datalens/solution-06/select-an-app.png)

1. Specify the connection settings:

    ![image](../../_assets/datalens/solution-06/specify-fields.png)
    1. Set the data accuracy (sampling rate). You can change accuracy after you create the connection.
    1. Select the **Direct access** connection type.
    1. Enable **Automatically create a dashboard on this connection**.

1. In the upper-right corner, click **Create**.

    When the connection is created, a folder containing a dashboard and a set of datasets and charts opens.

## Edit the standard dashboard {#edit-dashboard}

{% note warning %}

If you don't have an app in AppMetrica and you skipped the previous step, use the **AppMetrica dashboard**.

{% endnote %}

You can edit the standard [dashboard](../../datalens/concepts/dashboard.md) however you want. For example, you can delete a chart, change its size, or change the visualization type.

1. Open the dashboard.

1. Click **Edit** in the upper-right corner.

    ![image](../../_assets/datalens/solution-06/05-edit-dashboard.png)

1. To delete the **Click dynamics** widget, click ![image](../../_assets/datalens/cross.svg) in the upper-right corner.

    ![image](../../_assets/datalens/solution-06/06-specify-widgets.png)

1. To change the size of the **Installation dynamics** widget, drag it by the lower-right corner.

1. Click **Save** in the upper-right corner to save the dashboard.

     ![image](../../_assets/datalens/solution-06/07-save-dashboard.png)

You can edit any chart on the dashboard. For example, change the visualization type for the **Ad networks** chart from the **Attracting users** section.

