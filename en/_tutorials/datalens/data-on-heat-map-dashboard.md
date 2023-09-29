# Visualizing data using Heat Maps

As a source, we will use data from **Heat Maps**, a tool that visualizes supply and demand polygons by Yandex Direct category based on set criteria.

**Heat maps** provide statistics that show supply and demand for companies and their services:

* **Demand** shows where Yandex users are searching for companies within 3 km of your location.
* **Supply** shows the number of existing companies on Yandex Maps.
* **Supply geography** shows how companies are placed on Yandex Maps.

You can use **Heat maps** to:

* Choose a good location for your offline point of sale.
* Launch ads in the Yandex Advertising Network where your potential customers can see them.
* Analyze your competitors.

{% note info %}

Users are granted access to data on the **Heat Maps** dashboard if:

* They have a Yandex Direct account.
* They have permissions to the **Heat Maps** dashboard.

User access to the **Heat Maps** dashboard is arranged by a manager who should submit an internal activation request.

{% endnote %}

To visualize and analyze the data, follow these steps:

1. [Set up a connection](#configure-connection).
   1. [Set up {{ datalens-short-name }}](#before-you-begin).
   1. [Create a connection](#create-connection).
1. [Learn how to get started with Heat Maps](#view-dashboard).
   1. [Review the contents of the folder](#view-catalog).
   1. [Set up a dashboard](#dashboard-settings).
1. [Share supply and demand statistics with other users](#share-statistics).
1. [Make a dashboard or chart public](#publish-dashboard-chart).
1. [Add a chart or dashboard to your website](#add-dashboard-chart).

We recommend that you review the [Questions and answers](#qa) section to see answers for common questions that users of supply and demand statistics may have.

## 1. Set up a connection {#configure-connection}

### 1.1 Set up {{ datalens-short-name }} {#before-you-begin}

{{ datalens-full-name }} is deployed on the {{ yandex-cloud }} platform.

Set up {{ datalens-short-name }} based on your experience:

* You're a new user (you only want to use {{ datalens-full-name }} for podcast analysis).
* You're already using {{ datalens-full-name }} (for other purposes).

{% include [before-you-begin](../includes/before-you-begin-datalens.md) %}

### 1.2. Create a connection {#create-connection}

To connect to the **Heat Maps** dashboard:

1. Follow the [link](https://datalens.yandex.ru/connections/new/smb_heatmaps) and click **Get token**.

   ![image](../../_assets/datalens/solution-heatmap/heat-map-connection.png)

1. Once the token is authorized, check a connection. To do this, click **Check connection**.
1. Leave the **Automatically create a dashboard, charts, and a dataset on the connection** option enabled.
1. Click **Create connection**. Enter **Heatmaps Connection** or any other connection name and click **Create**.

## 2. Learn how to get started with Heat Maps {#view-dashboard}

### 2.1. Review the contents of the folder {#view-catalog}

1. When the connection is created, a folder containing a set of standard objects that your statistics are based on opens:

   * ![image](../../_assets/datalens/solution-heatmap/dash.svg) Dashboard **Supply and demand**: The main page with a set of all widgets (charts, tables, and filters) where you can view the statistics. To quickly access the dashboard, save the page link to a convenient location.
   * ![image](../../_assets/datalens/solution-heatmap/dataset.svg) Dataset **smb_geo_heat_maps_dataset**: Dataset with a set of dimensions and measures used to create charts.
   * ![image](../../_assets/datalens/solution-heatmap/chart.svg) Charts: Set of individual visualizations in the form of diagrams and tables used on the dashboard.

1. Open the **Supply and demand** dashboard.

   It contains three tabs: **Demand**, **Supply**, and **Demand for supply**. Each tab contains:

   * Text widgets are headers, comments, and hints.
   * Selectors: Filters by different dimensions that can be used to filter the contents of dashboards.
   * Charts: Graphs, tables, and other visualizations.

   ![image](../../_assets/datalens/solution-heatmap/heat-map.png)

1. Add the dashboard to **Favorites**. To do this, click ![image](../../_assets/datalens/favorites-add.svg) to the right of the dashboard name at the top of the screen. To access the **Favorites** folder, click ![image](../../_assets/datalens/favorites-list.svg) in the panel on the left.

You can edit it and add standard objects as you wish.

### 2.2. Set up a dashboard {#dashboard-settings}

1. Select a city.
1. To visualize data on the map, select a category and polygon type.

Polygons of the `district` type are city districts and polygons of the `hash_n` type are defined using the `H3` geospatial indexing system with the following average sizes of their sides:

* `hash9`: 0.18 km
* `hash8`: 0.43 km
* `hash7`: 1.22 km
* `hash6`: 3.22 km

If you select a different city and the map focus remains at the same location, refresh the page. {{ datalens-short-name }} saves the data automatically: you can always continue from where you left off.

The **Demand for supply in city** measure shows demand for products and services in a specific city or district. It is calculated as follows:

1. Demand to supply ratio for the entire `city` is calculated.
1. Demand to supply ratio for the `polygon` is calculated. If the supply value is zero, the demand value is multiplied by 2.
1. `Polygon` to `city` ratio is calculated.

{% note info %}

Basic rule:

* A value less than 1 indicates that supply in the district is too high.
* A value greater than 1 indicates that there is insufficient supply in the district.
* If the value is about 1, supply is approximately equal to the average one across the city.

{% endnote %}

Pay attention to the supply and demand scale in the top-right corner. The greener the area, the higher the demand in the district or your city's hexagon. The colder the color (such as blue or red), the lower the supply.

## 3. Share supply and demand statistics with other users {#share-statistics}

To allow another user to open your dashboard, configure access to {{ datalens-full-name }}:

1. [Invite a user](../../organization/operations/add-account.md#add-or-invite-user-account) with a Yandex account or [add a federated user](../../organization/operations/add-account.md#add-user-sso).
1. Make sure that the user has access to the dashboard:

   1. Open the dashboard.
   1. In the **Add member** field, enter "All" or the name of the user who needs extended permissions.
   1. Go to the **Current object** section and set the permissions for the dashboard:

      * View: Read only is available.
      * Edit: View and edit options are available.
      * Administration: View, edit, and manage options are available.

   1. Enable the **Linked objects** option to grant permissions to other dashboard-related objects, such as connections, dashboards, and charts.

The user is granted access to your {{ datalens-short-name }} and objects with **All** permissions. You can assign this user individual permissions to objects.

You can send the link to the dashboard from the browser. For more information about permissions for {{ datalens-short-name }} objects, see the [documentation](https://cloud.yandex.com/en-ru/docs/datalens/security/#permissions).

## 4. Make a dashboard or chart public {#publish-dashboard-chart}

Data in {{ datalens-short-name }} is only available to users of a specific instance. If you want to provide unlimited public access to supply and demand statistics, publish your dashboard or a particular chart in [{{ datalens-short-name }} Public](../../datalens/concepts/datalens-public.md).

{% list tabs %}

- Publishing dashboards

   1. Open the **Supply and demand** dashboard.
   1. At the top of the dashboard interface, click ![image](../../_assets/datalens/share.svg).
   1. In the public access settings window that opens, enable **Access via link**.
   1. Confirm the publishing and click **Next**.
   1. Select the charts you want to publish with the dashboard.
   1. Copy the public link and click **Apply**.

- Publishing a chart

   1. On the navigation page, find a chart, e.g., **Demand for supply map**, and open it.
   1. At the top of the chart interface, click ![image](../../_assets/datalens/share.svg).
   1. In the public access settings window that opens, enable **Access via link**.
   1. Confirm the publishing and click **Next**.
   1. Copy the public link and click **Apply**.

{% endlist %}

## 5. Add a chart or dashboard to your website {#add-dashboard-chart}

You can embed the published charts into a website or app using the `iframe` element. To do this:

1. Follow the public link to the chart.
1. Click ![image](../../_assets/datalens/horizontal-ellipsis.svg) in the upper-right corner of the chart and select **Embed code**.
1. Copy the `iframe` code to embed in a light or dark theme.
1. Embed the code into your website.

{% note info %}

You can only embed individual charts. Embedding the entire dashboard is not supported.

{% endnote %}

## Questions and answers {#qa}

{% cut "Why can you only connect with a Yandex account?" %}

Using a Yandex account in {{ datalens-short-name }} ensures high data security.

{% endcut %}

{% cut "Can I edit a standard dashboard?" %}

Yes, you can edit the dashboard and related objects.

{% endcut %}

{% cut "I deleted a dashboard accidentally. How do I restore it?" %}

Re-create a connection and the dashboard will expand again.

{% endcut %}

{% cut "Why are chart settings so complicated?" %}

{{ datalens-short-name }} is a full-fledged data analysis and visualization tool. Use its rich set of settings to create different types of visualizations that meet a variety of user requirements.

{% endcut %}

{% cut "What else can I use {{ datalens-short-name }} for?" %}

You are not restricted to using {{ datalens-short-name }}. You can connect to your own data sources, build charts and dashboards, and share them with your colleagues.

{% endcut %}
