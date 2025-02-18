{{ yq-full-name }} is an interactive service for serverless data analysis. It enables you to process information from different storages without the need to create a dedicated cluster. The service supports working with [{{ objstorage-full-name }}](../../storage/), [{{ mpg-full-name }}](../../managed-postgresql/), and [{{ mch-full-name }}](../../managed-clickhouse/) data storages.

Follow this tutorial to connect to a {{ mpg-name }} database and query it from a {{ jlab }}Lab notebook with the help of {{ yq-name }}.

1. [Prepare the infrastructure](#infra).
1. [Get started in {{ yq-name }}](#yq-begin).
1. [Create a {{ mpg-name }} cluster](#create-cluster).
1. [Connect to the {{ mpg-name }} data](#mch-connect).

If you no longer need the resources you created, [delete them](#clear-out).


## Getting started {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin-datasphere.md) %}

### Required paid resources {#paid-resources}

For working with {{ mpg-name }} data, the cost of infrastructure support includes:

* Fee for [{{ ml-platform-name }} computing resource](../../datasphere/pricing.md) usage.
* Fee for a running [{{ mpg-name }}](../../managed-postgresql/pricing.md) cluster.
* Fee for the amount of read data when executing [{{ yq-name }} queries](../../query/pricing.md).

## Prepare the infrastructure {#infra}

{% include [intro](../../_includes/datasphere/infra-intro.md) %}

{% include [intro](../../_includes/datasphere/federation-disclaimer.md) %}

### Create a folder {#create-folder}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a cloud and click ![create](../../_assets/console-icons/plus.svg)**{{ ui-key.yacloud.component.console-dashboard.button_action-create-folder }}**.
   1. Name your folder, e.g., `data-folder`.
   1. Click **{{ ui-key.yacloud.iam.cloud.folders-create.button_create }}**.

{% endlist %}

### Create a service account for the {{ ml-platform-name }} project {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to `data-folder`.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. Enter a name for the [service account](../../iam/concepts/users/service-accounts.md), e.g., `yq-sa`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and assign the following roles to the service account:
     * `yq.editor`: To run {{ yq-name }} queries.
     * `managed-postgresql.viewer`: To view the contents of the {{ mpg-name }} cluster.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

{% endlist %}

### Add the service account to a project {#sa-to-project}

To enable the service account to run a {{ ml-platform-name }} project, add it to the list of project members.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. In the **{{ ui-key.yc-ui-datasphere.project-page.tab.members }}** tab, click **{{ ui-key.yc-ui-datasphere.common.add-member }}**.
1. Select the `yq-sa` account and click **{{ ui-key.yc-ui-datasphere.common.add }}**. 
1. Change your service account role to **Editor**.


### Create an authorized key for a service account {#create-key}

To allow the service account to send {{ yq-name }} queries, create an [authorized key](../../iam/concepts/authorization/key.md).

{% include [yq-begin](../../_tutorials/_tutorials_includes/yq-begin.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), go to `data-folder`.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
  1. In the list that opens, select the `yq-sa` service account.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel and select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_key }}**.
  1. Select the encryption algorithm and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.action_download-keys-file }}**.

{% endlist %}

### Create a secret {#create-secret}

To get an authorized key from the notebook, create a [secret](../../datasphere/concepts/secrets.md) with the contents of the authorized key file.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Under **{{ ui-key.yc-ui-datasphere.project-page.project-resources }}**, click ![secret](../../_assets/console-icons/shield-check.svg)**{{ ui-key.yc-ui-datasphere.resources.secret }}**.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.
1. In the **{{ ui-key.yc-ui-datasphere.secret.name }}** field, enter the name for the secret: `yq_access_key`.
1. In the **{{ ui-key.yc-ui-datasphere.secret.content }}** field, paste the full contents of the downloaded file with the authorized key.
1. Click **{{ ui-key.yc-ui-datasphere.common.create }}**.

### Create a notebook {#create-notebook}

Queries to the {{ mpg-name }} database through {{ yq-name }} will be sent from the notebook.

1. {% include [find project](../../_includes/datasphere/ui-find-project.md) %}
1. Click **{{ ui-key.yc-ui-datasphere.project-page.project-card.go-to-jupyter }}** and wait for the loading to complete.
1. In the top panel, click **File** and select **New** ⟶ **Notebook**.
1. Select a kernel and click **Select**.

## Get started in {{ yq-name }} {#yq-begin}

{% include [yq-begin](../../_tutorials/_tutorials_includes/yq-begin.md) %}

## Create a {{ mpg-name }} cluster {#create-cluster}

Any running {{ mpg-name }} cluster with the **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** option enabled is suitable for sending queries.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select `data-folder`.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
  1. In the **{{ ui-key.yacloud.mdb.forms.base_field_name }}** field, enter the cluster name, e.g., `postgresql`.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_database }}**:
     * Specify the **{{ ui-key.yacloud.mdb.forms.database_field_name }}**, e.g., `db1`.
     * Specify **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** and **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}**.
  1. Under **{{ ui-key.yacloud.mdb.forms.section_service-settings }}**, enable **{{ ui-key.yacloud.mdb.forms.additional-field-yandex-query_ru }}** and **{{ ui-key.yacloud.mdb.forms.additional-field-websql }}**.
  1. You can leave the other settings at their defaults.
  1. Click **{{ ui-key.yacloud.mdb.forms.button_create }}**.

{% endlist %}

### Create a table {#create-table}

In this step, you will create a test table with random numbers from 0 to 100.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the `postgresql` cluster page in the [management console]({{ link-console-main }}) and go to the **{{ ui-key.yacloud.postgresql.cluster.switch_explore }}** tab.
  1. Enter **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}** and **{{ ui-key.yacloud.mdb.forms.database_field_user-password }}** you specified when creating the cluster.
  1. In the input window on the right, paste an SQL query:

     ```sql
     CREATE TABLE test (
         id SERIAL PRIMARY KEY,
         number INT
     );
 
     INSERT INTO test (number)
     SELECT random() * 100
     FROM generate_series(1, 100);
     ```

  1. Click **Execute**.

{% endlist %}

## Connect to data in {{ mpg-name }} {#mch-connect}

To create a {{ yq-name }} [connection](../../query/concepts/glossary.md#connection):

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select `data-folder`.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_yq_ru }}**.
  1. In the left-hand panel, select **{{ ui-key.yql.yq-ide-aside.connections.tab-text }}**.
  1. Click ![info](../../_assets/console-icons/plus.svg)**{{ ui-key.yql.yq-connection-form.action_create-new }}**.
  1. Enter a name for the connection, e.g., `postgresql`.
  1. Select the **{{ ui-key.yql.yq-connection.action_postgersql }}** connection type.
  1. Under **{{ ui-key.yql.yq-connection-form.connection-type-parameters.section-title }}**:

     * **{{ ui-key.yql.yq-connection-form.cluster.input-label }}**: Select the previously created `postgresql` cluster.
     * **{{ ui-key.yql.yq-connection-form.service-account.input-label }}**: `yq-sa`.
     * **{{ ui-key.yql.yq-connection-form.database.input-label }}**: `db1`.
     * Enter **{{ ui-key.yql.yq-connection-form.login.input-label }}** and **{{ ui-key.yql.yq-connection-form.password.input-label }}** you specified when creating the cluster.

  1. Click **{{ ui-key.yql.yq-connection-form.create.button-text }}**.

{% endlist %}

To check the connection, get the table data from the notebook cell:

```sql
%yq SELECT * FROM postgresql.test
```

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the database cluster](../../managed-postgresql/operations/cluster-delete.md).
* [Delete the project](../../datasphere/operations/projects/delete.md).
