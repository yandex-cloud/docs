# Mobile app analytics based on AppMetrica data

You can visualize and explore AppMetrica data in {{ datalens-full-name }} using the following methods:

* Direct access.
   {{ datalens-name }} connects directly to AppMetrica. This method is the easiest and fastest, but the set of supported functions is [limited](../../datalens/function-ref/availability.md).
* Real-time export of data from AppMetrica to {{ mch-name }}.
   Raw data is available and its pre-aggregation and post-processing at the DB level are supported. To implement this option, [set up data export](https://appmetrica.yandex.ru/docs/common/cloud/about.html?lang=en) and [create a connection](https://cloud.yandex.com/en/docs/datalens/operations/connection/create-clickhouse) from {{ datalens-name }} to the {{ CH }} database.

In this scenario, direct access is used. An application added to [AppMetrica](https://appmetrica.yandex.com) will be used as the data source. You can view a list of applications available to you under [Applications](https://appmetrica.yandex.com/application/list).

If you don't have any apps available, then before performing this scenario, [add an app](https://appmetrica.yandex.ru/docs/quick-start/concepts/quick-start.html) or use the standard **AppMetrica Dashboard**.

To visualize and explore data, [set up {{ datalens-short-name }}](#before-you-begin) and follow the steps below:

1. [Create a connection and standard dashboard](#create-dashboard).
1. [Edit the standard dashboard](#edit-dashboard).


## Getting started {#before-you-begin}

{% include [before-you-begin](../includes/before-you-begin-datalens.md) %}


## Create a connection and a standard dashboard {#create-dashboard}

{% note warning %}

This step is available to users who have an app in AppMetrica. If you don't have any apps, open the standard **AppMetrica dashboard** and go to the [next step](#edit-dashboard).

{% endnote %}

1. Go to [{{ datalens-short-name }}]({{ link-datalens-main }}) and click **Create connection**.

   ![image](../../_assets/datalens/solution-06/02-create-connection.png)

1. Select **AppMetrica** as the connection type.

   ![image](../../_assets/datalens/solution-06/03-choose-appmetrica.png)

1. Enter a name for the connection: `My Metrica`, then click **Get token**.

   ![image](../../_assets/datalens/solution-06/get-token.png)

   If this is your first connection to an AppMetrica app, grant the necessary permissions to the service.

1. Select an app from the drop-down list.

   ![image](../../_assets/datalens/solution-06/select-an-app.png)

1. Specify the connection settings:

   ![image](../../_assets/datalens/solution-06/specify-fields.png)

   1. Set the data accuracy (sampling rate). You can change accuracy after you create the connection.
   1. Select the **Direct access** connection type.
   1. Enable **Automatically create a dashboard on this connection**.

1. In the top-right corner, click **Create**.

   When the connection is created, a folder containing a dashboard and a set of datasets and charts opens.

   {% include [datalens-appmetrica-note](../../_includes/datalens/datalens-appmetrica-note.md) %}

## Edit the standard dashboard {#edit-dashboard}

{% note warning %}

If you don't have an app in AppMetrica and you skipped the previous step, use the **AppMetrica dashboard**.

{% endnote %}

You can change the standard [dashboard](../../datalens/concepts/dashboard.md) however you want. For example, you can delete a chart, change its size, or change the visualization type.

1. Open the dashboard.

1. Click **Edit** in the top-right corner.

   ![image](../../_assets/datalens/solution-06/05-edit-dashboard.png)

1. To delete the **Click dynamics** widget, click ![image](../../_assets/datalens/cross.svg) in the upper-right corner.

   ![image](../../_assets/datalens/solution-06/06-specify-widgets.png)

1. To change the size of the **Installation dynamics** widget, drag it by the lower-right corner.

1. Click **Save** in the upper-right corner to save the dashboard.

   ![image](../../_assets/datalens/solution-06/07-save-dashboard.png)

You can edit any chart on the dashboard. For example, change the visualization type for the **Ad networks** chart from the **Attracting users** section.

To share a dashboard or chart, use one of the following methods:

{% include [datalens-metrica-appmetrica-share](../../_includes/datalens/datalens-metrica-appmetrica-share.md) %}
