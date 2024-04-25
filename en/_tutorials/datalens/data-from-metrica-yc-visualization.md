# Web analytics with funnels and cohorts calculated based on Yandex Metrica data


{% include [serverless-deprecation-note](../../_includes/datasphere/serverless-deprecation-note.md) %}

In this tutorial, you will learn how to build conversion funnels, run cohort analysis, calculate the Retention rate for the user base in {{ ml-platform-full-name }}, and visualize the data in {{ datalens-full-name }}.

Yandex Metrica data is used as the data source.

1. [Connect {{ CH }} and {{ ml-platform-short-name }}](#ch-datasphere-connection):
   1. [Connect {{ CH }}](#ch-connection).
   1. [Connect {{ ml-platform-short-name }}](#datasphere-connection).
   1. [Clone the repository to {{ ml-platform-short-name }}](#clone-repo-to-datasphere).
1. [Retrieve and upload data to {{ CH }}](#get-download-data-in-ch):
   1. [Yandex Metrica. Create an app and get an access token](#create-metrica-app-token).
   1. [{{ ml-platform-short-name }}. Upload data via the Yandex Metrica Logs API](#uploading-data-logs-api).
   1. [{{ ml-platform-short-name }}. Download the test tag data via Yandex Disk](#uploading-data-counter-from-disk).
   1. [{{ CH }}. Get the cluster IP address](#getting-ch-cluster-host).
   1. [{{ ml-platform-short-name }}. Upload the data to {{ CH }}](#uploading-data-counter-to-ch).
1. [Connect {{ datalens-short-name }} and create charts](#datalens-connection-chart-creation):
   1. [Connect to {{ datalens-short-name }}](#datalens-connection).
   1. [Create a connection to {{ CH }} in {{ datalens-short-name }}](#creation-datalens-connection-to-ch).
   1. [Create a dataset based on the connection](#creating-dataset-based-on-connection).
   1. [Create a stacked area chart](#creating-area-chart).
   1. [Create a pivot table chart](#creating-pivot-table).
1. [Create and configure a dashboard in {{ datalens-short-name }}](#creating-configuring-dashboard):
   1. [Create a dashboard](#creating-dashboard).
   1. [Set up a dashboard](#configuring-dashboard).
1. [Build conversion funnels](#funnels):
   1. [{{ ml-platform-short-name }}. Build funnels](#calculating-funnels-datasphere).
   1. [{{ datalens-short-name }}. Funnels by browser. Create a dataset](#calculating-browser-funnels-dataset).
   1. [{{ datalens-short-name }}. Funnels by browser. Create a chart](#calculating-browser-funnels-chart).
   1. [{{ datalens-short-name }}. Funnels by browser. Add a chart to your dashboard](#add-browser-funnels-chart-on-dashboard}).
   1. [{{ datalens-short-name }}. Funnels by browser. Set up a dashboard](#setting-browser-funnels-chart-on-dashboard).
1. [Perform cohort analysis](#cohorts):
   1. [{{ ml-platform-short-name }}. Perform cohort analysis](#cohort-analysis).
   1. [{{ datalens-short-name }}. Create a dataset and a chart with cohort visualization](#creating-dataset-chart-with-cohort).
   1. [{{ datalens-short-name }}. Configure a chart with cohort visualization](#creating-chart-with-cohort).
   1. [{{ datalens-short-name }}. Create a chart with retention](#creating-chart-with-retention).
   1. [{{ datalens-short-name }}. Add charts to a new dashboard tab](#adding-charts-to-dashboard-tab).
   1. [{{ datalens-short-name }}. Create charts](#creating-chart).
   1. [{{ datalens-short-name }}. Add charts to the dashboard](#adding-chart-to-dashboard).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin-datasphere.md) %}

{% note tip %}

To make sure {{ datalens-full-name }} and {{ ml-platform-full-name }} can run within the {{ yandex-cloud }} network, create their instances in the same organization.

{% endnote %}

### Required paid resources {#paid-resources}

The cost of the infrastructure deployment includes:

* Fee for the cluster computing resources and storage (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* Fee for the computation time (see [{{ ml-platform-name }} pricing](../../datasphere/pricing.md)).
* Fee for the outbound traffic (see [{{ vpc-name }} pricing](../../vpc/pricing.md)).

## 1. Connect {{ CH }} and {{ ml-platform-short-name }} {#ch-datasphere-connection}

### 1.1. Connect {{ CH }} {#ch-connection}

1. In the [management console]({{ link-console-main }}), select a folder to create a {{ CH }} cluster in.
1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. In the window that opens, click **{{ ui-key.yacloud.clickhouse.button_create-cluster }}**.
1. Specify the settings for a {{ CH }} cluster:
   1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, specify a name for the cluster.
   1. Under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**, select the `Intel Cascade Lake` platform, the `burstable` type, and the `b2.medium` host type.

      {% note warning %}

      We do not recommend using `burstable` VM configurations in production environments. This tutorial uses them as an example. For production solutions, use `standard` or `memory-optimized` configurations.

      {% endnote %}

   1. Under **{{ ui-key.yacloud.mdb.forms.section_disk }}**, keep the value of `10 {{ ui-key.yacloud.mdb.forms.label_max-size-units }}`.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, click ![pencil](../../_assets/console-icons/pencil.svg). Enable the **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** option and click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.
   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**, disable user management via SQL, enter the username, password, and database name (e.g., `metrica_data`).

   1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**, enable the following options:
      * **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**
      * **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**
      * **{{ ui-key.yacloud.mdb.forms.additional-field-metrika }}**
      * **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**
   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

### 1.2. Connect {{ ml-platform-short-name }} {#datasphere-connection}

1. Open the {{ ml-platform-name }} [home page]({{ link-datasphere-main }}).
1. In the left-hand panel, select ![image](../../_assets/console-icons/circles-concentric.svg) **{{ ui-key.yc-ui-datasphere.common.spaces }}**.
1. Select the community to create a project in.
1. On the community page, click ![image](../../_assets/console-icons/folder-plus.svg) **{{ ui-key.yc-ui-datasphere.projects.create-project }}**.
1. In the window that opens, enter a name and description (optional) for the project. The naming requirements are as follows:

   {% include [name-format](../../_includes/name-format.md) %}

1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. Click **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}**.

This is the {{ jlab }}Lab development environment, and you are going to use it to complete the next steps.

### 1.3. Clone the repository to {{ ml-platform-short-name }} {#clone-repo-to-datasphere}

1. In the **Git** menu, select **Clone**.
1. In the window that opens, specify the **URI** of the `repositoryhttps://github.com/zhdanchik/yandex_metrika_cloud_case.git` and click **CLONE**.
1. Click **OK**.

## 2. Retrieve and upload data to {{ CH }} {#get-download-data-in-ch}

If you do not yet have a Yandex Metrica tag or it has not accumulated enough data, or if you want to be sure that you get a result by completing all steps in the tutorial, go to step [2.3](#uploading-data-counter-from-disk) (skip steps [2.1](#create-metrica-app-token) and [2.2](#uploading-data-logs-api)).

If you have a Yandex Metrica tag and can access it, go to step [2.1](#create-metrica-app-token) and [2.2](#uploading-data-logs-api) (skip step [2.3](#uploading-data-counter-from-disk)). We recommend walking through these steps if you are an experienced user because the logic of calculating funnels and cohorts depends on the data itself, and you may need to tweak the scripts.

### 2.1. Yandex Metrica. Create an app and get an access token {#create-metrica-app-token}

1. To work with the API, get your [OAuth token](https://tech.yandex.com/oauth/doc/dg/tasks/get-oauth-token-docpage/).
1. Create an app:
   1. Go to [https://oauth.yandex.ru/client/new](https://oauth.yandex.com/client/new).
   1. Enter a name for the service.
   1. Go to **Platforms** → **Web services**. In the **Redirect URI** field, enter `https://oauth.yandex.com/verification_code`.
   1. Under **Access to data**, enter `metrika` and select **Access to statistics and ability to view all counter settings (metrika:read)**.
   1. Click **Create app**.
   1. In the window that opens, a description of the application will appear. Save the ClientID of your app.

1. Click `https://oauth.yandex.ru/authorize?response_type=token&client_id=<app_ID>`. Paste the ClientID of your app as `<app_ID>`.
1. Click **Log in as**.
1. Save the received access token.

### 2.2. {{ ml-platform-short-name }}. Upload data via the Yandex Metrica Logs API {#uploading-data-logs-api}

1. In the {{ ml-platform-short-name }} project, in the root of the working directory, create a text file. To do this, click **Text File** in the workspace.
1. Name the file `.yatoken.txt` and paste the obtained access token to the file contents. Save the changes and close the file.
1. Open the **yandex_metrika_cloud_case** folder → **1a. get_data_via_logs_api.ipynb** notebook.
1. Use your Yandex Metrica tag ID as the value of the `COUNTER_ID` variable. You can find your Yandex Metrica tag ID on the [My tags](https://metrika.yandex.ru/list?) page.
1. Enter the start date for the analyzed period in the `START_DATE` variable.
1. Enter the end date for the analyzed period in the `END_DATE` variable.

   {% note warning %}

   The date range will NOT include the end date. For example, to get data up to December 5, 2022, paste `2022-12-06` into the `END_DATE` variable

   {% endnote %}

1. Complete all steps (cells with code) in the **1a. get_data_via_logs_api.ipynb** notebook.

If you could not get data for the demo tag from the Logs API, you can [download it via Yandex Disk](#uploading-data-counter-from-disk).

### 2.3. {{ ml-platform-short-name }}. Download the test tag data via Yandex Disk {#uploading-data-counter-from-disk}

{% note info %}

Skip this section if you are using your own tag data.

{% endnote %}

1. Open the **yandex_metrika_cloud_case** folder → **1b. get_data_via_yadisk.ipynb** notebook.
1. Complete all steps (cells with the code) in the **1b. get_data_via_yadisk.ipynb** notebook.

### 2.4. {{ CH }}. Get the cluster IP address {#getting-ch-cluster-host}

1. In the [management console]({{ link-console-main }}), go to the created {{ CH }} cluster. Wait until the cluster status changes to `Alive`. Then open the cluster by clicking it.
1. Select ![hosts](../../_assets/console-icons/cube.svg) **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** from the list on the left.
1. On the **{{ ui-key.yacloud.mdb.cluster.hosts.switch_overview }}** tab, copy the host name.

### 2.5. {{ ml-platform-short-name }}. Upload the data to {{ CH }} {#uploading-data-counter-to-ch}

1. Open the **yandex_metrika_cloud_case** folder → **2. upload_data_to_{{ CH }}.ipynb** notebook:
   1. Paste the copied host name into the `CH_HOST_NAME` variable.
   1. In the `CH_USER` variable, insert the name of the user you specified when [creating your {{ CH }} cluster](#ch-connection).
   1. In the `CH_DB_NAME` variable, insert the database name you specified when [creating your {{ CH }} cluster](#ch-connection).

1. In the root directory, create a new text file named `.chpass.txt`.
1. In the `.chpass.txt` file, paste the user password you specified when [creating your {{ CH }} cluster](#ch-connection). Save and close the file.
1. Complete all the steps (the cells with the code) in the notebook.

## 3. Connect {{ datalens-short-name }} and create charts {#datalens-connection-chart-creation}

### 3.1. Connect to {{ datalens-short-name }} {#datalens-connection}

1. In the [management console]({{ link-console-main }}), open the page of the {{ CH }} cluster you created.
1. On the left side of the window, select ![datalens](../../_assets/console-icons/chart-column.svg) **{{ datalens-short-name }}**.
1. Click **Create connection**.

### 3.2. Create a connection to {{ CH }} in {{ datalens-short-name }} {#creation-datalens-connection-to-ch}

1. Fill in the connection settings:

   1. Select a cluster from the **Cluster** drop-down list or create a new one. If the cluster is missing in the list, click **Specify manually**, then specify the [{{ CH }} cluster](#ch-connection) name.
   1. Select a [{{ CH }} host](#ch-connection) from the **Host name** drop-down list.
   1. Select the [username](#ch-connection).
   1. Enter the [password](#ch-connection) and click **Check connection**.

1. When the connection check succeeds, click **Create connection**. In the window that opens, enter the connection name and click **Create**.

### 3.3. Create a dataset based on the connection {#creating-dataset-based-on-connection}

1. In the top-right corner, click **Create dataset**.
1. Select the `metrica_data.hits` table as a source. To do this, drag the table from the list on the left to the editing area.
1. Open the **Fields** tab.
1. In the top-right corner, click ![plus](../../_assets/console-icons/plus.svg) **Add field**.
1. To calculate the number of hits, create a calculated field: name it `Hits`, enter `1` in the workspace, and click **Create**.
1. For the `Hits` field, select the **Amount** value in the **Aggregation** column.
1. Rename the `Browser` field to `Browser`.
1. In the top-right corner, click **Save**.
1. Name the dataset `ch_metrica_data_hits` and click **Create**.

### 3.4. Create a stacked area chart {#creating-area-chart}

1. In the top-right corner, click **Create chart**.
1. In the window that opens, drag the following fields to the chart section:
   * `EventDate`, to the **X** section.
   * `Browser`, to the **Colors** section.
   * `Hits`, to the **Y** section.
1. Change the chart type from **Column chart** to **Stacked area chart**.
1. Click **Save**.
1. In the window that opens, enter `ch_metrica_data_hits_area` as the chart name and click **Save**.

### 3.5. Create a pivot table chart {#creating-pivot-table}

1. In the top-right corner, click ![save-button](../../_assets/console-icons/chevron-down.svg) → **Save as copy**.
1. For the chart copy, enter `ch_metrica_data_hits_table` as the new name and click **Save**.
1. Select **Pivot table** as the new chart type.
1. Add or drag the following fields to the chart area:
   * `Browser`, to the **Rows** section.
   * `Hits`, to the **Sorting** section.
1. Click **Save**.

## 4. Create and configure a dashboard in {{ datalens-short-name }} {#creating-configuring-dashboard}

### 4.1. Create a dashboard {#creating-dashboard}

1. In the left-hand panel, select ![dashboards](../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and click **Create dashboard**.
1. Add the first chart to the dashboard. To do this, in the top-right corner, click **Add** ![save-button](../../_assets/console-icons/chevron-down.svg) → **Chart**:
   1. From the **Chart** drop-down list, select `ch_metrica_data_hits_area`.
   1. In the **Name** field, enter **Hits by browser** as the chart name and click **Add**.
1. Similarly, add the `ch_metrica_data_hits_table` chart named **Hits by browser for period**.
1. Move the charts and resize them on the dashboard:
   1. Drag the table chart to the right of the diagram chart.
   1. To change the vertical dimensions of the charts, drag them by the bottom-right corner.
1. Save the dashboard:

   1. In the top-right corner, click **Save**.
   1. Enter `ch_metrica_data` as the dashboard name and click **Create**.

### 4.2. Set up a dashboard {#configuring-dashboard}

1. Add filtering to select a specific browser. To do this, in the top-right corner, click **Add** ![save-button](../../_assets/console-icons/chevron-down.svg) → **Chart**.
1. You can add the selector to a field from any dataset. From the **Dataset** list, select the `ch_metrica_data_hits` dataset you created.
1. In the **Field** list, select `Browser`.
1. Enable the **Multiple choice** option.
1. In the **Default value** field, select browsers:
   * `android_browser`
   * `chrome`
   * `chromemobile`
   * `firefox`
   * `opera`
   * `safari`
   * `safari_mobile`
   * `samsung_internet`
   * `yandex_browser`
   * `yandexsearch`
1. In the **Name** field, enter a name for the selector and enable the option.
1. Click **Add**.
1. Drag the selector to the top of the dashboard and stretch it horizontally.
1. In the top-right corner, click **Save**.

## 5. Build conversion funnels {#funnels}

### 5.1. {{ ml-platform-short-name }}. Build funnels {#calculating-funnels-datasphere}

1. Open the {{ ml-platform-name }} [home page]({{ link-datasphere-main }}).
1. Open the **3. funnels.ipynb** notebook. Specify the host, the user, and the DB name.
1. Run the cells and evaluate the analysis results.
   In {{ CH }}, the `metrica_data.funnels_by_bro` table will be created, where funnels are calculated by browser.

### 5.2. {{ datalens-short-name }}. Funnels by browser. Create a dataset {#calculating-browser-funnels-dataset}

Create a new dataset based on the new table and the connection to {{ CH }}:

1. Open the [{{ datalens-short-name }}]({{ link-datalens-main }}/) home page (or click ![datalens-console](../../_assets/datalens-console.svg) **DataLens** in the left-hand panel) and click **Create dataset**.
1. Go to the **Connections** section and click ![image](../../_assets/console-icons/plus.svg) **Add**.
1. From the list of connections, select the connection name that you created in Step [3.2](#creation-datalens-connection-to-ch).
1. Drag the new `metrica_data.funnels_by_bro` table to the editing area.
1. Open the **Fields** tab:
   1. Rename the `step X` fields to `Step X`, where X is the step number.
   1. Specify the **Sum** value in the **Aggregation** column for the `Step X` fields and click **Save**.
1. Name the dataset `ch_metrica_data_funnels_by_bro` and click **Create**.

### 5.3. {{ datalens-short-name }}. Funnels by browser. Create a chart {#calculating-browser-funnels-chart}

Create a chart based on the `ch_metrica_data_funnels_by_bro` dataset:

1. Click **Create chart**.
1. Select the **Pivot table** chart type.
1. Drag the fields to the chart sections:
   * `Browser`, to the **Rows** section.
   * `Step X`, to the **Measures** section, where X is the step sequence number.
   * `Step 1`, to the **Sorting** section.
1. Click **Save**.
1. Enter `ch_metrica_data_funnels_by_bro_table` as the chart name and click **Save**.

### 5.4. {{ datalens-short-name }}. Funnels by browser. Add a chart to your dashboard {#add-browser-funnels-chart-on-dashboard}

1. Go to the created dashboard from the [dashboards]({{ link-datalens-main }}/dashboards) page.
1. Add a new chart. In the top-right corner, click **Edit**:
   1. Click **Add** ![save-button](../../_assets/console-icons/chevron-down.svg) → **Chart**.
   1. From the **Chart** drop-down list, select the `ch_metrica_data_funnels_by_bro_table` chart.
   1. In the **Name** field, enter `Funnels by browser` as the chart name and click **Add**.
1. Place the new chart to the right of the existing two. Stretch the chart so that it matches the others vertically and reaches the right border of the page.
1. Click **Save**.

### 5.5. {{ datalens-short-name }}. Funnels by browser. Set up a dashboard {#setting-browser-funnels-chart-on-dashboard}

Configure relationships so that the selector affects the new chart from another dataset:

1. Click **Edit** → **Links**.
1. In the window that opens, select the `Browser` selector from the list.
1. On the page with the other dashboard elements, scroll down to the `Funnels by browser` chart, and click on the list with the link.
1. Select the link type: **Outgoing link**.
1. From each list, select the fields for the `Browser` link. Click **Add**.
1. Click **Save**.
1. In the top-left corner, click ![image](../../_assets/console-icons/ellipsis.svg) → **Rename**.
1. Enter `Supermarket.ru — funnel and cohort analysis` as the name. Click **Done**.

## 6. Perform cohort analysis {#cohorts}

### 6.1. {{ ml-platform-short-name }}. Perform cohort analysis {#cohort-analysis}

1. Open the **4. cohorts.ipynb** notebook. Specify the host, the user, and the DB name.
1. Run the cells and evaluate the analysis results.

In {{ CH }}, the `metrica_data.retention_users` table will be created with all the data required to render visualization in {{ datalens-short-name }}.

### 6.2. {{ datalens-short-name }}. Create a dataset and a chart with cohort visualization {#creating-dataset-chart-with-cohort}

Create a new dataset based on the new table and the connection to {{ CH }}:

1. Open the [{{ datalens-short-name }}]({{ link-datalens-main }}/) home page and click **Create dataset**.
1. In the **Connections** section, click **Create dataset** and then click ![image](../../_assets/console-icons/plus.svg) **Add**.
1. From the list, select the [connection](#creation-datalens-connection-to-ch) you created.
1. Drag the new `metrica_data.retention_users` table to the workspace to connect to it.
1. Open the **Fields** tab and create a calculated field named `week_num`, which is equal to `([date]-[min_date])/7`.
   This field will indicate the number of weeks from the user's first visit.
1. Click **Create**.
1. For the `visits`, `purchases`, and `revenue` fields, select the **Sum** value in the **Aggregation** column.
1. Rename the fields to `Visits`, `Purchases`, and `Revenue`, respectively.
1. Save the dataset:
   1. Name the dataset `ch_metrica_data_users_visits`.
   1. Click **Create**.
1. Create a new chart based on the dataset:
   1. Change the chart type to **Pivot table**.
   1. Drag the `week_num` field to the **Columns** section.
   1. Drag the `min_date` field to the **Rows** section.
   1. Drag the `Visits` field to the **Measures** section.

### 6.3. {{ datalens-short-name }}. Configure a chart with cohort visualization {#creating-chart-with-cohort}

Filter out incomplete weeks of June 29, 2020 and September 28, 2020:

1. Drag the `min_date` field to the **Filters** section.
   1. In the window that opens, select the start and end dates of the date range for filtering:
      * Start date: `June 06, 2020`
      * End date: `September 27, 2020`
   1. Click **Apply filter**.
1. Format the numbers in the values of the `week_num` field by removing the decimal places. To do this, in the **Rows** section, in the `week_num` field, click the ![image](../../_assets/console-icons/frame.svg) icon. In the window that opens, set the following configuration:
   1. Set the **Decimal place** measure to `0`.
   1. Set the **Show delimiter** measure to `Hide`.
   1. Click **Apply**.
1. To color the table, add the `Visits` field to the **Colors** section and click the ![gear](../../_assets/console-icons/gear.svg) icon. In the window that opens, configure the colors:
   1. Select **Gradient type**: `3 point`.
   1. Select **Color**: `Orange-Violet-Blue`.
   1. Enable **Set threshold values** and specify the values: `100`, `1000`, and `5000`.
   1. Click **Apply**.
1. Click **Save**.
1. Name the chart `ch_metrica_data_users_visits_cohorts_abs` and click **Save**.

### 6.4. {{ datalens-short-name }}. Create a chart with retention {#creating-chart-with-retention}

Create a chart with retention based on the `ch_metrica_data_users_visits_cohorts_abs` chart. You can open the chart from the dashboard or find it in the [chart list]({{ link-datalens-main }}/widgets).

1. In the top-right corner, click ![save-button](../../_assets/console-icons/chevron-down.svg) → **Save as copy**.
1. Enter `ch_metrica_data_users_visits_cohorts_rel` as the name of the chart and click **Save**.
1. Create a calculated field to calculate the retention rate relative to the first week:
   1. On the left side of the screen, click ![image](../../_assets/console-icons/plus.svg) above the list of dataset fields and select **Field**.
   1. Name the field `Visits from the first week`.
   1. Paste the following formula: `SUM([Visits])/RMAX(SUM([Visits]) among [week_num])`.
   1. Click **Create**.
1. Drag the `Visits from the first week` field to the **Measures** section.
1. Drag the `Visits from the first week` field to the **Colors** section in place of the `Visits` field.
1. Select the format for `Visits from the first week`. To do this, click the ![image](../../_assets/console-icons/frame.svg) icon under **Measures** in the `Visits from the first week` field. In the window that opens, set the following configuration:
   1. Set **Format** to `Percent`.
   1. Click **Apply**.
1. Edit the threshold values for the measure colors. Under **Colors**, click the ![gear](../../_assets/console-icons/gear.svg) icon. In the window that opens, enable **Set threshold values**, then specify the threshold values of `0.01`, `0.025`, and `0.1` and click **Apply**.
1. Click **Save**.

### 6.5. {{ datalens-short-name }}. Add charts to a new dashboard tab {#adding-charts-to-dashboard-tab}

1. In the left-hand panel, click ![dashboards](../../_assets/console-icons/layout-cells-large.svg) **Dashboards** and open the dashboard.
1. Click **Edit** → **Tabs**.
1. Rename the existing tab `Overview + Funnels`.
1. Add a new tab and name it `Cohorts`. Click **Save**.
1. Go to the new `Cohort` tab:
   1. Add the `ch_metrica_data_users_visits_cohorts_abs` chart to the dashboard.
   1. In the **Name** field, specify `Visits by cohort (absolute)`.
1. To add a new tab, click **Add** on the left:
   1. In the new tab, add the `ch_metrica_data_users_visits_cohorts_rel` chart.
   1. Enter `Visits by cohort (relative)` as the name.
   1. Click **Add**.
   1. Click **Save**.

Now you have a chart with two switchable tabs.

### 6.6. {{ datalens-short-name }}. Create charts {#creating-chart}

Create a new chart based on the `ch_metrica_data_users_visits_cohorts_abs` chart. You can open the chart from the dashboard or find it in the [chart list]({{ link-datalens-main }}/widgets).

1. In the top-right corner, click ![image](../../_assets/console-icons/chevron-down.svg) → **Save as copy**.
1. Enter `ch_metrica_data_users_revenue_cohorts_abs` as the chart name and click **Save**.
1. Drag the `Revenue` field to the **Measures** and **Colors** sections on top of the `Visits` field.
1. In the `Revenue` section, click the ![image](../../_assets/console-icons/frame.svg) icon. Change the field formatting:
   1. Select `1` decimal place.
   1. Select the `Millions, M` scale.
   1. Change the color thresholds for the new field to `500000`, `1500000`, and `10000000`.
1. Save the chart.

Create another chart based on the `ch_metrica_data_users_visits_cohorts_rel` chart:

1. In the top-right corner, click ![image](../../_assets/console-icons/chevron-down.svg) → **Save as copy**.
1. Enter `ch_metrica_data_users_revenue_cohorts_rel` as the name of the chart and click **Save**.
1. Change the `Visits from the first week` field:
   1. Rename the field `Revenue from the first week`.
   1. Change the formula to `SUM([Revenue])/RMAX(SUM([Revenue]) among [week_num])`.
   1. Change the color thresholds for the new field to `0.01`, `0.2`, and `0.3`.
1. Save the chart.

### 6.7. {{ datalens-short-name }}. Add charts to the dashboard {#adding-chart-to-dashboard}

Add charts with cohort visualization to the dashboard:

1. Click **Edit**.
1. Click **Add** ![save-button](../../_assets/console-icons/chevron-down.svg) → **Chart**.
1. Select `ch_metrica_data_users_revenue_cohorts_abs` from the chart list.
1. Enter `Revenue by cohort (absolute)` as the name.
1. Use the ![plus](../../_assets/console-icons/plus.svg) **Add** button to create a new tab:
   1. In the new tab, select `ch_metrica_data_users_revenue_cohorts_rel` from the chart list.
   1. Enter `Revenue by cohort (relative)` as the name.
   1. In the top-right corner, click **Save**.
1. Arrange the charts side by side.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, [delete the cluster](../../managed-clickhouse/operations/cluster-delete.md).