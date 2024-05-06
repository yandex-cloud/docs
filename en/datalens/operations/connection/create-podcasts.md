# Creating a Yandex Music podcast connection


{% note warning %}

Only users with permissions to a Yandex Music podcast can create connections and process podcast analytics. If you do not have access to any podcast, no data will be displayed on the dashboard.

You will get access after uploading a podcast to Yandex Music. The podcast is linked to the Yandex email address you specified when uploading it.

{% endnote %}

1. Go to the [connections page]({{ link-datalens-main }}/connections).
1. Click **Create connection**.
1. Select the **Podcasts Analytics** connection.

   ![image](../../../_assets/datalens/operations/connection/create-podcasts.png)

1. Click **Get key**. If this is your first time creating a connection to Yandex Music podcasts, grant the service the required permissions.
1. Leave the **Automatically create a dashboard, charts, and a dataset on the connection** option enabled if you need a folder with a standard set of datasets and charts and a ready-made dashboard.
1. Click **Check connection**.
1. After successfully checking the connection, click **Create connection**. If you use a new {{ datalens-short-name }} object model with [workbooks and collections](../../../datalens/workbooks-collections/index.md), select or create a workbook to save the connection to.
1. Enter a connection name and click **Create**.
1. Go to the **Dashboards** menu and open the **Yandex Music podcast analytics** dashboard. If there is no data, check that your current account has access to podcasts by writing to [technical support](https://yandex.com/support/music/podcast-authors/statistics.html).
