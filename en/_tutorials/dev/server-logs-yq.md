# Getting statistics on queries to {{ objstorage-full-name }} objects using {{ yq-full-name }}


In this tutorial, you will learn how to get statistics on queries to [{{ objstorage-full-name }}](../../storage/) objects using [{{ yq-full-name }}](../../query/). You will create a bucket and configure logging in {{ objstorage-name }}, set up a connection in {{ yq-name }}, and get statistics using SQL queries.

To get statistics:

1. [Get your cloud ready](#before-you-begin).
1. [Create buckets](#create-buckets).
1. [Enable logging](#enable-logging).
1. [Configure connections in {{ yq-name }}](#create-connection).
1. [Get statistics on queries](#get-statistics).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for data storage  (see [{{ objstorage-full-name }} pricing](../../storage/pricing.md)).
* Fee for the amount of read data (see [{{ yq-full-name }} pricing](../../query/pricing.md)).

### Create a service account {#create-sa}

With a service account, {{ yq-name }} will be able to send queries to {{ objstorage-name }}.

[Create](../../iam/operations/sa/create.md) a service account named `yq-sa` and [assign](../../iam/operations/roles/grant.md) the `storage.viewer` and `yq.editor` roles to it.

## Create buckets {#create-buckets}

Create two buckets: `object-bucket` and `logs-bucket`. One bucket will serve as a data source, and the other, as a log storage. 

To create a bucket:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter the bucket name: `object-bucket`.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

  Similarly, create a bucket named `logs-bucket`.

{% endlist %}

## Enable logging {#enable-logging}

To get information on queries to objects, enable [logging actions on the bucket](../../storage/concepts/server-logs.md):

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you created the bucket.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Select `object-bucket`.
  1. [Enable logging](../../storage/operations/buckets/enable-logging.md#enable):

      1. In the left-hand panel, select ![image](../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
      1. Navigate to the **{{ ui-key.yacloud.storage.bucket.switch_server-logs }}** tab.
      1. Enable **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_server-logs_mfGpj }}**.
      1. In the **{{ ui-key.yacloud.storage.form.BucketServerLogsFormContent.label_target-bucket_jEJ5E }}** field, select `logs-bucket`.
      1. Click **{{ ui-key.yacloud.common.save }}**.

  1. In the left-hand panel, select ![image](../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}** and [upload](../../storage/operations/objects/upload.md) your objects. For example, you can upload a couple of simple text files.

{% endlist %}

## Configure connections in {{ yq-name }} {#create-connection}

To get data from {{ objstorage-name }}, create a [connection](../../query/concepts/glossary.md#connection) and [binding](../../query/concepts/glossary.md#binding):

{% list tabs group=instructions %}

- {{ yq-full-name }} interface {#console}

  1. Go to [{{ yq-name }}](https://yq.yandex.cloud/).
  1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Enter a name for the connection, e.g., `bucket-logs-connection`.
  1. Select the **{{ ui-key.yql.yq-connection.action_object-storage }}** connection type and specify the **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**.
  1. In the **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}** field, select `{{ ui-key.yql.yq-connection-form.private.button-text }}` and set these properties:

      * **{{ ui-key.yql.yq-connection-form.cloud.input-label }}**: Select the cloud and folder where you created your buckets.
      * **{{ ui-key.yql.yq-connection-form.bucket.input-label }}**: `logs-bucket`.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: `yq-sa`.

  1. Click **{{ ui-key.yql.yq-connection-form.test.button-text }}**. After a successful test, click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.
  1. Click **{{ ui-key.yql.yq-binding-form.binding-fields-templates.button.label }}** and select **Object Storage Access Logs** from the drop-down list.

      1. Enter a name for the binding, e.g., `bucket-logs-binding`.
      1. In the **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** field, specify the path to the statistics within the bucket. If the statistics are stored in the bucket root directory, specify `/`.
      1. Click **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}** to verify the settings are correct.
      1. Click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}** to complete creating the binding.

{% endlist %}

## Get statistics on queries {#get-statistics}

Use a connection to create SQL queries and get statistics on queries to {{ objstorage-name }} objects:

{% list tabs group=instructions %}

- {{ yq-full-name }} interface {#console}

  1. Go to [{{ yq-name }}](https://yq.yandex.cloud/).
  1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Select `bucket-logs-connection`.
  1. In the editor on the right, enter this query:

      ```sql
      SELECT `timestamp`, request_id, handler, object_key, status, request_time
      FROM `bucket-logs-binding`
      LIMIT 100;
      ```

      This query will return 100 records of statistics on queries to {{ objstorage-name }} objects. You can remove the record limit and filter results using `WHERE`.

  1. Click ![image](../../_assets/console-icons/play-fill.svg) **{{ ui-key.yql.yq-query-actions.run-query.button-text }}** and check the results.

{% endlist %}

### Query examples {#examples}

#### Searching for queries by response code {#request-code}

```sql
SELECT `timestamp`, request_id, handler, object_key, status, request_time
FROM `bucket-logs-binding`
WHERE status >= 400
```

#### Searching for long-running queries {#request-long}

```sql
SELECT `timestamp`, request_id, handler, object_key, status, request_time
FROM `bucket-logs-binding`
WHERE request_time >= 1000
```

#### Average query processing time {#request-average}

This tutorial features the `AVG` aggregate function.

```sql
SELECT AVG(request_time) AS `avg` FROM `bucket-logs-binding`
```

## How to delete the resources you created {#clear-out}

To shut down the infrastructure and stop paying for the resources you created:

1. [Delete](../../query/operations/binding.md#delete) the binding.
1. [Delete](../../query/operations/connection.md#delete) the connection.
1. [Delete](../../storage/operations/objects/delete.md) the objects from the buckets.
1. [Delete](../../storage/operations/buckets/delete.md) the buckets.
