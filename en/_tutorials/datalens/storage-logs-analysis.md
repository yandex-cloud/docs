# Analyzing {{ objstorage-short-name }} logs in {{ datalens-short-name }}

For the {{ objstorage-full-name }} bucket you can enable [logging of actions](../../storage/concepts/server-logs.md). The logs store information on operations with a [bucket](../../storage/concepts/bucket.md) and [objects](../../storage/concepts/object.md) in it. Analysis of bucket logs can be useful, for example, if you want to understand what caused a sharp increase in load or get the overall picture of traffic distribution.

You can create visualizations for your analysis using [{{ datalens-full-name }}](../../datalens/) for business analytics. You must transfer previously saved logs to the {{ CH }} database, which will be used as a source for {{ datalens-short-name }}.

To analyze the logs and present the results in interactive charts:

1. [Prepare your cloud](#before-you-begin).
1. [Create a bucket for storing logs](#create-bucket).
1. [Enable log export](#logs-export).
1. [Prepare the data source](#prepare-origin).
1. [Create a connection in {{ datalens-short-name }}](#create-connection).
1. [Create a dataset in {{ datalens-short-name }}](#create-dataset).
1. [Create charts in {{ datalens-short-name }}](#create-charts).
1. [Create a dashboard in {{ datalens-short-name }}](#create-dashboard).

If you no longer need the created resources, [delete them](#clear-out).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost includes:

* A fee for data storage in {{ objstorage-short-name }}, operations with data, and outgoing traffic (see [{{ objstorage-short-name }} pricing](../../storage/pricing.md)).
* A fee for the continuously running {{ mch-name }} cluster (see [{{ mch-name }} pricing](../../managed-clickhouse/pricing.md)).


## Create a bucket for storing logs {#create-bucket}

To create a bucket:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
  1. In the list of services, select **{{ objstorage-name }}**.
  1. Click **Create bucket**.
  1. Specify **Name** of the bucket: `bucket-logs`.
  1. In the **Object read access** and **Object listing access** fields, select **Public**.
  1. Click **Create bucket**.

- AWS CLI

  1. If you don't have the AWS CLI yet, [install and configure it](../../storage/tools/aws-cli.md).
  1. Create a bucket `bucket-logs`:

     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3 mb s3://bucket-logs
     ```

     Result:

     ```
     make_bucket: bucket-logs
     ```

  1. Enable public access to reading objects and their list:

     ```bash
     aws --endpoint-url https://{{ s3-storage-host }} \
       s3api put-bucket-acl \
       --bucket bucket-logs \
       --acl public-read
     ```

- {{ TF }}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Add the parameters of the `bucket-logs` bucket to the configuration file:

     ```
     resource "yandex_storage_bucket" "bucket-logs" {
       bucket = "bucket-logs"
       acl    = "public-read"
     }
     ```

     For more information about the `yandex_storage_bucket` resource, see the {{ TF }} provider [documentation]({{ tf-provider-link }}/storage_bucket).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a bucket.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Use the [create](../../storage/s3/api-ref/bucket/create.md) REST API method.

{% endlist %}

## Enable log export {#logs-export}

To enable the export of logs to the `bucket-logs` bucket:

{% list tabs %}

- AWS CLI

  1. Create a `log-config.json` file with the following content:

     ```json
     {
      "LoggingEnabled": {
         "TargetBucket": "bucket-logs",
         "TargetPrefix": "s3-logs/"
      }
     }
     ```

  1. Run the command:

     ```
     aws s3api put-bucket-logging \
       --endpoint-url https://{{ s3-storage-host }} \
       --bucket <target bucket name> \
       --bucket-logging-status file://log-config.json
     ```

- API

  Use the [putBucketLogging](../../storage/s3/api-ref/bucket/putBucketLogging.md) REST API method.

{% endlist %}

## Prepare the data source {#prepare-origin}

### Create a {{ CH }} cluster {#create-ch-cluster}

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a cluster.
  1. In the list of services, select **{{ mch-name }}**.
  1. In the window that opens, click **Create cluster**.
  1. Specify the settings for a {{ CH }} cluster:

     1. Under **Basic parameters**:

        * Enter the cluster name `s3-logs`.
        * Select the version 21.3 LTS.

     1. Under **Host class**, select the type of virtual machine **burstable** and the **b2.nano** host type.
     1. Under **Size of storage**, keep the value of 10 GB.
     1. Under **Database**, enter the DB name `s3_data`, the username `user` and the password. Remember the database name.
     1. Under **Hosts**, click ![pencil](../../_assets/pencil.svg). Enable **Public access** and click **Save**.
     1. Under **Advanced settings**, enable the following options:

        * {{ datalens-short-name }} access.
        * Access from the management console.

  1. After configuring all the settings, click **Create cluster**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster:

  1. Check whether the folder has any subnets for the cluster hosts:

     ```bash
     yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

  1. Specify the cluster parameters in the create command:

     ```bash
     {{ yc-mdb-ch }} cluster create \
        --name s3-logs \
        --environment production \
        --network-name <network name> \
        --host type=clickhouse,zone-id=<availability zone>,subnet-id=<subnet ID> \
        --clickhouse-resource-preset b2.nano \
        --clickhouse-disk-type network-hdd \
        --clickhouse-disk-size 10 \
        --user name=user,password=<user password> \
        --database name=s3_data \
        --datalens-access=true \
        --websql-access=true \
        --version 21.3
     ```

- {{ TF }}

  1. Add a description of the cluster and cluster hosts to the configuration file:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "s3-logs" {
       name                = "s3-logs"
       environment         = "PRODUCTION"
       version             = "21.3"
       network_id          = yandex_vpc_network.<name of network in {{ TF }}>.id
     
       clickhouse {
         resources {
           resource_preset_id = "b2.nano"
           disk_type_id       = "network-hdd"
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

     For more information about resources that you can create using {{ TF }}, see the [provider's documentation]({{ tf-provider-link }}/mdb_clickhouse_cluster).

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Create a cluster:

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Use the [create](../../managed-clickhouse/api-ref/Cluster/create.md) REST API method.

{% endlist %}

### Change user settings {#user-settings}

{% list tabs %}

- Management console

  1. On the page of the created {{ CH }} cluster, in the menu on the left, go to the **Users** tab.
  1. Click ![image](../../_assets/horizontal-ellipsis.svg) and select **Configure**.
  1. Go to **Additional settings** → **Settings**.
  1. In the **Date time input format** field, select the `best_effort` value.
  1. Click **Save**.

{% endlist %}

### Create a table in the database {#create-table}

{% list tabs %}

- Management console

  1. On the page of the created {{ CH }} cluster, in the menu on the left, go to the **SQL** tab.
  1. Enter the DB user's name and password.
  1. Click **Connect**.
  1. In the window on the right, write an SQL query:

     ```sql
     CREATE TABLE s3_data.s3logs
     (
        bucket String,              -- Bucket name.
        bytes_received Int64,       -- Size of request in bytes.
        bytes_send Int64,           -- Size of response in bytes.
        handler String,             -- Request method in REST format.<HTTP method>.<subject>.
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
           'https://{{ s3-storage-host }}/bucket-logs/s3-logs/*',
           'JSONEachRow'
        );
     ```

  1. Click **Run**.

{% endlist %}

## Create a connection in {{ datalens-short-name }} {#create-connection}

{% list tabs %}

- Management console

  1. On the page of the created {{ CH }} cluster, in the menu on the left, go to the **{{ datalens-short-name }}** tab.
  1. In the window that opens, click **Create connection**.
  1. Fill in the connection settings:

     1. Add a connection name: `s3-logs-con`.
     1. In the **Cluster** field, select `s3-logs`.
     1. In the **Hostname** field, select the {{ CH }} host from the drop-down list.
     1. Enter the DB user's name and password.

  1. Click **Check connection**.
  1. After checking the connection, in the upper-right corner, click **Create**.

{% endlist %}

## Create a dataset in {{ datalens-short-name }} {#create-dataset}

1. In the window that appears in the lower-right corner, click **Create dataset**.
1. In the created dataset, move the `s3_data.s3logs` table to the workspace.
1. Go to the **Fields** tab.
1. Click ![image](../../_assets/plus-sign.svg)**Add field**.
1. Create a calculated field with the file type:
   
   * Field name: `object_type`.
   * Formula: `SPLIT([object_key], '.', -1)`.

1. Click **Create**.
1. In the upper-right corner, click **Save**.
1. Enter the dataset name `s3-dataset` and click **Create**.
1. When the dataset is saved, in the upper-right corner, click **Create chart**.

## Create charts in {{ datalens-short-name }} {#create-charts}

### Create the first chart {#create-pie-chart}

To visualize the number of requests to a bucket using different methods, create a pie chart:

1. For the visualization type, select **Pie chart**.
1. Drag the `method` field from the **Dimensions** section to the **Color** section.
1. Drag the `request_id` field from the **Dimensions** section to the **Measures** section.
1. In the upper right-hand corner, click **Save**.
1. In the window that opens, enter the name of the chart `S3 - Method pie` and click **Save**.

### Create the second chart {#create-column-chart}

To visualize the ratio of the number of requests by object type, create a bar chart:

1. Copy the chart from the previous step:

   1. In the upper-right corner, click the down arrow next to the **Save** button.
   1. Click **Save as**.
   1. In the window that opens, enter the name of the new chart `S3 - Object type bars` and click **Save**.

1. For the visualization type, choose **Column chart**. The `method` and `request_id` fields will automatically appear in the **X** and **Y** sections, respectively.
1. Delete the `method` field from the **X** section and drag the `object_type` field there.
1. In the upper right-hand corner, click **Save**.

### Create the third chart {#create-column-chart-2}

To visualize the distribution of outgoing traffic by day, create a bar chart:

1. Copy the chart from the previous step:

   1. In the upper-right corner, click the down arrow next to the **Save** button.
   1. Click **Save as**.
   1. In the window that opens, enter the name of the new chart `Traffic generated by days` and click **Save**.

1. Drag the `object_type` field from the **X** section to the **Chart filters** section.
1. In the window that opens, select the types of objects that you want to display in the chart and click **Apply filter**.
1. Drag the `timestamp` field from the **Dimensions** section to the **X** section.
1. Delete the `request_id` field from the **Y** section and drag the `bytes_send` the field there.
1. In the upper right-hand corner, click **Save**.

## Create a dashboard in {{ datalens-short-name }} and add charts there {#create-dashboard}

Create a dashboard to add charts to:

1. Go to the [main page]({{ link-datalens-main }}) {{ datalens-short-name }}.
1. Click **Create dashboard**.
1. Enter the name of the dashboard `S3 Logs Analysis` and click **Create**.
1. In the upper-right corner, click **Add** and choose **Chart**.
1. In the **Chart** field, click **Select** and choose the `S3 - Method pie` chart from the list.
1. Click **Add**. The chart is displayed on the dashboard.
1. Repeat the previous steps for the `S3 - Object type bars` and `S3 - Traffic generated by days` charts.

## How to delete created resources {#clear-out}

If you no longer need the created resources, delete the [bucket](../../storage/operations/buckets/delete.md) `bucket-logs` and the [cluster](../../managed-clickhouse/operations/cluster-delete.md) `s3-logs`.

