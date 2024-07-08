{{ yq-full-name }} is an interactive service for serverless data analysis. It enables you to process information from different storages without the need to create a dedicated cluster. The service supports working with [{{ objstorage-full-name }}](../../storage/), [{{ mpg-full-name }}](../../managed-postgresql/), and [{{ mch-full-name }}](../../managed-clickhouse/) data storages.

In this tutorial, you will connect to the {{ mch-name }} database and run queries against it from the {{ jlab }}Lab notebook using {{ yq-name }}.

1. [Prepare your infrastructure](#infra).
1. [Get started in {{ yq-name }}](#yq-begin).
1. [Create a {{ mch-name }} cluster](#create-cluster).
1. [Connect to the {{ mch-name }} data](#mch-connect).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

For working with {{ mch-name }} data, the cost of infrastructure support includes:

* Fee for [{{ ml-platform-name }} computing resource](../../datasphere/pricing.md) usage.
* Fee for a running [{{ mch-name }}](../../managed-clickhouse/pricing.md) cluster.
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
      * `managed-clickhouse.viewer`: To view the contents of the {{ mch-name }} cluster.
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

Queries to the {{ mch-name }} database through {{ yq-name }} will be sent from the notebook.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Click **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** and wait for the loading to complete.
1. In the top panel, click **File** and select **New** ⟶ **Notebook**.
1. Select a kernel and click **Select**.

## Getting started with {{ yq-name }} {#yq-begin}

{% include [yq-begin](../../_tutorials/_tutorials_includes/yq-begin.md) %}

## Create a {{ mch-name }} cluster {#create-cluster}

Any running {{ mch-name }} cluster with the **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** option enabled is suitable for sending queries.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select `data-folder`.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
   1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
   1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter a name for the cluster, e.g., `clickhouse`.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_settings }}**:

      * In the **{{ ui-key.yacloud.mdb.forms.database_field_sql-user-management }}** field, select **{{ ui-key.yacloud.common.enabled }}** from the drop-down list.
      * Specify **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** and **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**.

   1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**:

      * Select the `yq-sa` service account.
      * Enable the **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** and **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}** options.

   1. You may leave default values for the other settings.
   1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

### Create a table {#create-table}

In this step, you will create a test table with numbers from 0 to 100.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), open the `clickhouse` cluster page, and go to the **{{ ui-key.yacloud.clickhouse.cluster.switch_explore }}** tab.
   1. Enter **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** and **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** you specified when creating the cluster.
   1. In the input window on the right, paste an SQL query:

      ```sql
      CREATE TABLE test(col1 int)
          ENGINE = MergeTree
              ORDER BY col1;

      INSERT INTO test
      SELECT
          *
      FROM numbers(100)
      ```

   1. Click **{{ ui-key.yacloud.clickhouse.cluster.explore.button_execute }}**.

{% endlist %}

## Connect to data in {{ mch-name }} {#mch-connect}

To create a {{ yq-name }} [connection](../../query/concepts/glossary.md#connection):

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select `data-folder`.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
   1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
   1. Click ![info](../../_assets/console-icons/plus.svg)**{{ ui-key.yql.yq-connection-form.action_create-new }}**.
   1. Enter a name for the connection, e.g., `clickhouse`.
   1. Select the **{{ ui-key.yql.yq-connection.action_clickhouse }}** connection type.
   1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

      * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select the previously created `clickhouse` cluster.
      * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: Select the `yq-sa` service account.
      * Enter **{{ ui-key.yql.yq-connection-form.login.input-label }}** and **{{ ui-key.yql.yq-connection-form.password.input-label }}** specified when you created the cluster.

   1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

{% endlist %}

To check the connection, get the table data from the notebook cell:

```sql
%yq SELECT * FROM clickhouse.test
```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the database cluster](../../managed-clickhouse/operations/cluster-delete.md).
* [Delete the project](../../datasphere/operations/projects/delete.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}