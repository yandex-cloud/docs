---
title: "Visualizing data from {{ tracker-short-name }}"
description: "To visualize data from {{ tracker-short-name }}, set up regular export of data to external storage and visualize the necessary metrics and data using {{ datalens-short-name }} tools."
---

# Visualizing data from {{ tracker-full-name }}

Visualizing data from {{ tracker-short-name }} to {{ datalens-full-name }} allows you to build more advanced analytics than when using the {{ tracker-short-name }} tools.

To visualize data from {{ tracker-short-name }} to {{ datalens-short-name }}:
* Set up regular export of data to external storage.
* Visualize the necessary metrics and data using {{ datalens-short-name }}.

To visualize the data, follow these steps:
1. [Prepare your cloud](#before-you-begin).
1. [Create a DB for storing the {{ tracker-short-name }} data](#database-create).
1. [Create an OAuth token for {{ tracker-short-name }} access](#oauth-token).
1. [Create a {{ sf-name }} function for importing the data](#function-import).
1. [Create a connection to {{ datalens-short-name }}](#connection-create).
1. [Create a dashboard in {{ datalens-short-name }}](#dashboard-create).
1. [Create a dataset](#dataset-create).
1. [Create a chart](#chart-create).
1. [Add charts to the dashboard](#dashboard-create).

## Getting started {#before-you-begin}


{% note info %}

We recommend [creating](../../tracker/enable-tracker.md) a separate {{ tracker-short-name }} account to use the service.

{% endnote %}


{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

* Continuously running {{ mch-name }} cluster (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).
* {{ sf-name }} function usage (see [{{ sf-name }} pricing](../../functions/pricing.md)).

If you no longer need the resources you created, [delete them](#clear-out).


## Create a DB for storing the {{ tracker-short-name }} data {#database-create}

1. Go to the [management console]({{ link-console-main }}).
1. In the top-left corner, click ![](../../_assets/datalens/all-services.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
1. Select **Data platform** → **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
1. Click **{{ ui-key.yacloud.clickhouse.button_create-cluster }}**.
1. Specify the cluster parameters:
   * {{ ui-key.yacloud.mdb.forms.section_base }}:
      * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}**: `PRODUCTION`
      * **{{ ui-key.yacloud.mdb.forms.base_field_version }}**: `22.8 LTS`
   * {{ ui-key.yacloud.mdb.forms.new_section_resource }}:
      * **{{ ui-key.yacloud.mdb.forms.resource_presets_field-generation }}**: `{{ ui-key.yacloud.mdb.forms.resource_presets_field_gen_v3 }}`
      * **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}**: `Standard`
      * **{{ ui-key.yacloud.mdb.forms.section_resource }}**: `{{ s3-c2-m8 }}`
   * {{ ui-key.yacloud.mdb.forms.section_disk }}: `30 {{ ui-key.yacloud.common.units.label_gigabyte }}`
   * {{ ui-key.yacloud.mdb.forms.section_host }}:
      * **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**: `{{ ui-key.yacloud.common.enabled }}`
   * {{ ui-key.yacloud.mdb.forms.section_settings }}:
      * **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}**: `{{ ui-key.yacloud.common.disabled }}`
      * **{{ ui-key.yacloud.mdb.forms.database_field_sql-database-management }}**: `{{ ui-key.yacloud.common.disabled }}`
      * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `tracker_data`
      * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`
   * {{ ui-key.yacloud.mdb.forms.section_service-settings }}:
      * **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**: `{{ ui-key.yacloud.common.enabled }}`
      * **{{ ui-key.yacloud.mdb.forms.additional-field-serverless }}**: `{{ ui-key.yacloud.common.enabled }}`
         For a full list of settings, see [{{ mch-name }} settings](../../managed-clickhouse/concepts/settings-list.md).
1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**. Wait for the created cluster status to change to `Alive`.
1. Copy and save the host name for further setup.
   ![tracker-host-name]{{ sf-name }}(../../_assets/dl-tracker-host-name.png =680x372)

## Create an OAuth token for {{ tracker-short-name }} access {#oauth-token}

1. Go to the [Create an app](https://oauth.yandex.ru/client/new) page.
1. Fill out the fields below:
   * **Service name**
   * **Platforms**: `Web services`
   * **Redirect URI**: Click **Enter URL for debugging** or type `https://oauth.yandex.ru/verification_code`.
1. Under **Data access**, specify:
   * `Read from tracker`
   * `Write in tracker`
1. Click **Create app**.
1. In the window that opens, enter the following URL in the browser search bar:

   ```
   https://oauth.yandex.ru/authorize?response_type=token&client_id=ID
   ```

   Where `ID` is the ID of the created app from the **ClientID** field.

1. Log in under the {{ tracker-short-name }} account to be used for data visualization.
1. Save the received [OAuth token](https://cloud.yandex.ru/docs/tracker/concepts/access#section_about_OAauth).

## Create a {{ sf-name }} function for importing the data {#function-import}

1. Go to the [management console]({{ link-console-main }}).
1. In the top-left corner, click ![](../../_assets/datalens/all-services.svg) **{{ ui-key.yacloud.iam.folder.dashboard.label_products }}**.
1. Select **Serverless computing** → **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
1. Specify a name for the function and click **{{ ui-key.yacloud.serverless-functions.create.button_create }}**.
1. In the **{{ ui-key.yacloud.serverless-functions.item.switch_editor }}** window that opens, select `Python / 3.9` as the runtime environment.
1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, click **{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}**.
1. Attach a [test archive](https://github.com/yandex-cloud-examples/yc-tracker-data-import/blob/main/build/tracker-data-import.zip).
1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `tracker_import.handler`.
1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:
   * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `60`
   * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `1024`
   * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:
      * `TRACKER_ORG_ID`: {{ ya-360 }} organization ID

         {% note info "Note" %}

         If you are using a {{ org-full-name }} organization (you can check this on the [administration page](https://tracker.yandex.com/admin/orgs)), replace the `X-Org-ID` header with `X-Cloud-Org-Id` in the `tracker_import.py` function code.

         {% endnote %}

      * `TRACKER_OAUTH_TOKEN`: [OAuth token](#oauth-token) of the {{ tracker-short-name }} account
      * `CH_HOST`: [Host](#database-create) name
      * `CH_DB`: [Database](#database-create) name
      * `CH_USER`: [Username](#database-create)
      * `CH_PASSWORD`: [Password](#database-create)
      * `CH_ISSUES_TABLE`: `tracker_issues`
      * `CH_CHANGELOG_TABLE`: `tracker_changelog`
      * `TRACKER_INITIAL_HISTORY_DEPTH`: `1d`
      * `CH_STATUSES_VIEW`: `v_tracker_statuses`
1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.
1. In the **{{ ui-key.yacloud.serverless-functions.item.switch_testing }}** tab, click **{{ ui-key.yacloud.serverless-functions.item.testing.button_run-test }}**.
1. The test result is a data import log:
   ```json
   {
       "statusCode": 200,
       "headers": {
       "Content-Type": "text/plain"
       },
       "isBase64Encoded": false,
       "body": "OK"
   }
   ```
1. Create a [trigger](../../functions/concepts/trigger/index.md) to regularly export new data to the DB:
   1. Open the **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}** section.
   1. Click ![trigger](../../_assets/functions/triggers.svg) → **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
   1. Set the trigger type to **{{ ui-key.yacloud.serverless-functions.triggers.form.label_timer }}**.
   1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_cron-expression }}** field, select `{{ ui-key.yacloud.common.button_cron-day }}`.
   1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, click **{{ ui-key.yacloud.component.service-account-select.button_create-account-new }}**.
   1. Enter the account name. By default, the account is assigned the `{{ roles-functions-invoker }}` role to work with the trigger.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
   1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

## Create a connection in {{ datalens-short-name }} {#connection-create}

1. Open the **{{ mch-name}}** [cluster](#database-create).
1. On the left side of the window, select ![datalens](../../_assets/datalens/chart.svg) **{{ datalens-short-name }}**.
1. Click **Create connection**.
1. Specify the connection settings:
   * **Connection**: `Select in a folder`.
   * **Cluster**: Cluster specified when [creating a database](#database-create).
   * **Hostname**: Host specified when [creating a database](#database-create).
   * **HTTP interface port**: `8443`.
   * **Username**: Username specified when [creating a database](#database-create).
   * **Password**: Password specified when [creating a database](#database-create).
   * **Cache TTL in seconds**: `Default`.
   * **Raw SQL level**: `Forbid`.
   * **HTTPS**: `{{ ui-key.yacloud.common.enabled }}`.

      ![connection-settings](../../_assets/datalens/connection-settings.png =680x665)

1. Click **Create connection**.

## Create a dataset {#dataset-create}

1. Go to the [connections page]({{ link-datalens-main }}/connections).
1. Select a [connection](#connection-create).
1. In the top-right corner, click **Create dataset**.
1. Drag one or more tables to the workspace:
   * `db1.v_tracker_issues`: Current (most recent) issue cross-section.
   * `db1.v_tracker_changelog`: Issue parameter change history.
   * `Db1.v_tracker_statuses`: Status transition time based on the issue change history.
1. Click **Save**.

## Create a chart {#chart-create}


1. Go to the [{{ datalens-short-name }}]({{ link-datalens-main }}) home page.
1. Click **Create chart**.
1. In the top-left corner, click ![image](../../_assets/datalens/datasets.svg) **Select dataset**.
1. In the **Datasets** drop-down list, select the [dataset](#dataset-create) you created in the previous step.


1. On the top panel, select a [visualization type](../../datalens/visualization-ref/index.md). By default, the **Column chart** type is selected.

## Create a dashboard {#dashboard-create}

1. On the [{{ datalens-full-name }}]({{ link-datalens-main }}) home page, click **Create dashboard**.
1. In the window that opens, enter a name for the dashboard. The dashboard will appear in the list on the navigation page.

For more information about setting up dashboards, see [{{ datalens-full-name }} dashboard](../../datalens/concepts/dashboard.md).

## Add charts to the dashboard {#add-charts}

1. At the top of the [dashboard](#dashboard-create) page, click **Add**→ **Chart**.
1. Fill in the widget parameters. Pay close attention to the following fields:
   * **Name**: Sets the name of the widget. It is displayed at the top of the widget.
   * **Chart**: Sets the widget to add.
   * **Description**: Sets the description of the widget. It is displayed at the bottom of the widget.
   * **Auto height**: Sets the automatic height for **Table** and **Markdown** widgets. If this parameter is disabled, you can set the height of the widget on the page using the mouse.
1. Click **Add**. The widget will be displayed on the dashboard.

{% cut "Sample dashboard based on data from the `v_tracker_issues` table" %}

![Sample dashboard based on data from the v_tracker_issues table](../../_assets/datalens/dashboard-from-table-issues.png)

{% endcut %}

{% cut "Sample dashboard based on data from the `db1.v_tracker_statuses` table" %}

![Sample dashboard based on data from the db1.v_tracker_statuses table](../../_assets/datalens/dashboard-from-table-statuses.png)

{% endcut %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete the {{ CH }} cluster](../../managed-clickhouse/operations/cluster-delete.md).
* [Delete the {{ sf-name }} function](../../functions/operations/function/function-delete.md).