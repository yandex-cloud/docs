# Streaming {{ postbox-full-name }} events to {{ yds-full-name }} and analyzing them using {{ datalens-full-name }}


In this tutorial, you will set up streaming of [{{ postbox-full-name }}](../../postbox/) events to [{{ yds-full-name }}](../../data-streams/) and their visualization in [{{ datalens-full-name }}](../../datalens/) for further analysis. Sending emails generates events.

You can implement all the solutions from this tutorial in the {{ yandex-cloud }} [management console]({{ link-console-main }}); no coding skills are required. To process and store data, you will use [{{ sf-full-name }}](../../functions/) and [{{ ydb-full-name }}](../../ydb/).

To set up event streaming and visualization:

1. [Get your cloud ready](#before-begin).
1. [Set up a {{ ydb-name }} database](#ydb).
1. [Create a data stream in {{ yds-name }}](#stream).
1. [Set up {{ postbox-name }} and {{ dns-name }} resources](#postbox).
1. [Set up {{ sf-name }} resources](#serverless-functions).
1. [Send emails](#send-letters).
1. [Configure visualization in {{ datalens-name }}](#datalens).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support costs include:

* Fee for {{ ydb-short-name }} operations and data storage (see [{{ ydb-full-name }} pricing](../../ydb/pricing/serverless.md)).
* {{ yds-short-name }} data storage fee (see [{{ yds-full-name }} pricing](../../data-streams/pricing.md)).
* Fee for function invocation count, computing resources allocated to run the function, and outbound traffic (see [{{ sf-name }} pricing](../../functions/pricing.md)).
* Fee for using {{ postbox-full-name }} (see [{{ postbox-name }} pricing](../../postbox/pricing.md)).
* Fee for the {{ datalens-short-name }} plan (see [{{ datalens-full-name }} pricing](../../datalens/pricing.md)).


### Create a service account {#service-account}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the relevant folder.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Name the [service account](../../iam/concepts/users/service-accounts.md): `yds-functions`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select the `yds.editor` and `{{ roles-functions-invoker }}` [roles](../../iam/concepts/access-control/roles.md).
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}


## Set up a {{ ydb-name }} database {#ydb}

You can use any DBMS suitable for analytical tasks as event storage. In this tutorial, we use a {{ ydb-name }} [serverless database](../../ydb/concepts/resources.md#serverless). For other DBMS, the SQL query for creating a table and code for loading events into that table may be different.


### Create a database {#create-db}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the relevant folder.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Click **{{ ui-key.yacloud.ydb.databases.button_create }}**.
  1. Specify the DB **{{ ui-key.yacloud.ydb.forms.label_field_name }}**: `postbox-events-ydb`.
  1. Under **{{ ui-key.yacloud.ydb.forms.label_field_database-type }}**, select `{{ ui-key.yacloud.ydb.forms.label_serverless-type }}`.
  1. Click **{{ ui-key.yacloud.ydb.forms.button_create-database }}**.

  Wait for the database to start. While being created, your database will have the `Provisioning` status. Once it is ready for use, its status will change to `Running`.

{% endlist %}


### Create a table {#create-table}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the **{{ ui-key.yacloud.ydb.databases.label_title }}** page, select the `postbox-events-ydb` DB.
  1. To open the DB root directory, navigate to the ![image](../../_assets/console-icons/folder.svg) **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
  1. To create a DB query, click **{{ ui-key.yacloud.ydb.browse.button_sql-query }}** in the top-right corner. The **{{ ui-key.yacloud.ydb.sql.label_query }}** page will open.
  1. In the **{{ ui-key.yacloud.ydb.sql.label_query }}** field, enter:

      ```sql
      CREATE TABLE postbox_events
      (
          saved_datetime Datetime NOT NULL,
          eventid String NOT NULL,
          eventtype String,
          mail_timestamp Timestamp,
          mail_messageid String,
          mail_ch_from String,
          mail_ch_to String, 
          mail_ch_messageid String,
          mail_ch_subject String,
          delivery_timestamp Timestamp,
          delivery_time_ms Uint64,
          delivery_recipients String,
          bounce_bounceType String,
          bounce_bounceSubType String,
          bounce_bouncedRecipients String,
          bounce_timestamp Timestamp,
          -- message Json,
          PRIMARY KEY (saved_datetime, eventid)
      )
      ```

  1. Click ![image](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yacloud.ydb.sql.button_run }}**.

      After you run the query, the `postbox_events` table will appear in your database.

{% endlist %}


## Create a data stream in {{ yds-name }} {#stream}

Create a [data stream](../../data-streams/concepts/glossary.md#stream-concepts) to log events.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
  1. Click **{{ ui-key.yacloud.data-streams.button_create-stream }}**.
  1. Specify the `postbox-events-ydb` database.
  1. Name the data stream: `postbox-events-stream`.
  1. Select the `{{ ui-key.yacloud.data-streams.label_request-units }}` pricing plan.
  1. Click **{{ ui-key.yacloud.common.create }}**.

  Wait for the stream to start. Once the stream is ready for use, its status will change from `Creating` to `Active`.

{% endlist %}


## Set up {{ postbox-name }} and {{ dns-name }} resources {#postbox}

Create a sending [address](../../postbox/concepts/glossary.md#adress), [verify](../../postbox/operations/check-domain.md) your domain ownership, and [configure](../../postbox/concepts/glossary.md#subscription) event logging to {{ yds-name }}.


### Create an address {#address}

1. On your computer, generate the `privatekey.pem` file for DKIM signing:

    {% list tabs group=instructions %}

    - Linux {#linux}

      ```bash
      openssl genrsa -out privatekey.pem 2048
      ```

    {% endlist %}

1. Create an address:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
      1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.
      1. In the **{{ ui-key.yacloud.postbox.label_address }}** field, specify the domain you will use to send emails. You can use a domain of any level.
      1. In the **{{ ui-key.yacloud.postbox.label_selector }}** field, specify a selector, e.g., `postbox`. Make sure to only use this selector in that single resource record you create at [domain ownership verification](#domain).
      1. In the **{{ ui-key.yacloud.postbox.label_private-key }}** field, copy the contents of the `privatekey.pem` file.
      1. Click **{{ ui-key.yacloud.postbox.button_create-identity }}**.

    {% endlist %}


### Verify your domain ownership {#domain}

{% include [check-domain](../../_includes/postbox/check-domain.md) %}


### Create a configuration {#config}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_postbox }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/list-ul.svg) **{{ ui-key.yacloud.postbox.label_configuration-sets }}**.
  1. Click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.
  1. Name the configuration: `postbox-events-config`.
  1. Under **{{ ui-key.yacloud.postbox.label_event-destinations }}**, click **{{ ui-key.yacloud.common.add }}**:

      1. Enter the [subscription](../../postbox/concepts/glossary.md#subscription) name: `postbox-events-subscribe`.
      1. Select the `postbox-events-stream` [data stream](../../data-streams/concepts/glossary.md#stream-concepts).
      1. Toggle the **{{ ui-key.yacloud.common.enabled }}** option on to activate the subscription.

  1. Click **{{ ui-key.yacloud.postbox.button_create-configuration-set }}**.

{% endlist %}


## Set up {{ sf-name }} resources {#serverless-functions}

Create a [function](../../functions/concepts/function.md) to send data from the stream to the DB, and a [trigger](../../functions/concepts/trigger/index.md) to invoke the function when events are logged in the data stream.


### Get the function code {#code}

{% list tabs %}

- Archive

  [Download](https://github.com/yandex-cloud-examples/yc-postbox-events/raw/main/build/postbox-events.zip) the `postbox-events.zip` archive to your computer. The archive contains the `index.py` and `requirements.txt` files with the function code.

- Repository

  On your computer, do the following:

  1. Clone the [repository](https://github.com/yandex-cloud-examples/yc-postbox-events/tree/main) with the function code:

      ```bash
      git clone https://github.com/yandex-cloud-examples/yc-postbox-events/blob/main/build/postbox-events.git
      ```

      Navigate to the repository directory. Make sure it contains the `index.py` and `requirements.txt` files with the function code.

  1. Create an archive named `postbox-events.zip` and add `index.py` and `requirements.txt` to it.

{% endlist %}


### Get the DB connection details {#db-details}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [management console]({{ link-console-main }}).
  1. Select the folder with your DB and go to **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
  1. Select the DB for which you need to get the endpoint and path.

      * The DB endpoint is specified under **{{ ui-key.yacloud.ydb.overview.section_connection }}** in the first part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (preceding `/?database=`):

          >For example, the endpoint of a serverless DB is `{{ ydb.ep-serverless }}`.

      * The DB path is specified under **{{ ui-key.yacloud.ydb.overview.section_connection }}** in the second part of the **{{ ui-key.yacloud.ydb.overview.label_endpoint }}** field value (following `/?database=`).

          >Here is an example of a DB path: `{{ ydb.path-serverless }}`.

{% endlist %}


### Create a function {#function}

To create a function, you will need the function code and DB connection details.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. Create a function:

      1. Click **{{ ui-key.yacloud.serverless-functions.list.button_create }}**.
      1. In the **{{ ui-key.yacloud.common.name }}** field, enter a name for the function, e.g., `postbox-events-function`.
      1. Click **{{ ui-key.yacloud.common.create }}**.

  1. Create a function version:

      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.label_title }}** window that opens, select `Python 3.12`.
      1. Disable **{{ ui-key.yacloud.serverless-functions.item.editor.label_with-template }}**.
      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_action-continue }}**.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_method }}** field, select `{{ ui-key.yacloud.serverless-functions.item.editor.value_method-zip-file }}`.
      1. Click **Attach file** and select `postbox-events.zip`.
      1. In the **{{ ui-key.yacloud.serverless-functions.item.editor.field_entry }}** field, specify `index.handler`.

      1. Under **{{ ui-key.yacloud.serverless-functions.item.editor.label_title-params }}**, specify:

          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_timeout }}**: `10`
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_resources-memory }}**: `128 {{ ui-key.yacloud.common.units.label_megabyte }}`
          * **{{ ui-key.yacloud.forms.label_service-account-select }}**: `yds-functions`
          * **{{ ui-key.yacloud.serverless-functions.item.editor.field_environment-variables }}**:

              Key | Description | Value (example)
              :--- | :--- | :---
              `YDB_DATABASE` | DB path     | `/ru-central1/b1go123e9vjq********/etnu15kr22********`
              `YDB_ENDPOINT` | DB endpoint | `grpcs://ydb.serverless.yandexcloud.net:2135`
              `YDB_TABLE`    | Table name | `postbox_events`

      1. Click **{{ ui-key.yacloud.serverless-functions.item.editor.button_deploy-version }}**.

{% endlist %}


### Create a trigger {#trigger}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_serverless-functions }}**.
  1. In the left-hand panel, select ![image](../../_assets/console-icons/gear-play.svg) **{{ ui-key.yacloud.serverless-functions.switch_list-triggers }}**.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.list.button_create }}**.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_name }}** field, enter a name for the trigger, e.g., `postbox-events-trigger`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_type }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_data-streams }}`.
  1. In the **{{ ui-key.yacloud.serverless-functions.triggers.form.field_invoke }}** field, select `{{ ui-key.yacloud.serverless-functions.triggers.form.label_function }}`.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_data-streams }}**, select the data stream named `postbox-events-stream` and the `yds-functions` service account.
  1. Under **{{ ui-key.yacloud.serverless-functions.triggers.form.section_function }}**, select the function named `postbox-events-function` and the `yds-functions` service account.
  1. Click **{{ ui-key.yacloud.serverless-functions.triggers.form.button_create-trigger }}**.

{% endlist %}


## Send emails {#send-letters}

1. [Create](../../postbox/quickstart.md#service-account-and-keys) a service account named `postbox-user` with the `postbox.sender` role and static access keys.
1. [Send](../../postbox/quickstart.md#send-test-letter) several test emails using the address you created [earlier](#address).
1. Make sure the emails were sent: check the the destination inbox.
1. Make sure data reaches the services:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. Check the data stream:

          1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-streams }}**.
          1. Select the data stream named `postbox-events-stream`.
          1. Navigate to the ![image](../../_assets/console-icons/text-align-justify.svg) **{{ ui-key.yacloud.data-streams.label_data-introspection }}** tab.

              The charts should show data on the emails you sent.

      1. Check the DB:

          1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_ydb }}**.
          1. Select the `postbox-events-ydb` DB.
          1. Go to the ![image](../../_assets/console-icons/folder.svg) **{{ ui-key.yacloud.ydb.database.switch_browse }}** tab.
          1. Select the `postbox_events` table.

              The table should show new records. Some columns may have the `NULL` value: this depends on the [type of notification](../../postbox/concepts/notification.md#types) received from {{ postbox-name }}.

    {% endlist %}


## Configure visualization in {{ datalens-name }} {#datalens}

To monitor the emails you send, set up a [connection](../../datalens/concepts/connection.md), create a [dataset](../../datalens/dataset/index.md), [charts](../../datalens/concepts/chart/index.md), and a [dashboard](../../datalens/concepts/dashboard.md).


### Create a connection {#connection}

{% list tabs group=instructions %}

- {{ datalens-short-name }} UI {#console}

  1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
  1. Click **Create connection**.
  1. Select the **{{ ydb-short-name }}** connector.
  1. Configure the connection as follows:

      * **Cloud and folder**: Select the folder you are using to complete this tutorial.
      * **Service account**: `yds-functions`.
      * **Database**: `postbox-events-ydb`.
      * **Cache TTL in seconds**: `Default`.
      * **SQL query access level**: `Allow subqueries from datasets and queries from charts`.

  1. Click **Create connection**.
  1. Enter a connection name, e.g., `postbox-events-connection`, and click **Create**.

{% endlist %}


### Create a dataset {#dataset}

{% list tabs group=instructions %}

- {{ datalens-short-name }} UI {#console}

  1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
  1. Click **Create dataset**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/plus.svg) **Add**.
  1. Select `postbox-events-connection`.
  1. In the left-hand menu, select the `postbox-events` table and drag it to the right.
  1. Click **Save**.
  1. In the window that opens, specify `postbox-events-dataset` and click **Create**.

{% endlist %}


### Create charts {#charts}

In this tutorial, we will create the [Events by day](#events-by-days) and [Event list](#events-list) charts as an example. You can create other charts in the same way.


#### Events by day {#events-by-days}

{% list tabs group=instructions %}

- {{ datalens-short-name }} UI {#console}

  1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
  1. Click **Create chart**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/archive.svg) **Select dataset** and select `postbox-events-dataset`.
  1. Select **Column chart** as the [chart type](../../datalens/visualization-ref/line-chart.md).
  1. Drag the dimensions as follows:

      * `delivery_timestamp` to the **X** section: Dates will be plotted along the X axis.
      * `eventid` to the **Y** section: Number of events will be plotted on the Y axis.
      * `eventtype` to the **Colors** section: This enables using a different color for each event type.

  1. Click **Save**.
  1. In the window that opens, specify the chart name, `Events by day`, and click **Save**.

{% endlist %}


#### Event list {#events-list}

{% list tabs group=instructions %}

- {{ datalens-short-name }} UI {#console}

  1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
  1. Click **Create chart**.
  1. In the left-hand panel, click ![image](../../_assets/console-icons/archive.svg) **Select dataset** and select `postbox-events-dataset`.
  1. Select **Table** as the [chart type](../../datalens/visualization-ref/line-chart.md).
  1. Drag the following dimensions to the **Columns** section:

      * `saved_datetime`: Date and time of saving the event.
      * `eventid`: Event type.
      * `mail_ch_to`: Recipient's email address.
      * `delivery_timestamp`: Email delivery date and time.
      * `delivery_time_ms`: Delivery time in milliseconds.
      * `mail_ch_subject`: Email subject.
      * `bounce_bounceType`: Delivery error type.
      * `bounce_bounceSubType`: Non-delivery report.

  1. Drag the `delivery_timestamp` dimension to the **Sorting** section to sort the table by delivery time.
  1. Click **Save**.
  1. In the window that opens, specify the chart name, `Event list`, and click **Save**.

{% endlist %}


### Create a dashboard {#dashboard}

{% list tabs group=instructions %}

- {{ datalens-short-name }} UI {#console}

  1. Go to the {{ datalens-short-name }} [home page]({{ link-datalens-main }}).
  1. Click **Create dashboard**.
  1. Add `Events by day`, `Event list`, and other charts you created earlier to your dashboard:

      1. In the bottom panel, click **Chart**.
      1. In the **Chart** field of the window that opens, click **Select** and select `Events by day`.
      1. Click **Add**.
      1. Repeat these steps to add other charts.

  1. Resize and move your charts as needed.
  1. Click **Save**.
  1. In the window that opens, name the dashboard: `postbox-events-dashboard`.
  1. Click **Create**.

{% endlist %}

After completing this tutorial, you can use charts and tables to analyze events.


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

1. [Delete](../../functions/operations/trigger/trigger-delete.md) the trigger invoking the function in {{ sf-name }}.
1. [Delete](../../functions/operations/function/function-delete.md) the function in {{ sf-name }}.
1. [Delete](../../ydb/operations/manage-databases.md#delete-db) the {{ ydb-name }} database.
1. [Delete](../../data-streams/operations/manage-streams.md#delete-data-stream) the stream in {{ yds-name }}.
1. [Delete](../../postbox/operations/index.md) the {{ postbox-name }} address and configuration.