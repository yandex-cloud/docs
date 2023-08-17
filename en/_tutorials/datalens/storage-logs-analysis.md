# Analyzing {{ objstorage-short-name }} logs in {{ datalens-short-name }}

For the {{ objstorage-full-name }} bucket you can enable [logging of actions](../../storage/concepts/server-logs.md). The logs store information about operations with a [bucket](../../storage/concepts/bucket.md) and the [objects](../../storage/concepts/object.md) in it. Analysis of bucket logs can be useful, for example, if you want to understand what caused a sharp increase in load or get the overall picture of traffic distribution.

You can create visualizations for your analysis using [{{ datalens-full-name }}](../../datalens/). You must transfer previously saved logs to the {{ CH }} database, which will be used as a source for {{ datalens-short-name }}.

To analyze the logs and present the results in interactive charts:

1. [Prepare your cloud](#before-you-begin).
1. [Create a bucket for storing logs](#create-bucket).
1. [Enable log export](#logs-export).
1. [Prepare the data source](#prepare-origin).
1. [Create a connection in {{ datalens-short-name }}](#create-connection).
1. [Create a dataset in {{ datalens-short-name }}](#create-dataset).
1. [Create charts in {{ datalens-short-name }}](#create-charts).
1. [Create a dashboard in {{ datalens-short-name }}](#create-dashboard).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost includes:

* Fee for data storage in {{ objstorage-short-name }}, operations with data, and outgoing traffic (see [{{ objstorage-short-name }} pricing](../../storage/pricing.md)).
* Fees for continuously running {{ mch-name }} cluster (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).


## Create a bucket for storing logs {#create-bucket}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}** and **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}** fields, select **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI

  1. If you do not have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).
  1. Create a bucket:

     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://<bucket_name>
     ```

     Result:

     ```
     make_bucket: <bucket_name>
     ```

- {{ TF }}

   {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Add bucket parameters to the configuration file:

     ```
     resource "yandex_storage_bucket" "bucket-logs" {
       bucket = "<bucket_name>"
     }
     ```

      For more information about the `yandex_storage_bucket` resource, see the [{{ TF }} provider documentation]({{ tf-provider-resources-link }}/storage_bucket).

  1. Make sure the settings are correct.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a bucket.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Use the [create](../../storage/s3/api-ref/bucket/create.md) REST API method.

{% endlist %}

## Enable log export {#logs-export}

{% list tabs %}

- AWS CLI

  1. Create a `log-config.json` file with the following content:

     ```json
     {
      "LoggingEnabled": {
         "TargetBucket": "<bucket_name>",
         "TargetPrefix": "s3-logs/"
      }
     }
     ```

  1. Run this command:

     ```
     aws s3api put-bucket-logging \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket <name of the bucket to enable action logging for> \
       --bucket-logging-status file://log-config.json
     ```

- API

  Use the REST API [putBucketLogging](../../storage/s3/api-ref/bucket/putBucketLogging.md) method.

{% endlist %}

## Prepare the data source {#prepare-origin}

### Create a {{ CH }} cluster {#create-ch-cluster}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. In the window that opens, click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. Specify the settings for a {{ CH }} cluster:

     1. Under **{{ ui-key.yacloud.mdb.forms.section_base }}**, specify `s3-logs` in the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field.

     1. Under **{{ ui-key.yacloud.mdb.forms.new_section_resource }}**, select **burstable** in the **{{ ui-key.yacloud.mdb.forms.resource_presets_field-type }}** field.

     1. Under **{{ ui-key.yacloud.mdb.forms.section_host }}**, click ![image](../../_assets/edit.svg) and enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

     1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

        * In the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** field, select **Disabled**.
        * In the **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** field, specify `user`.
        * In the **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** field, set a password.
        * In the **{{ ui-key.yacloud.mdb.forms.database_field_name }}** field, specify `s3_data`.

        Remember the database name.

     1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**, enable the following options:

        * **{{ ui-key.yacloud.mdb.forms.additional-field-datalens }}**.
        * **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**.

  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster:

  1. Check whether the folder has any subnets for the cluster hosts:

     ```bash
     yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the required subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

  1. Specify the cluster parameters in the create command:

     ```bash
     {{ yc-mdb-ch }} cluster create \
        --name s3-logs \
        --environment production \
        --network-name <network name> \
        --host type=clickhouse,zone-id=<availability zone>,subnet-id=<subnet ID> \
        --clickhouse-resource-preset b2.medium \
        --clickhouse-disk-type {{ disk-type-example }} \
        --clickhouse-disk-size 10 \
        --user name=user,password=<user password> \
        --database name=s3_data \
        --datalens-access=true \
        --websql-access=true
     ```

- {{ TF }}

  1. Add a description of the cluster and cluster hosts to the configuration file:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "s3-logs" {
        name                = "s3-logs"
        environment         = "PRODUCTION"
        network_id          = yandex_vpc_network.<name of network in {{ TF }}>.id

        clickhouse {
          resources {
            resource_preset_id = "b2.medium"
            disk_type_id       = "{{ disk-type-example }}"
            disk_size          = 10
          }
        }

        database {
          name = "s3_data"
        }

        user {
          name     = "user"
          password = "<password>"
          permission {
            database_name = "s3_data"
          }
        }

        host {
          type      = "CLICKHOUSE"
          zone      = "<availability zone>"
          subnet_id = yandex_vpc_subnet.<name of subnet in {{ TF }}>.id
        }

        access {
          datalens  = true
          web_sql   = true
        }
     }
     ```

     For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-mch }}).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a cluster:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Use the [create](../../managed-clickhouse/api-ref/Cluster/create.md) REST API method.

{% endlist %}

After creating the cluster, you'll be automatically redirected to the **{{ ui-key.yacloud.clickhouse.switch_list }}** page.

Wait for the cluster status to change to `Alive`.

### Change user settings {#user-settings}

{% list tabs %}

- Management console

  1. Select the cluster `s3-logs`.
  1. Click the **{{ ui-key.yacloud.clickhouse.cluster.switch_users }}** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.button_advanced-settings }}** → **Settings**.
  1. In the **Date time input format** field, select `best_effort`.
  1. Click **{{ ui-key.yacloud.mdb.cluster.users.popup-button_save }}**.

{% endlist %}

### Create a static key {#create-static-key}

To create a table with access to {{ objstorage-name }}, you need a static key. [Create it](../../iam/operations/sa/create-access-key.md) and save the ID and secret part of the key.

### Create a table in the database {#create-table}

{% list tabs %}

- Management console

  1. Select the cluster `s3-logs`.
  1. Click the **{{ ui-key.yacloud.mysql.cluster.switch_explore }}** tab.
  1. In the **{{ ui-key.yacloud.clickhouse.cluster.explore.label_password }}** field, enter the password.
  1. Click **{{ ui-key.yacloud.clickhouse.cluster.explore.button_submit-creds }}**.
  1. In the window on the right, write an SQL query:

     ```sql
     CREATE TABLE s3_data.s3logs
     (
        bucket String,              -- Bucket name.
        bytes_received Int64,       -- Size of request in bytes.
        bytes_send Int64,           -- Size of response in bytes.
        handler String,             -- Request method in REST.<HTTP method>.<subject> format.
        http_referer String,        -- URL of request source.
        ip String,                  -- User's IP address.
        method String,              -- HTTP request method.
        object_key String,          -- Object's key in URL encoded format.
        protocol String,            -- Version of data transfer protocol.
        range String,               -- HTTP header that defines range of bytes to load from object.
        requester String,           -- User ID.
        request_args String,        -- Argument of URL request.
        request_id String,          -- Request ID.
        request_path String,        -- Full path of request.
        request_time Int64,         -- Request processing time, in milliseconds.
        scheme String,              -- Type of data transfer protocol.
                                    -- Possible values:
                                    -- * http: An application layer protocol.
                                    -- * https: An application layer protocol with encryption support.
        ssl_protocol String,        -- Security protocol.
        status Int64,               -- HTTP response code.
        storage_class String,       -- Object's storage class.
        timestamp DateTime,         -- Date and time of the operation with the bucket, in the YYYY-MM-DDTHH:MM:MMZ format.
        user_agent String,          -- Client application (User Agent) that executed request.
        version_id String,          -- Version of object.
        vhost String                -- Virtual host of request.
                                    -- Possible values:
                                    -- * {{ s3-storage-host }}.
                                    -- * <bucket name>.{{ s3-storage-host }}.
                                    -- * {{ s3-web-host }}.
                                    -- * <bucket name>.{{ s3-web-host }}.
     )
     ENGINE = S3(
           'https://{{ s3-storage-host }}/<bucket_name>/s3-logs/*',
           '<key_ID>',
           '<secret key>',
           'JSONEachRow'
        )
     SETTINGS date_time_input_format='best_effort';
     ```

  1. Click **{{ ui-key.yacloud.clickhouse.cluster.explore.button_execute }}**.

{% endlist %}

## Create a connection in {{ datalens-short-name }} {#create-connection}

{% list tabs %}

- Management console

  1. Select the cluster `s3-logs`.
  1. Click the **{{ ui-key.yacloud.clickhouse.cluster.switch_datalens }}** tab.
  1. In the window that opens, click **{{ ui-key.datalens.connections.form.button_add-connection }}**.
  1. Fill in the connection settings:

     1. Add a connection name: `s3-logs-con`.
     1. In the **{{ ui-key.datalens.connections.form.field_cluster }}** field, select `s3-logs`.
     1. In the **{{ ui-key.datalens.connections.form.field_host-name }}** field, select the {{ CH }} host from the drop-down list.
     1. Enter the DB user's name and password.

   1. Click **{{ ui-key.datalens.connections.form.button_verify }}**.
   1. After checking the connection, click **{{ ui-key.datalens.connections.form.button_create-connection }}**.
   1. In the window that opens, enter a name for the connection and click **{{ ui-key.datalens.connections.form.button_create }}**.

{% endlist %}

## Create a dataset in {{ datalens-short-name }} {#create-dataset}

1. Click **{{ ui-key.datalens.connections.form.button_create-dataset }}**.
1. In the created dataset, move the `s3_data.s3logs` table to the workspace.
1. Click the **{{ ui-key.datalens.dataset.dataset-editor.modify.value_dataset }}** tab.
1. Click ![image](../../_assets/plus-sign.svg) **{{ ui-key.datalens.dataset.dataset-editor.modify.button_add-field }}**.
1. Create a calculated field with the file type:

   * Field name: `object_type`.
   * Formula: `SPLIT([object_key], '.', -1)`.

1. Click **{{ ui-key.datalens.component.dl-field-editor.view.button_create }}**.
1. In the top-right corner, click **{{ ui-key.datalens.dataset.dataset-editor.modify.button_save }}**.
1. Enter the dataset name `s3-dataset` and click **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create }}**.
1. When the dataset is saved, click **{{ ui-key.datalens.dataset.dataset-editor.modify.button_create-widget }}** in the top-right corner.

## Create charts in {{ datalens-short-name }} {#create-charts}

### Create the first chart {#create-pie-chart}

To visualize the number of requests to a bucket using different methods, create a pie chart:

1. Select the **{{ ui-key.datalens.wizard.label_visualization-pie }}** visualization type.
1. Drag the `method` field from the **{{ ui-key.datalens.wizard.section_dimensions }}** section to the **{{ ui-key.datalens.wizard.section_color }}** section.
1. Drag the `request_id` field from the **{{ ui-key.datalens.wizard.section_dimensions }}** section to the **{{ ui-key.datalens.wizard.section_measures }}** section.
1. In the top-right corner, click **{{ ui-key.datalens.wizard.button_save }}**.
1. In the window that opens, enter the name of the chart: `S3 - Method pie` and click **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.

### Create the second chart {#create-column-chart}

To visualize the ratio of the number of requests by object type, create a bar chart:

1. Copy the chart from the previous step:

   1. In the top-right corner, click the down arrow next to the **{{ ui-key.datalens.wizard.button_save }}** button.
   1. Click **{{ ui-key.datalens.wizard.button_save-as }}**.
   1. In the window that opens, enter the name of the new chart: `S3 - Object type bars` and click **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.

1. Select the **{{ ui-key.datalens.wizard.label_visualization-column }}** visualization type. The `method` and `request_id` fields will automatically appear in the **{{ ui-key.datalens.wizard.section_x }}** and **{{ ui-key.datalens.wizard.section_y }}** sections, respectively.
1. Delete the `method` field from the **{{ ui-key.datalens.wizard.section_x }}** section and drag the `object_type` field there.
1. In the top-right corner, click **{{ ui-key.datalens.wizard.button_save }}**.

### Create the third chart {#create-column-chart-2}

To visualize the distribution of outgoing traffic by day, create a bar chart:

1. Copy the chart from the previous step:

   1. In the top-right corner, click the down arrow next to the **{{ ui-key.datalens.wizard.button_save }}** button.
   1. Click **{{ ui-key.datalens.wizard.button_save-as }}**.
   1. In the window that opens, enter the name of the new chart: `S3 - Traffic generated by days` and click **{{ ui-key.datalens.component.chartkit-alerts.view.button_save }}**.

1. Drag the `object_type` field from the **{{ ui-key.datalens.wizard.section_x }}** section to the **{{ ui-key.datalens.wizard.section_filters }}** section.
1. In the window that opens, select the types of objects that you want to display in the chart and click **{{ ui-key.datalens.wizard.button_apply-filter }}**.
1. Drag the `timestamp` field from the **{{ ui-key.datalens.wizard.section_dimensions }}** section to the **{{ ui-key.datalens.wizard.section_x }}** section.
1. Delete the `request_id` field from the **{{ ui-key.datalens.wizard.section_y }}** section and drag the `bytes_send` the field there.
1. In the top-right corner, click **{{ ui-key.datalens.wizard.button_save }}**.

## Create a dashboard in {{ datalens-short-name }} and add charts there {#create-dashboard}

1. Go to the {{ datalens-short-name }} [homepage]({{ link-datalens-main }}).
1. Click **{{ ui-key.datalens.main.landing.view.button_create-dashboards }}**.
1. Enter `S3 Logs Analysis` as the dashboard name and click **{{ ui-key.datalens.component.navigation.view.button_create }}**.
1. In the upper-right corner, click **{{ ui-key.datalens.dash.action-panel.view.button_add }}** and select **{{ ui-key.datalens.dash.action-panel.view.value_widget }}**.
1. In the **{{ ui-key.datalens.dash.widget-dialog.edit.field_widget }}** chart, click **{{ ui-key.datalens.dash.navigation-input.edit.button_choose }}** and choose the `S3 - Method pie` chart from the list.
1. Click **{{ ui-key.datalens.dash.widget-dialog.edit.button_add }}**. The chart will be displayed on the dashboard.
1. Repeat the previous steps for the `S3 - Object type bars` and `S3 - Traffic generated by days` charts.

## How to delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete the bucket](../../storage/operations/buckets/delete.md).
* [Delete the cluster](../../managed-clickhouse/operations/cluster-delete.md) named `s3-logs`.
