{{ yq-full-name }} is an interactive service for serverless data analysis. It enables you to process information from different storages without the need to create a dedicated cluster. The service supports working with [{{ objstorage-full-name }}](../../storage/), [{{ mpg-full-name }}](../../managed-postgresql/), and [{{ mch-full-name }}](../../managed-clickhouse/) data storages.

In this tutorial, you will connect to the {{ objstorage-name }} data source and run queries against it from the {{ jlab }}Lab notebook using {{ yq-name }}.

1. [Prepare your infrastructure](#infra).
1. [Get started in {{ yq-name }}](#yq-begin).
1. [Connect to the {{ objstorage-name }} data](#storage-connect).
1. [Configure data partitioning in {{ objstorage-name }}](#partitioning).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

For working with {{ objstorage-name }} data, the cost of infrastructure support includes:

* Fee for [{{ ml-platform-name }} computing resource](../../datasphere/pricing.md) usage.
* Fee for [storing data](../../storage/pricing.md#prices-storage) in a bucket.
* Fee for the amount of read data when executing [{{ yq-name }} queries](../../query/pricing.md).

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Give your folder a name, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the `data-folder` folder.
   1. In the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab, click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md), e.g., `yq-sa`.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following roles to the service account:
      * `datasphere.community-project.editor`: To run {{ ml-platform-name }} computations.
      * `yq.editor`: To send {{ yq-name }} queries.
      * `storage.viewer`: To view the contents of the {{ objstorage-name }} bucket and objects.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Add the service account to a project {#sa-to-project}

To enable the service account to run a {{ ml-platform-name }} project, add it to the list of project members.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab, click **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
1. Select the `yq-sa` account and click **{{ ui-key.yc-ui-datasphere.common.add }}**.

### Create an authorized key for a service account {#create-key}

To allow the service account to send {{ yq-name }} queries, create an [authorized key](../../iam/concepts/authorization/key.md).

{% include [disclaimer](../../_includes/iam/authorized-keys-disclaimer.md) %}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), go to `data-folder`.
   1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
   1. Select the `yq-sa` service account.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
   1. Select the encryption algorithm and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.

{% endlist %}

### Create a secret {#create-secret}

To get an authorized key from the notebook, create a [secret](../../datasphere/concepts/secrets.md) with the contents of the authorized key file.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. In the **{{ ui-key.yc-ui-datasphere.secret.name }}** field, enter the secret name: `yq_access_key`.
1. In the **{{ ui-key.yc-ui-datasphere.secret.content }}** field, paste the full contents of the downloaded file with the authorized key.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

### Create a notebook {#create-notebook}

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Click **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** and wait for the loading to complete.
1. In the top panel, click **File** and select **New** ⟶ **Notebook**.
1. Select a kernel and click **Select**.

## Get started in {{ yq-name }} {#yq-begin}

{% include [yq-begin](../../_tutorials/_tutorials_includes/yq-begin.md) %}

## Connect to data in {{ objstorage-name }} {#storage-connect}

As an example, let's take the data on New York Yellow Taxi rides. The data was pre-uploaded to an {{ objstorage-name }} public bucket named `yq-sample-data`, in the `nyc_taxi_csv` folder.

{% note info %}

{% include [yellow-taxi-disclaimer](../../_includes/datalens/yellow-taxi-disclaimer.md) %}

{% endnote %}

Create a {{ yq-name }} [connection](../../query/concepts/glossary.md#connection):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select `data-folder`.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
   1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
   1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-connection-form.action_create-new }}**.
   1. Enter a name for the connection, e.g., `storage-connection`.
   1. Select the **{{ ui-key.yql.yq-connection.object-storage.select-item }}** connection type and specify the **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * In the **{{ ui-key.yql.yq-connection-form.bucket-auth.input-label }}** field, select `{{ ui-key.yql.yq-connection-form.public.button-text }}` and specify the bucket name.
      * Enter the name of the bucket: `yq-sample-data`.

   1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

{% endlist %}

### Create a data binding {#create-binding}

A data [binding](../../query/concepts/glossary.md#binding) contains information about file formats and locations in the bucket, as well as a list of data fields and their types. {{ yq-name }} can process data in CSV, TSV, Json, and Parquet formats. For data in CSV, TSV, Json formats, you can additionally use an external archiver: gzip, zstd, and others. For data in Parquet format, Snappy, LZ4, ZSTD, and other compression types are supported.

To create a data binding:

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select `data-folder`.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
   1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
   1. Click ![info](../../_assets/console-icons/plus.svg) **{{ ui-key.yql.yq-binding-add.create-binding.button-text }}**.
   1. Under **{{ ui-key.yql.yq-binding-form.connection-parameters.title }}**:

      * **{{ ui-key.yql.yq-binding-form.connection-type.title }}**: Select **{{ ui-key.yql.yq-connection.object-storage.select-item }}**.
      * **{{ ui-key.yql.yq-binding-form.connection.title }}**: Select `storage-connection`.

   1. Under **{{ ui-key.yql.yq-binding-form.binding-parameters.title }}**:

      1. Enter a name for the binding, e.g., `yq_binding`.
      1. In the **{{ ui-key.yql.yq-binding-form.binding-path-pattern.title }}** field, specify the [path to the data](../../query/sources-and-sinks/object-storage.md#path_format): `nyc_taxi_sample/data/`.
      1. Select the compression type: `gzip`.

   1. Under **{{ ui-key.yql.yq-binding-form.binding-format-settings.title }}**, select `csv_with_names` in the **{{ ui-key.yql.yq-binding-form.binding-format.title }}** field.

   1. Under **{{ ui-key.yql.yq-binding-form.binding-fields.title }}**, add two columns with the following names and data types:

      * `tpep_pickup_datetime`: `DATETIME`
      * `trip_distance`: `DOUBLE`

   1. To verify that the specified data is correct, click **{{ ui-key.yql.yq-binding-form.binding-preview.button-text }}**. The table should appear below.
   1. Click **{{ ui-key.yql.yq-binding-form.binding-create.button-text }}**.

{% endlist %}

To check the connection, get the table data from the notebook cell:

```sql
%yq SELECT * FROM yq_binding LIMIT 100;
```

## Configure partitioning in {{ objstorage-name }} {#partitioning}

In {{ yq-name }}, you can significantly reduce query time if you set up rules for [partitioning](../../query/concepts/partitioning.md) (placing) data in {{ objstorage-name }} to read only the required data. For example, if files in a bucket are sorted in folders by year, {{ yq-name }} will only look for data in the specified folders when queried.

{{ yq-name }} supports two options for specifying data placement rules: [Hive partitioning](../../query/concepts/partitioning.md#formats) and [Partition projection](../../query/concepts/partition-projection.md).

### Hive partitioning {#hive}

In Apache Hive™, data is placed in a folder structure in `key=value/key2=value2/...` format. This format is used in systems originally built around the Apache Hadoop™ ecosystem, such as Apache Spark™.

For example, data from the Yellow Taxi dataset is placed in folders according to the Hive partitioning rules:

* `year=2021/month=1/...`
* `year=2021/month=2/...`
* ...
* `year=2022/month=1/...`
* `year=2022/month=2/...`

Configure Hive partitioning:

1. Clone the `yq_binding` data binding:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select `data-folder`.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
      1. In the left-hand panel, click **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
      1. In the line with `yq_binding`, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yql.yq-binding-actions.clone-binding.menu-item-text }}**.
      1. Enter a name for the binding: `yq_tutorial_hive_partitioned`.
      1. Under **{{ ui-key.yql.yq-schema.schema-partitioning.section-header }}**:

         1. Select **{{ ui-key.yql.yq-binding-form.projection-radio.disabled.label }}**.
         1. Add a column named `year` with the `UINT32` data type.
         1. Add a column named `month` with the `UINT32` data type.

      1. Click **{{ ui-key.yql.yq-binding-form.binding-modify.button-text }}**.

   {% endlist %}

1. To check the result, run the following query:

   ```sql
   %yq SELECT * FROM yq_tutorial_hive_partitioned WHERE year=2021
   ```

### Partition projection {#explicit}

Sometimes data in {{ objstorage-name }} is placed according to unique rules. In such cases, you can use [partition projection](../../query/concepts/partition-projection.md) to specify your own data path template.

When using partition projection, you need to describe each component of the `year` and `month` path separately, specifying the ranges of their values. Then you need to specify the path template in the {{ objstorage-name }} bucket that stores the data.

Configure partition projection:

1. Clone the `yq_binding` data binding:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select `data-folder`.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
      1. In the left-hand panel, click **{{ ui-key.yql.yq-ide-aside.bindings.tab-text }}**.
      1. In the line with `yq_binding`, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yql.yq-binding-actions.clone-binding.menu-item-text }}**.
      1. Enter a name for the binding: `yq_tutorial_partition_projection`.
      1. Under **{{ ui-key.yql.yq-schema.schema-partitioning.section-header }}**:

         1. Select **{{ ui-key.yql.yq-binding-form.projection-radio.enabled.label }}**.
         1. Add a column named `year` with the `UINT32` data type:
            * **{{ ui-key.yql.yq-binding-form.projection-format-type.title }}**: `integer`
            * **{{ ui-key.yql.yq-binding-form.projection-int-interval.title }}**:
               * **{{ ui-key.yql.yq-binding-form.projection-date-interval-min.placeholder }}**: `2019`
               * **{{ ui-key.yql.yq-binding-form.projection-date-interval-max.placeholder }}**: `2024`
               * **{{ ui-key.yql.yq-binding-form.projection-date-interval-step.title }}**: 1
            * **{{ ui-key.yql.yq-binding-form.projection-int-fixed-width.title }}**: 2
         1. Add a column named `month` with the `UINT32` data type:
            * **{{ ui-key.yql.yq-binding-form.projection-format-type.title }}**: `integer`
            * **{{ ui-key.yql.yq-binding-form.projection-int-interval.title }}**:
               * **{{ ui-key.yql.yq-binding-form.projection-date-interval-min.placeholder }}**: `1`
               * **{{ ui-key.yql.yq-binding-form.projection-date-interval-max.placeholder }}**: `12`
               * **{{ ui-key.yql.yq-binding-form.projection-date-interval-step.title }}**: 1
            * **{{ ui-key.yql.yq-binding-form.projection-int-fixed-width.title }}**: 2

      1. Click **{{ ui-key.yql.yq-binding-form.binding-modify.button-text }}**.

   {% endlist %}

1. To check the result, run the following query:

   ```sql
   %yq SELECT * FROM yq_tutorial_partition_projection WHERE year=2021
   ```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the bucket](../../storage/operations/buckets/delete.md).
* [Delete the project](../../datasphere/operations/projects/delete).